import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase_getx/controllers/like_controller.dart';

import '../models/post_model.dart';

Widget itemOfPost(Post post, BuildContext context, LikePageController controller) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Divider(),
        //#user info
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: post.img_user.isEmpty
                        ? const Image(
                        image: AssetImage(
                          "assets/images/img.png",
                        ),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover)
                        : Image.network(
                      post.img_user,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.fullname,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        post.date,
                        style: TextStyle(fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
              post.mine
                  ? IconButton(onPressed: () {
                controller.dialogRemovePost(post, context);
              }, icon: Icon(Icons.more_horiz))
                  : SizedBox.shrink()
            ],
          ),
        ),

        //#post image
        CachedNetworkImage(
          imageUrl: post.img_post,
          width: MediaQuery.of(context).size.width,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),

        //#like share
        Row(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      controller.apiPostUnLike(post);
                    },
                    icon: post.liked
                        ? const Icon(
                      EvaIcons.heart,
                      color: Colors.red,
                    )
                        : const Icon(
                      EvaIcons.heartOutline,
                      color: Colors.black,
                    )),
                IconButton(onPressed: () {

                }, icon: const Icon(EvaIcons.share))
              ],
            )
          ],
        ),

        //#caption
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: RichText(
            overflow: TextOverflow.visible,
            softWrap: true,
            text: TextSpan(
                text: "${post.caption}",
                style: TextStyle(color: Colors.black)),
          ),
        )
      ],
    ),
  );
}