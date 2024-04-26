import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase_getx/controllers/profile_controller.dart';

import '../models/post_model.dart';

Widget itemPost(
    Post post, BuildContext context, ProfilePageController _controller) {
  return GestureDetector(
    onLongPress: () {
      _controller.dialogRemovePost(post, context);
    },
    child: Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(
              child: CachedNetworkImage(
            width: double.infinity,
            imageUrl: post.img_post,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.cover,
          )),
          SizedBox(
            height: 3,
          ),
          Text(
            post.caption,
            style: TextStyle(
              color: Colors.black87.withOpacity(0.7),
            ),
            maxLines: 2,
          )
        ],
      ),
    ),
  );
}

void showPicker(context, ProfilePageController _controller) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Pick Photo'),
                    onTap: () {
                      _controller.imageFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Take Photo'),
                  onTap: () {
                    _controller.imageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
