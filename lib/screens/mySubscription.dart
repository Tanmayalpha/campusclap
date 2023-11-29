import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';

class mySubscription extends StatefulWidget {
  const mySubscription({super.key});

  @override
  State<mySubscription> createState() => _mySubscriptionState();
}

class _mySubscriptionState extends State<mySubscription> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: commonAppBar(context, text: "My Subscription")),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      colors.primary,
                      colors.secondary,
                      colors.secondary
                    ]),
              ),
              child: const Center(
                child: Text(
                  "Lorem Ipsum",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              color: Colors.white,
              elevation: 2,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "₹5000",
                        style: TextStyle(fontSize: 18, color: colors.primary),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      const Text(
                        "Lorem Ipsum is simply dummy.",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      const Text(
                        "Lorem Ipsum is simply dummy.",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: FilledBtn(
                          title: 'Subscribed',
                          onPress: () {
                            // Navigator.push(
                            //      context,
                            //      MaterialPageRoute(
                            //          builder: (context) => const SuccessWidget()),
                            //    );
                          },
                        ),
                      ),
                      const Text("Expiry Date- 12-11-2024",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0C6D05),
                          )),
                    ],
                  )),
            )
          ],
        ),
      ),
      )
    );
  }
}
