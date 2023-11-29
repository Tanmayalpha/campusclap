
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: commonAppBar(
              context,
              text: "Contact Us",
            )),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(physics: BouncingScrollPhysics(), children: [
              SizedBox(
                height: 10,
              ),
              Center(
                  child: Text(
                    'Get in Touch',
                    style: TextStyle(color: colors.secondary, fontSize: 16,fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Leave us a Message We will Get in Touch With You as Soon as Possible',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  helperSocialContainer(
                      img: "assets/images/email (5).png", text: "Mail"),
                  helperSocialContainer(
                      img: "assets/images/call (2).png", text: "Call"),
                  helperSocialContainer(
                      img: "assets/images/whatsapp (3).png", text: "Whatsapp")
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  helperSocialContainer(
                      img: "assets/images/instagram (1).png",
                      text: "Instagram"),
                  helperSocialContainer(
                      img: "assets/images/facebook.png", text: "Facebook"),
                  Container(
                    width: 80,
                    height: 80,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                    'Contact us Form',
                    style: TextStyle(color: colors.secondary, fontSize: 16,fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              formWidget(),
              SizedBox(
                height: 60,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2),
                child: FilledBtn(
                  title: 'Send',
                ),
              ),
              SizedBox(
                height: 60,
              )
            ])),
      ),
    );
  }

  Widget formWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Full Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            style: TextStyle(color: colors.black54),
            controller: nameController,
            cursorColor: Colors.black54,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              fillColor: Colors.white,
              hintText: 'Enter Your Full Name',
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
            ),
            validator: (v) {
              if (v!.isEmpty) {
                return " Full Name is required";
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Email',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            style: TextStyle(color: colors.black54),
            controller: emailController,
            cursorColor: Colors.black54,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              fillColor: Colors.white,
              hintText: 'Enter Your Email',
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
            ),
            validator: (v) {
              if (v!.isEmpty) {
                return " Email is required";
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Mobile Number",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            style: TextStyle(color: colors.black54),
            controller: mobileController,
            cursorColor: Colors.black54,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              fillColor: Colors.white,
              hintText: 'Enter Your Mobile Number',
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
            ),
            validator: (v) {
              if (v!.isEmpty) {
                return " Mobile Number is required";
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Write Your Message',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(
            height: 5,
          ),
          TextFormField(
            style: TextStyle(color: colors.black54),
            controller: messageController,
            cursorColor: Colors.black54,
            minLines: 6,
            maxLines: 10,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              fillColor: Colors.grey.withOpacity(0.2),
              filled: true,
              hintText: '',
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: colors.black12, width: 2)),
            ),
            validator: (v) {
              if (v!.isEmpty) {
                return " Email is required";
              }
            },
          ),
        ],
      ),
    );
  }

  Widget helperSocialContainer({required String img, required String text}) {
    return Container(
      height: 80,
      width: 80,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Image(
            image: AssetImage(img),
            height: 40,
            width: 40,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}