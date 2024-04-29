import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase_getx/controllers/upload_controller.dart';

void showPicker(BuildContext context, UploadController controller) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
            child: Container(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text("Pick Photo"),
                onTap: () {
                  controller.imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Pick Photo"),
                onTap: () {
                  controller.imgFromGallery();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ));
      });
}
