import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_course_item.dart';

// ignore: must_be_immutable
class MyCourses extends StatefulWidget {
  bool visible;


  MyCourses({super.key,required this.visible});

  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initPurchasedCourses();

    });
  }
  @override
  Widget build(BuildContext context) {
   // CoursesProvider course = Provider.of<CoursesProvider>(context);

    print('${studyingList?.length}________');
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: commonAppBar(context, text: "My Courses")),
        body: ListView.builder(
          padding:
          const EdgeInsets.only(left: 18.0, bottom: 25.0, top: 5.0, right: 18.0),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, idx) => StudyListItem(
              studyingList![idx],
              idx,
              studyingList!.length,
              true),
          itemCount: studyingList!.length,
        )
      ),
    );
  }
}
