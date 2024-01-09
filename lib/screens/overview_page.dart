import 'package:auto_size_text/auto_size_text.dart';
import 'package:campusclap/Models/course_detail_response.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage(this.courseDetails);

  final CourseDetailResponse courseDetails;

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    var content =
        contentModel;
    return SafeArea(

      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: commonAppBar(context, text: "Overview")),

          backgroundColor: colors.whiteTemp,
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About_this_course",
                    style: TextStyle(
                        color: colors.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  AutoSizeText(content != null
                      ? "${content.overview![0].shortDetail}"
                      : "NA"),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Description_",
                        style: TextStyle(
                            color: colors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0),
                      ),
                      Text(
                        "${"Classes_"} : ${widget.courseDetails.course!.courseclass!.length}",
                        style: TextStyle(
                            color: colors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                  AutoSizeText(
                      content != null ? "${content.overview![0].detail}" : "NA"),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "About_Instructor",
                    style: TextStyle(
                        color: colors.textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 22.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    content != null ? "${content.overview![0].instructor}" : "NA",
                    style: TextStyle(
                        color: colors.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),
                  Text(
                    content != null
                        ? "${content.overview![0].instructorEmail}"
                        : "NA",
                    style: TextStyle(
                        color: colors.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  AutoSizeText(content != null
                      ? "${content.overview![0].instructorDetail}"
                      : "NA"),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "${"User_Enrolled"  }: ",
                        style: TextStyle(
                            color: colors.textColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0),
                      ),
                      Text(
                        content != null
                            ? "${content.overview![0].userEnrolled}"
                            : "NA",
                        style: TextStyle(color: colors.textColor, fontSize: 18.0),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
