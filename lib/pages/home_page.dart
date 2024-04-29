import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_firebase_getx/controllers/home_controller.dart';
import 'package:instagram_clone_firebase_getx/pages/profile_page.dart';
import 'package:instagram_clone_firebase_getx/pages/search_page.dart';
import 'package:instagram_clone_firebase_getx/pages/upload_page.dart';

import 'feed_page.dart';
import 'likes_page.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Get.find<HomeController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
        body: PageView(
          controller: _controller.pageController,
          children: [
            MyFeedPage(
              pageController: _controller.pageController,
            ),
            SearchPage(),
            UploadPage(
              pageController: _controller.pageController,
            ),
            LikesPage(),
            ProfilePage()
          ],
          onPageChanged: (int index) {
            _controller.onPageChange(index);
          },
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _controller.currentPage,
          onTap: (int index) {
            _controller.onBottomChange(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_box,
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 32,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 32,
              ),
            )
          ],
        ),
      );
    });
  }
}
