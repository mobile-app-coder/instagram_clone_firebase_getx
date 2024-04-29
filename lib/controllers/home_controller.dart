import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  PageController? pageController;
  int currentPage = 0;

  onPageChange(int index) {
    currentPage = index;
    update();
  }

  onBottomChange(int index) {
    currentPage = index;
    update();

    pageController!.animateToPage(currentPage,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    update();
  }
}
