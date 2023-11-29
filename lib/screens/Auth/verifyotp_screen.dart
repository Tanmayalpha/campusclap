import 'dart:async';
import 'dart:convert';

import 'package:campusclap/Models/verify_otp_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/local_repository/user_data_model.dart';
import 'package:campusclap/screens/bottom_navBar.dart';
import 'package:campusclap/screens/personal_information.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'subscription_plan.dart';

class Verification extends StatefulWidget {
  const Verification({super.key, this.otp, this.mobile});

  final String? otp;
  final String? mobile;

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();

  OtpFieldController pinController = OtpFieldController();

  Timer? _timer;
  int secondsRemaining = 59;
  bool enableResend = false;
  String? otp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [colors.primary, colors.secondary, colors.secondary]),
            ),
            padding: const EdgeInsets.all(5),
            child: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //    padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Enter your 4 digit code",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: colors.primary),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Don't share it with any other",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: const Image(
                  image: AssetImage('assets/images/verifyScreenImage.png')),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "OTP: ${widget.otp}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            OTPTextField(
              keyboardType: TextInputType.number,
              spaceBetween: 20,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              length: 4,
              width: MediaQuery.of(context).size.width - 40,
              fieldWidth: 60,
              style: const TextStyle(fontSize: 18),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 10,
              controller: pinController,
              onChanged: (value) {
                otp = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '00.$secondsRemaining ',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      'Sec left',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colors.primary),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Didn\'t Got Code? ',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    InkWell(
                      onTap: enableResend
                          ? () {
                              setState(() {
                                secondsRemaining = 59;
                                enableResend = false;
                              });
                            }
                          : null,
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: colors.primary),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.13),
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: colors.primary),
                    )
                  : FilledBtn(
                      title: 'Verify',
                      onPress: () {
                        if (otp?.length == 4) {
                          //_formKey.currentState!.save();
                          verifyOtp();
                        } else {
                          Fluttertoast.showToast(msg: 'Not valid otp');
                        }
                      },
                    ),
            ),
            const SizedBox(
              height: 80,
            )
          ]),
        ),
      ),
    ));
  }

  bool isLoading = false;

  Future<void> verifyOtp() async {
    setState(() {
      isLoading = true;
    });
    var param = {'mobile': widget.mobile, 'otp': otp};
    apiBaseHelper.postAPICall(verifyOTPAPI, param).then((getData) async {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        Fluttertoast.showToast(msg: msg);

        var finalResponse = VerifyOtpData.fromJson(getData['data']);
        if (finalResponse.registered ?? false) {
          var userdata = UserData.fromJson(getData['data']['user']);
          token = finalResponse.token ?? '';

          LocalRepository.setPrefrence(
              LocalRepository.userData, userdata.toJson().toString());
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => BottomNavBar()));
        } else {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const PersonalInformation()));
        }
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }
}
