
import 'package:campusclap/Models/course_detail_response.dart';
import 'package:campusclap/screens/cetification_exam.dart';
import 'package:campusclap/screens/overview_page.dart';
import 'package:campusclap/screens/previous_papers.dart';
import 'package:campusclap/screens/qa_screen.dart';
import 'package:campusclap/screens/quiz_home.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'announcement_screen.dart';
import 'appoinment_screen.dart';
import 'assignment_screen.dart';
import 'certificate_loading_screen.dart';

class MoreScreen extends StatefulWidget {
    MoreScreen(this.courseDetails, {this.isPaid});
  final CourseDetailResponse? courseDetails;
 final bool? isPaid ;

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  bool _visible = false;
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    if (!_disposed) {
      setState(() {
        _visible = false;
      });
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {

      try {
        await getContent(
            context, widget.courseDetails!.course!.id);
      } catch (e) {
        print('More Screen Exception :- $e');
      }
      if (!_disposed) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _visible == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 18.0, right: 18, bottom: 10, top: 10.0),
                      child: Text(
                        "Overview_",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OverviewPage(widget.courseDetails as CourseDetailResponse)));
                    },
                  ),
                  InkWell(
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Questions_and_Answers",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  QAScreen(courseDetails: widget.courseDetails)));
                    },
                  ),
                  InkWell(
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Announcement_",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnnouncementScreen()));
                    },
                  ),
                  InkWell(
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Quiz_",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
                  InkWell(
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Assignment_",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AssignmentScreen( courseDetails: widget.courseDetails,)));
                    },
                  ),
                  InkWell(
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Certification Exam",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CertificateExamScreen( courseDetails: widget.courseDetails,ispaid: widget.isPaid,)));


                    },
                  ),
                  /*InkWell(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Appointment_",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AppointmentScreen(courseDetail: widget.courseDetails )));
                    },
                  ),*/
                  InkWell(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Certificate_",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CertificateLoadingScreen(courseDetails: widget.courseDetails,isPaid: widget.isPaid, )));
                    },
                  ),
                  /*InkWell(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Previous_Papers",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: colors.textColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PreviousPapers()));
                    },
                  ),*/
                  /*InkWell(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Google_Meet",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: mode.titleTextColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoogleMeetScreen()));
                    },
                  ),*/
                  /*InkWell(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                      child: Text(
                        "Jitsi_Meet",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: mode.titleTextColor),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JitsiMeetScreen(),
                        ),
                      );
                    },
                  ),*/
                ],
              ),
            ),
    );
  }



  @override
  void dispose() {
    super.dispose();
    _disposed = true;
  }
}
