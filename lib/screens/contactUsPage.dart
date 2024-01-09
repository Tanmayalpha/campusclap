import 'dart:io';

import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class ContectUsPage extends StatefulWidget {
  const ContectUsPage({super.key});

  @override
  State<ContectUsPage> createState() => _ContectUsPageState();
}

class _ContectUsPageState extends State<ContectUsPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final items = [
    Container(
      //width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/images/whatsapp (3).png',
        fit: BoxFit.fill,
      ),
    ),
    Image.asset(
      'assets/images/whatsapp (3).png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/whatsapp (3).png',
      fit: BoxFit.fill,
    ),
  ];
  final _formKey = GlobalKey<FormState>();
  String name = "",
      email = "",
      phone = "",
      message = "";
  bool isLoading = false;

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: commonAppBar(
              context,
              text: "Contact Us",
            )),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                  child: Text(
                    'Get in Touch',
                    style: TextStyle(color: colors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Leave us a Message We will Get in Touch With You as Soon as Possible',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  helperSocialContainer(
                      img: "assets/images/email (5).png",
                      text: "Mail",
                      onTab: () {
                      _sendEmail('tanmay@gmail.com');
                      }),
                  helperSocialContainer(
                      img: "assets/images/Call.png",
                      text: "Call",
                      onTab: () {
                        _makePhoneCall("tel:9074305952");
                      }),
                  helperSocialContainer(
                      img: "assets/images/whatsapp (3).png",
                      text: "Whatsapp",
                      onTab: () {
                        openwhatsapp();
                      })
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  helperSocialContainer(
                      img: "assets/images/instagram (1).png",
                      text: "Instagram", onTab: () {
                    _instagram('');
                  }),
                  helperSocialContainer(
                      img: "assets/images/facebook.png",
                      text: "Facebook",
                      onTab: () {

                      }),
                  Container(
                    width: 80,
                    height: 80,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                  child: Text(
                    'Contact us Form',
                    style: TextStyle(color: colors.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 10,
              ),
              formWidget(),
              const SizedBox(
                height: 60,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2),
                child: isLoading
                    ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : ComenBtn(
                  title: 'Send',
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      name = nameController.text;
                      email = emailController.text;
                      message = messageController.text;
                      phone = mobileController.text;
                      setState(() {
                        isLoading = true;
                      });
                      bool isPassed = await sendContactDetails(
                          name, email, phone, message);
                      setState(() {
                        isLoading = false;
                      });
                      if (isPassed) {
                        SnackBar snackBar = const SnackBar(
                          content: Text(
                            "Form_submitted_successfully",
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (!isPassed) {
                        SnackBar snackBar = const SnackBar(
                          content: Text(
                            "Form_submission_failed",
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 60,
              )
            ])),
      ),
    );
  }

  Widget formWidget() {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 2)],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Full Name',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              style: const TextStyle(color: colors.black54),
              controller: nameController,
              cursorColor: Colors.black54,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                fillColor: Colors.white,
                hintText: 'Enter Your Full Name',
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return " Full Name is required";
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Email',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              style: const TextStyle(color: colors.black54),
              controller: emailController,
              cursorColor: Colors.black54,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                fillColor: Colors.white,
                hintText: 'Enter Your Email',
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return " Email is required";
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Mobile Number",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              style: const TextStyle(color: colors.black54),
              controller: mobileController,
              cursorColor: Colors.black54,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                fillColor: Colors.white,
                hintText: 'Enter Your Mobile Number',
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return " Mobile Number is required";
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Write Your Message',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              style: const TextStyle(color: colors.black54),
              controller: messageController,
              cursorColor: Colors.black54,
              minLines: 6,
              maxLines: 10,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                fillColor: Colors.grey.withOpacity(0.2),
                filled: true,
                hintText: '',
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: colors.black12, width: 2)),
              ),
              validator: (v) {
                if (v!.isEmpty) {
                  return " Email is required";
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget helperSocialContainer(
      {required String img, required String text, required VoidCallback onTab}) {
    return InkWell(
      onTap: onTab,
      child: Container(
        height: 80,
        width: 80,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 2)],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Image(
              image: AssetImage(img),
              height: 40,
              width: 40,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> sendContactDetails(String name, String email, String mob,
      String message) async {
    Response res = await post(
      Uri.parse("${APIData.contactUs}${APIData.secretKey}"),
      headers: {"Accept": "application/json"},
      body: {"fname": name, "email": email, "mobile": mob, "message": message},
    );
    return res.statusCode == 200 ? true : false;
  }


/*launchUrl() {

  launch("url");

  }*/
  _sendEmail(String emailAddress) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
    );

    if (await canLaunchUrl(Uri.parse(emailLaunchUri.toString()))) {
      await launchUrl(Uri.parse(emailLaunchUri.toString()));
    } else {
      throw 'Could not launch $emailAddress';
    }
  }

  _makePhoneCall(String phoneNumber) async {
    if (await canLaunchUrl(Uri.parse(phoneNumber))) {
      await launchUrl(Uri.parse(phoneNumber));
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  _instagram(String instagramLink) async {
    if (await canLaunchUrl(Uri.parse(instagramLink))) {
      await launchUrl(Uri.parse(instagramLink));
    } else {
      throw 'Could not launch $instagramLink';
    }
  }

  openwhatsapp() async {
    var whatsapp = "+917891002220";
    var whatsappURl_android = "whatsapp://send?phone=" + whatsapp +
        "&text=Hello, Giftbash I have one query? ";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
        await launchUrl(Uri.parse(whatappURL_ios));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Whatsapp does not exist in this device")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatappURL_ios))) {
        await launchUrl(Uri.parse(whatappURL_ios));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("Whatsapp does not exist in this device"),
          ),
        );
      }
    }
  } }