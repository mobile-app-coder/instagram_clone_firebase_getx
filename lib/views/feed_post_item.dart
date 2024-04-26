import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_firebase_getx/controllers/feed_controller.dart';

import '../models/post_model.dart';

Widget itemPost(Post post, BuildContext context, FeedController _controller) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Divider(),
        //user info
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
                        image: AssetImage("assets/images/img.png"),
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )
                          : Image.network(
                        post.img_user,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.fullname,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        post.date,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ],
              ),
              post.mine
                  ? IconButton(
                  onPressed: () {
                    _controller.dialogRemovePost(post, context);
                  },
                  icon: Icon(Icons.more_horiz))
                  : const SizedBox.shrink()
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CachedNetworkImage(
          width: MediaQuery.of(context).size.width,
          imageUrl: post.img_post,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),

        //like share
        Row(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      if (!post.liked) {
                        _controller.apiPostLike(post);
                      } else {
                        _controller.apiPostUnLike(post);
                      }
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    EvaIcons.shareOutline,
                  ),
                ),
              ],
            )
          ],
        ),

        //caption
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: RichText(
            softWrap: true,
            overflow: TextOverflow.visible,
            text: TextSpan(
                text: "${post.caption}",
                style: TextStyle(color: Colors.black)),
          ),
        )
      ],
    ),
  );
}