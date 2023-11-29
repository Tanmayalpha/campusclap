import 'package:campusclap/Models/login_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Services/api_services/apiStrings.dart';
import 'verifyotp_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: colors.bgColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colors.primary),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Login Signup With Your Mobile Number",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  child: const Image(
                      image: AssetImage('assets/images/welcomeBackImage.png')),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Mobile Number",
                  style: TextStyle(
                      fontSize: 14,
                      // color: colors.primary,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: mobileController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.call,
                      color: colors.primary,
                    ),
                    counter: const Text(''),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    hintText: 'Enter Your Mobile Number',
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Mobile Number';
                    } else if (value.length != 10) {
                      return 'Please enter Mobile Number of 10 digit';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.13),
                  child: isLoading
                      ? const Center(
                          child:
                              CircularProgressIndicator(color: colors.primary),
                        )
                      : FilledBtn(
                          title: 'Login',
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              sendOtp();
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

  Future<void> sendOtp() async {
    setState(() {
      isLoading = true;
    });

    var param = {
      'mobile': mobileController.text,
    };
    apiBaseHelper.postAPICall(sendOTPAPI, param).then((getData) async {
      bool error = getData['status'];
      // String msg = getData['message'];
      var response = LoginResponse.fromJson(getData);

      if (error) {
        Fluttertoast.showToast(msg: response.message.toString());

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Verification(
                    otp: response.data['otp'].toString(),
                    mobile: mobileController.text,
                  )),
        );
      } else {
        Fluttertoast.showToast(msg: response.message.toString());
      }
      setState(() {
        isLoading = false;
      });
    });
  }
}
