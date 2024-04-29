import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_firebase_getx/controllers/feed_controller.dart';

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
        body: GetBuilder<FeedController>(
          builder: (_) {
            return Stack(
              children: [
                ListView.builder(
                    itemCount: _controller.items.length,
                    itemBuilder: (ctx, index) {
                      return itemPost(
                        _controller.items[index],
                        context,
                        _controller,
                      );
                    })
              ],
            );
          },
        ));
  }
}
