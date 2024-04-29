import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post_model.dart';
import '../services/db_service.dart';
import '../services/file_service.dart';

class UploadController extends GetxController {
  bool isLoading = false;
  var captionController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? image;

  moveToFeed(PageController controller) {
    isLoading = false;
    update();
    captionController.text = "";
    image = null;
    controller.animateToPage(0,
        duration: Duration(microseconds: 200), curve: Curves.easeIn);
  }

  imgFromGallery() async {
    XFile? img = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    image = File(img!.path);
    update();
  }

  imgFromCamera() async {
    XFile? img = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    image = File(img!.path);
    update();
  }

  uploadNewPost(PageController pageController) {
    String caption = captionController.text.toString().trim();
    if (caption.isEmpty) return;
    if (image == null) return;
    _apiPostImage(pageController);
  }

  void _apiPostImage(PageController pageController) {
    isLoading = true;
    update();
    FileService.uploadPostImage(image!).then(
      (downloadUrl) => {
        _resPostImage(downloadUrl, pageController),
      },
    );
  }

  void _resPostImage(String downloadUrl, PageController pageController) {
    String caption = captionController.text.toString().trim();
    Post post = Post(caption, downloadUrl);
    _apiStorePost(post, pageController);
  }

  void _apiStorePost(Post post, PageController pageController) async {
    // Post to posts
    Post posted = await DBService.storePost(post);
    // Post to feeds
    DBService.storeFeed(posted).then(
      (value) => {
        moveToFeed(pageController),
      },
    );
  }
}
