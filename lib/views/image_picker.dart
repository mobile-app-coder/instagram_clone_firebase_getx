import 'package:flutter/material.dart';

void showPicker(context, _controller) {
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
                  _controller.imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Pick Photo"),
                onTap: () {
                  _controller.imgFromGallery();
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ));
      });
}
