

import 'dart:developer';

import 'package:campusclap/Models/all_planes_response.dart';
import 'package:campusclap/Models/promocode_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/Services/payment_services/razor_pay.dart';
import 'package:campusclap/screens/Auth/successful_page.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubscriptionPlanScreen extends StatefulWidget {

  final bool? isFromDrawer ;
  const SubscriptionPlanScreen({super.key,this.isFromDrawer});

  @override
  State<SubscriptionPlanScreen> createState() => _SubscriptionPlanScreenState();
}

class _SubscriptionPlanScreenState extends State<SubscriptionPlanScreen> {


  bool status = false;
  final offerCodeC = TextEditingController( );

  double? offerAmount;

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
        leading:widget.isFromDrawer ?? false ? InkWell(
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
        ) : const SizedBox(),
      ),
      body:  isPlanesLoading ? const Center(child: CircularProgressIndicator(color: colors.primary),) :SingleChildScrollView(
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
                height: MediaQuery.of(context).size.height * 0.5,
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
                          height: MediaQuery.of(context).size.height * 0.4,
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
                                  child: offerAmount == null ? Text(
                                    "₹${item.amount}",
                                    style: const TextStyle(fontSize: 20, color: colors.blackTemp, fontWeight: FontWeight.w800),
                                  ) : Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                    Text(
                                      "₹${item.amount}",
                                      style: const TextStyle(fontSize: 20, color: colors.black54, fontWeight: FontWeight.w200, decoration: TextDecoration.lineThrough),
                                    ),
                                    Text(
                                      "₹${offerAmount?.toStringAsFixed(2)}",
                                      style: const TextStyle(fontSize: 20, color: colors.blackTemp, fontWeight: FontWeight.w800),
                                    )
                                  ],),
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
                              const SizedBox(height: 10,),
                              Row(children: [
                                const SizedBox(width: 5,),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      controller: offerCodeC,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.local_offer,
                                          color: colors.primary,size: 20,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding:
                                        const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                                        hintText: 'Offer Code',
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:
                                            const BorderSide(color: colors.black12, width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:
                                            const BorderSide(color: colors.black12, width: 2)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:
                                            const BorderSide(color: colors.black12, width: 2)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            borderSide:
                                            const BorderSide(color: colors.black12, width: 2)),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 2,),
                                Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 40,
                                      child: ComenBtn(
                                        title: 'Apply',
                                        onPress: () {
                                          if(offerCodeC.text.isEmpty) {
                                            Fluttertoast.showToast(msg: 'Enter Offer Code!');
                                          }else {
                                            applyPromoCode(index);

                                          }
                                        },
                                      ),
                                    )),
                                const SizedBox(width: 5,),

                              ],),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                child: ComenBtn(
                                  title: 'Buy Now',
                                  onPress: () {

                                    RazorPayHelper razorPay =  RazorPayHelper(
                                        item.amount ?? '1', context, (result) {
                                      if (result != "error") {
                                        //payOrder(widget.model.bookingId, result);
                                        buySubscription(index, result.toString());

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
  PromocodeApplyResponse? promoCodeData ;
  String? couponId ;

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

  Future<void> applyPromoCode(int index) async{
    setState(() {
      isPlanesLoading = true;
    });
    var prms = {
      'coupon': offerCodeC.text
    };
    apiBaseHelper.postAPICall(applyPromoCodeAPI, prms).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];

      if(status) {
        promoCodeData = PromocodeApplyResponse.fromJson(getData);
       if(promoCodeData?.data?.distype == 'per') {

         double percentAmount = double.parse(planList[index].amount ?? '0.0') * double.parse(promoCodeData?.data?.amount ?? '0.0') / 100 ;
         offerAmount = double.parse(planList[index].amount ?? '0.0') - percentAmount ;
        }else {
         offerAmount = double.parse(planList[index].amount ?? '0.0') - double.parse(promoCodeData?.data?.amount ?? '0.0') ;
       }
        couponId = promoCodeData?.data?.id.toString() ?? '' ;
      }else {
        Fluttertoast.showToast(msg: msg);
      }
      setState(() {
        isPlanesLoading = false;
      });
    });


  }


  Future<void> buySubscription(int index, String transactionId) async{
    setState(() {
      isPlanesLoading = true;
    });
    var prms = {
      'plan_id':planList[index].id.toString(),
      'transaction_id': transactionId,
      'payment_method':'online',
      'total_amount':offerAmount == null ? planList[index].amount : offerAmount.toString(),
      'coupon_id':promoCodeData?.data?.id ?? '',
      'currency':'rupee',
      'enroll_start':DateTime.now().toString()

    };
    print('${prms}');
    apiBaseHelper.postAPICall(buySubscriptionPlanApi, prms).then((getData) {
      bool status = getData['status'];
      String msg = getData['message'];

      if(status) {
        Fluttertoast.showToast(msg: msg);
        Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) =>  SubscriptionSuccessScreen(isFromDrawerMenu: widget.isFromDrawer,)));
      }else {
        Fluttertoast.showToast(msg: msg);
      }
      setState(() {
        isPlanesLoading = false;
      });
    });


  }




}