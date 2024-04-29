import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_firebase_getx/controllers/like_controller.dart';

import '../views/post_item.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({super.key});

  @override
  State<LikesPage> createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  final _controller = Get.find<LikePageController>();

  @override
  void initState() {
    super.initState();
    _controller.apiLoadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LikePageController>(
        builder: (_) {
          return Stack(
            children: [
              ListView.builder(
                itemCount: _controller.items.length,
                itemBuilder: (context, index) {
                  return itemOfPost(
                      _controller.items[index], context, _controller);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
