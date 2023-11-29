

import 'dart:developer';

import 'package:campusclap/Models/all_planes_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/Services/payment_services/razor_pay.dart';
import 'package:campusclap/screens/Auth/successful_page.dart';
import 'package:campusclap/screens/paymentSuccessful.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionPlanScreen extends StatefulWidget {
  const SubscriptionPlanScreen({super.key});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {


  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlanes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      appBar: AppBar(
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
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colors.secondary,colors.primary]),
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: isPlanesLoading ? const Center(child: CircularProgressIndicator(color: colors.primary),) : Padding(

        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Subscription plan",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colors.primary),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Choose Your Plan",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
              itemCount: planList.length,
                itemBuilder: (context, index) {
                  var item =  planList[index];

                return Column(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    height: 60,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [

                            colors.secondary,
                            colors.primary,
                          ]),
                    ),
                    child: Center(
                      child: Text(

                        item.title ?? '',
                        style: const TextStyle(
                          fontSize: 16,color: colors.whiteTemp
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
                        width: 220,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                bottomRight: Radius.circular(5))),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                               SizedBox(
                              height: 40,
                              child: Center(
                                child: Text(
                                  "₹${item.amount}",
                                  style: TextStyle(fontSize: 20, color: colors.blackTemp, fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                             Expanded(
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Text(
                                      item.description ?? '',
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.withOpacity(0.4),
                            ),
                            /*const Text(
                              "Lorem Ipsum is simply dummy.",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.grey.withOpacity(0.4),
                            ),*/
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                              child: FilledBtn(
                                title: 'Buy Now',
                                onPress: () {

                                  RazorPayHelper razorPay =  RazorPayHelper(
                                      item.amount ?? '1', context, (result) {
                                    if (result != "error") {
                                      //payOrder(widget.model.bookingId, result);
                                      Navigator.push(context, MaterialPageRoute(builder:  (context) => const SubscriptionSuccessScreen()));
                                    } else {
                                      setState(() {
                                        status = false;
                                      });
                                    }
                                  });

                                  setState(() {
                                    status = true;
                                  });
                                  razorPay.init();

                                  /*Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) => const SuccessWidget()),
                                   );*/
                                },
                              ),
                            ),
                          ],
                        )),
                  )
                ],);
              },),
            )
          ],
        ),
      ),
    );
  }
  List<Plans> planList = [] ;
 bool isPlanesLoading = false ;

 Future<void> getPlanes() async{
    setState(() {
      isPlanesLoading = true;
    });
    apiBaseHelper.getAPICall(getPlansAPI).then((getData) {
      bool status = getData['status'];
      String msg = getData['message'];

      if(status) {
        planList = PlanesData.fromJson(getData['data']).plans ?? [] ;
        log(getData['data'].toString());
      }else {
        Fluttertoast.showToast(msg: msg);
      }
      setState(() {
        isPlanesLoading = false;
      });
    });
    
    
 }

}