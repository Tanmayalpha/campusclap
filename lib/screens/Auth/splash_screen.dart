import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? uid;
  String? type;
  bool? isSeen;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 2), () async {

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
      //  }
    });
    //  Timer(Duration(seconds: 3), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> IntroSlider()));});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //  backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset("assets/images/splashImage.png", fit: BoxFit.fill),
        ),
      ),
    );
  }
}
