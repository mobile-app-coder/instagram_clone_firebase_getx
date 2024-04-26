import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/post_model.dart';
import '../services/db_service.dart';
import '../services/util_service.dart';

class LikePageController extends GetxController {
  bool isLoading = false;
  List<Post> items = [];

  void apiLoadLikes() {
    isLoading = true;
    update();
    DBService.loadLikes().then((value) => {
          _resLoadPost(value),
        });
  }

  dialogRemovePost(Post post, BuildContext context) async {
    var result = await Utils.dialogCommon(
        context, "Instagram", "Do you want to detele this post?", false);

    if (result) {
      isLoading = true;
      update();
      DBService.removePost(post).then((value) => {
            apiLoadLikes(),
        update()
          });
    }
    update();
  }

  void _resLoadPost(List<Post> posts) {
    items = posts;
    isLoading = false;
    update();
  }

  void apiPostUnLike(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, false);
    update();
    apiLoadLikes();
    update();
  }
}
