import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/member_model.dart';
import '../models/post_model.dart';
import '../pages/sign_in_page.dart';
import '../services/auth_service.dart';
import '../services/db_service.dart';
import '../services/file_service.dart';
import '../services/log_service.dart';
import '../services/util_service.dart';

class ProfilePageController extends GetxController {
  bool isLoading = false;
  int axisCount = 2;
  List<Post> items = [];
  File? _image;
  bool isList = false;
  String fullName = "", email = "", img_url = "";
  int count_posts = 0, count_followers = 0, count_following = 0;
  final ImagePicker picker = ImagePicker();

  imageFromGallery() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    _image = File(image!.path);
    update();
    apiChangePhoto();
  }

  imageFromCamera() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    _image = File(image!.path);
    update();

    apiChangePhoto();
  }

  dialogLogout(BuildContext context) async {
    var result = await Utils.dialogCommon(
        context, "Instagram", "Do you want to logout?", false);
    if (result) {
      isLoading = true;
      update();

      _signOutUser(context);
    }
  }

  dialogRemovePost(Post post, BuildContext context) async {
    var result = await Utils.dialogCommon(
        context, "Instagram", "Do you want to detele this post?", false);
    if (result) {
      isLoading = true;
      update();

      DBService.removePost(post).then((value) => {
            apiLoadPosts(),
          });
    }
  }

  void _showMemberInfo(Member member) {
    isLoading = false;
    fullName = member.fullname;
    email = member.email;
    img_url = member.img_url;
    count_following = member.following_count;
    count_followers = member.followers_count;
    update();
  }

  _resLoadPosts(List<Post> posts) {
    items = posts;
    count_posts = posts.length;
    update();
  }

  apiLoadPosts() {
    DBService.loadPosts().then((value) => {
          _resLoadPosts(value),
        });
  }

  _signOutUser(BuildContext context) {
    AuthService.signOutUser(context);
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  void apiLoadMember() {
    isLoading = true;
    update();

    DBService.loadMember().then((value) => {
          _showMemberInfo(value),
        });
  }

  apiUpdateMember(String downloadUrl) async {
    Member member = await DBService.loadMember();
    member.img_url = downloadUrl;
    await DBService.updateMember(member);
    apiLoadMember();
  }

  apiChangePhoto() {
    if (_image == null) return;

    isLoading = true;
    LogService.i("image");
    update();

    FileService.uploadUserImage(_image!).then((downloadUrl) => {
          apiUpdateMember(downloadUrl),
        });
  }

  changeCount(int i){
    axisCount = i;
    update();
  }
}
