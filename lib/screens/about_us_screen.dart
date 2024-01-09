import 'package:campusclap/utils/color.dart';
import 'package:campusclap/widgets/about_us_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       // appBar: customAppBar(context, "About_Us"),
        backgroundColor: colors.whiteTemp,
        body: AboutUsView(),
      ),
    );
  }
}
