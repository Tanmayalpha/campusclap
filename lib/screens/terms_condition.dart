import 'dart:convert';

import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart';




class TermsConditionsWidget extends StatefulWidget {
  const TermsConditionsWidget({super.key});

  @override
  State<TermsConditionsWidget> createState() => _TermsConditionsWidgetState();
}

class _TermsConditionsWidgetState extends State<TermsConditionsWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getterms();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: colors.bgColor,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: commonAppBar(context, text: "Terms & Conditions")),
        body: isLoading ? Center(child: CircularProgressIndicator(color: colors.textColor,),) : SingleChildScrollView(
            child: Html(data: data,)) ));
  }

bool isLoading = false ;

  var data ;

    Future<void> getterms() async {
      setState(() {
        isLoading = true;

      });
      final String coursesURL = "${APIData.termsCondition}${APIData.secretKey}";
      print("All Courses API Status Code : ${coursesURL}");

      Response res = await get(Uri.parse(coursesURL), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $authToken",
      });



      if (res.statusCode == 200) {

        var result = jsonDecode(res.body);
        data = result['terms_policy'][0]['terms'];

        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw "Can't get courses.";
      }
    }

}

      