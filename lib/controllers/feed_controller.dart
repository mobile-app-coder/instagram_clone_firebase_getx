import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/member_model.dart';
import '../models/post_model.dart';
import '../services/db_service.dart';
import '../services/http_service.dart';
import '../services/util_service.dart';

class FeedController extends GetxController {
  bool isLoading = false;

  List<Post> items = [];

  Future<void> apiPostLike(Post post) async {
    isLoading = true;
    update();
    await DBService.likePost(post, true);
    update();


    isLoading = false;
    post.liked = true;
    update();
  }

  resLoadFeeds(List<Post> posts) {
    items = posts;
    isLoading = false;
    update();
  }

  apiLoadFeeds() {
    isLoading = true;
    update();
    DBService.loadFeeds().then((value) => {
          resLoadFeeds(value),
        });
    update();

  }

  void apiPostUnLike(Post post) async {
    isLoading = true;
    update();

    await DBService.likePost(post, false);

    isLoading = false;
    post.liked = false;
    update();

    var owner = await DBService.getOwner(post.uid);
    sendNotificationToFollowedMember(owner);
  }

  void sendNotificationToFollowedMember(Member someone) async {
    Member me = await DBService.loadMember();
    await Network.POST(Network.API_SEND_NOTIF, Network.NotifyLike(me, someone));
  }

  dialogRemovePost(Post post, BuildContext context) async {
    var result = await Utils.dialogCommon(
        context, "Instagram", "Do you want to detele this post?", false);

    if (result) {
      isLoading = true;
      update();
      DBService.removePost(post).then((value) => {
            apiLoadFeeds(),
          });
    }
  }
}
