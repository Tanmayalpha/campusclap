import 'package:campusclap/utils/btn.dart';
import 'package:flutter/material.dart';


import '../utils/color.dart';
import 'upload_image.dart';

class Academic_details extends StatefulWidget {
  const Academic_details({super.key});

  @override
  State<Academic_details> createState() => _Academic_detailsState();
}

class _Academic_detailsState extends State<Academic_details> {
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
                  margin: EdgeInsets.all(10),
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
                    child: ListView(physics: BouncingScrollPhysics(),
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Academic Details",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colors.primary),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Fill up the following details to Academic Details and enjoy our services ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '10th Percentage/CGPA',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: '10th Percentage/CGPA',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " 10th Percentage/CGPA is required";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '12th Diploma Percentage/CGPA',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: '12th Diploma Percentage/CGPA',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " 12th Diploma Percentage/CGPA is required";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Under Graduation Details",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colors.primary),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'UG Status:Completed/Presently in FinalYear',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'UG Status:Completed/Presently in FinalYear',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " UG Status:Completed/Presently in Final Year is required";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select UG Course',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'Select UG Course',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Select UG Course";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                           Text(
                            'Select Specializations-Up to Four Specializations',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'Select Specializations-Up to Four Specializations',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Select Specializations-Up to Four Specializations";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'UG Aggregate/CGPA',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'UG Aggregate/CGPA',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " UG Aggregate/CGPA is required";
                              }
                            },
                          ),
                           SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Post Graduation Details",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colors.primary),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'PG Status:Completed/Presently in FinalYear',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'PG Status:Completed/Presently in FinalYear',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " UG Status:Completed/Presently in Final Year is required";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Select PG Course',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'Select PG Course',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Select PG Course";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                           Text(
                            'Select Specializations-Up to Four Specializations',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'Select Specializations-Up to Four Specializations',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Select Specializations-Up to Four Specializations";
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'PG Aggregate/CGPA',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'PG Aggregate/CGPA',
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: colors.black12, width: 2)),
                            ),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " PG Aggregate/CGPA is required";
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
                         MaterialPageRoute(builder: (context) => Upload_image()),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                
                        ])))));
  }
}
