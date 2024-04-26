import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_firebase_getx/controllers/profile_controller.dart';

import '../views/profile_post_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _controller = Get.find<ProfilePageController>();

  @override
  void initState() {
    super.initState();
    _controller.apiLoadMember();
    _controller.apiLoadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.black, fontFamily: "Billabong", fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _controller.dialogLogout(context);
            },
            icon: Icon(Icons.exit_to_app),
            color: Color.fromRGBO(193, 53, 132, 1),
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showPicker(context, _controller);
                  },
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                border: Border.all(
                                    width: 1.5,
                                    color: Color.fromRGBO(193, 53, 132, 1))),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(35),
                                child: _controller.img_url.isEmpty
                                    ? const Image(
                                        image:
                                            AssetImage("assets/images/img.png"),
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        _controller.img_url,
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.cover,
                                      )),
                          ),
                          const SizedBox(
                            height: 80,
                            width: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.add_circle_outlined,
                                  color: Colors.purple,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),

                      //#myinfos
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _controller.fullName.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _controller.email,
                        style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),

                      //#my accounts
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                                child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    _controller.count_posts.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "Posts",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    _controller.count_following.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "FOLLOWING",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    _controller.count_followers.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  const Text(
                                    "FOLLOWERS",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                        child: IconButton(
                          onPressed: () {
                            _controller.changeCount(1);
                          },
                          icon: Icon(Icons.list_alt),
                        ),
                      )),
                      Expanded(
                          child: Center(
                        child: IconButton(
                          onPressed: () {
                            _controller.changeCount(2);
                          },
                          icon: Icon(Icons.grid_view),
                        ),
                      ))
                    ],
                  ),
                ),

                //#my posts
                Expanded(
                    child: GridView.builder(
                        itemCount: _controller.items.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: _controller.axisCount),
                        itemBuilder: (context, index) {
                          return itemPost(
                              _controller.items[index], context, _controller);
                        }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
