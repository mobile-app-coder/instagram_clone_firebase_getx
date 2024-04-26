import 'package:get/get.dart';
import 'package:instagram_clone_firebase_getx/controllers/feed_controller.dart';
import 'package:instagram_clone_firebase_getx/controllers/like_controller.dart';
import 'package:instagram_clone_firebase_getx/controllers/profile_controller.dart';
import 'package:instagram_clone_firebase_getx/controllers/search_page_controller.dart';
import 'package:instagram_clone_firebase_getx/controllers/upload_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeedController(), fenix: true);
    Get.lazyPut(() => UploadController(), fenix: true);
    Get.lazyPut(() => SearchPageController(), fenix: true);
    Get.lazyPut(() => LikePageController(), fenix: true);
    Get.lazyPut(() => ProfilePageController(), fenix: true);
  }
}
