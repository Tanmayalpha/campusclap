
import 'package:campusclap/screens/College_details.dart';
import 'package:campusclap/screens/bottom_navBar.dart';
import 'package:campusclap/screens/homepage_screen.dart';
import 'package:campusclap/screens/personal_information.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class SubscriptionSuccessScreen extends StatefulWidget {
  const SubscriptionSuccessScreen({super.key});

  @override
  State<SubscriptionSuccessScreen> createState() => _SubscriptionSuccessScreenState();
}

class _SubscriptionSuccessScreenState extends State<SubscriptionSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, false);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [colors.primary, colors.secondary, colors.secondary]),
            ),
            padding: EdgeInsets.all(5),
            child: Icon(Icons.arrow_back),
          ),
        ),
      ),*/
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),*/
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width,
              child: Image(image: AssetImage('assets/images/paymentSuccess.png')),
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width,
              child: const Image(image: AssetImage('assets/icons/paymentSuccessfulIcon.png')),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Subscription Successful !",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colors.primary),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.13),
              child: FilledBtn(
                title: 'CREATE ACCOUNT',
                onPress: () {
                  Navigator.push(context,
                                   MaterialPageRoute(
                                       builder: (context) =>  BottomNavBar()),
                                 );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}