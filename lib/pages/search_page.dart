import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_firebase_getx/controllers/search_page_controller.dart';

import '../views/search_item.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = Get.find<SearchPageController>();

  @override
  void initState() {
    super.initState();
    _controller.apiSearchMembers("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Search",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontFamily: "Billabong"),
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                //#search member
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7)),
                  child: TextField(
                    controller: _controller.searchController,
                    style: const TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                        icon: Icon(
                          Icons.search_rounded,
                          color: Colors.grey,
                        )),
                  ),
                ),

                //#member list
                Expanded(
                    child: ListView.builder(
                  itemCount: _controller.items.length,
                  itemBuilder: (ctx, index) {
                    return itemOfMember(_controller.items[index], _controller);
                  },
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
