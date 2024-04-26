import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:instagram_clone_firebase_getx/controllers/feed_controller.dart';

import '../models/post_model.dart';
import '../views/feed_post_item.dart';

class MyFeedPage extends StatefulWidget {
  final PageController? pageController;

  const MyFeedPage({super.key, this.pageController});

  @override
  State<MyFeedPage> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  final _controller = Get.find<FeedController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.apiLoadFeeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Instagram",
            style: TextStyle(
                color: Colors.black, fontSize: 39, fontFamily: "Billabong")),
        actions: [
          IconButton(
              onPressed: () {
                widget.pageController!.animateToPage(2,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              icon: Icon(Icons.camera_alt))
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: _controller.items.length,
              itemBuilder: (ctx, index) {
                return itemPost(_controller.items[index], context, _controller);
              })
        ],
      ),
    );
  }


}
