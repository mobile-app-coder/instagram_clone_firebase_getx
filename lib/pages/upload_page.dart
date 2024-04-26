import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_firebase_getx/controllers/upload_controller.dart';

import '../views/image_picker.dart';

class UploadPage extends StatefulWidget {
  final PageController? pageController;

  const UploadPage({super.key, this.pageController});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _controller = Get.find<UploadController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Upload",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _controller.uploadNewPost(widget.pageController!);
              });
            },
            icon: Icon(Icons.drive_folder_upload),
            color: Color.fromRGBO(193, 53, 132, 1),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showPicker(context, widget.pageController);
                    },
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width,
                      color: Colors.grey.withOpacity(0.4),
                      child: _controller.image == null
                          ? const Center(
                              child: Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.grey,
                              ),
                            )
                          : Stack(
                              children: [
                                Image.file(
                                  _controller.image!,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.black12,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              _controller.image = null;
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.highlight_remove,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: TextField(
                      controller: _controller.captionController,
                      style: TextStyle(color: Colors.black),
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Caption",
                          hintStyle:
                              TextStyle(fontSize: 17, color: Colors.black38)),
                    ),
                  )
                ],
              ),
            ),
          ),
          _controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
