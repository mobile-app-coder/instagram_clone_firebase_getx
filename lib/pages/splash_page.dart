import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var _controller = Get.find<SplashController>();

  @override
  void initState() {
    super.initState();
    _controller.timer(context);
    _controller.initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(193, 53, 132, 1),
              Color.fromRGBO(131, 58, 180, 1),
            ])),
        child: const Column(
          children: [
            Expanded(
                child: Center(
                    child: Text(
              "Instagram",
              style: TextStyle(
                  color: Colors.white, fontSize: 45, fontFamily: "Billabong"),
            ))),
            Text(
              "All rights reserved",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
