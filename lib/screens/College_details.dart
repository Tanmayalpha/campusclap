import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';

import 'Academic_details.dart';

class College_Details extends StatefulWidget {
  const College_Details({super.key});

  @override
  State<College_Details> createState() => _College_DetailsState();
}

class _College_DetailsState extends State<College_Details> {
   TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
 final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  TextEditingController mobileController = TextEditingController();
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
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          colors.primary,
                          colors.secondary,
                          colors.secondary
                        ]),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                //    padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formKey,
                    child: ListView(
                       physics: BouncingScrollPhysics(),
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Present College Details",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colors.primary),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Fill up the following details to Present College Details and enjoy our services ", 
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                Text(
                  'College Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                 TextFormField(
                  style: TextStyle(color: colors.black54),
                  controller: address1Controller,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    fillColor: Colors.white,
                    hintText: 'College Name',
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " College Name is required";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
               Text(
                  'College State',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 5,
                ),
                 TextFormField(
                  style: TextStyle(color: colors.black54),
                  controller: address1Controller,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    fillColor: Colors.white,
                    hintText: 'College State',
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " College State is required";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                 Text(
                  'College District',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 5,
                ),
                 TextFormField(
                  style: TextStyle(color: colors.black54),
                  controller: address1Controller,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    fillColor: Colors.white,
                    hintText: 'College District',
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " College District is required";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                 Text(
                  'College Place',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                 SizedBox(
                  height: 5,
                ),
                 TextFormField(
                  style: TextStyle(color: colors.black54),
                  controller: address1Controller,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    fillColor: Colors.white,
                    hintText: 'College Place',
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: colors.black12, width: 2)),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " College Place is required";
                    }
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                 Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.13),
                  child: FilledBtn(
                    title: 'Next',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, save the input.
                        _formKey.currentState!.save();
                        // Now, you can use the validated input, which is stored in _inputText.
                        // print('Input Text: $_inputText');
                      }
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => Academic_details()),
                       );
                    },
                  ),
                ),
                 SizedBox(
                  height: 20,
                ),
                        ]
                    )
                )
            )
        ),
    );
  }
}