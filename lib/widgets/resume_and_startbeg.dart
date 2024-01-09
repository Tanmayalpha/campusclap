import 'dart:convert';
import 'dart:io';
import 'package:campusclap/Models/course_detail_response.dart';
import 'package:campusclap/Models/course_with_progress.dart';
import 'package:campusclap/Models/my_courses_model.dart';
import 'package:campusclap/Models/recieved_progress.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/player/clips.dart';
import 'package:campusclap/player/playlist_screen.dart';
import 'package:campusclap/screens/courses_screen.dart';
import 'package:campusclap/screens/no_videos_screen.dart';
import 'package:campusclap/utils/globle.dart';

import 'package:fluttertoast/fluttertoast.dart';
import '../Widgets/triangle.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ResumeAndStart extends StatefulWidget {
  final CourseDetailResponse details;
  final List<String> progress;
  final DateTime purchaseDate;
  final bool? isPaid ;
  const ResumeAndStart(this.details, this.progress, this.purchaseDate, {super.key, this.isPaid});
  @override
  _ResumeAndStartState createState() => _ResumeAndStartState();
}

class _ResumeAndStartState extends State<ResumeAndStart> {
  bool isloading = false;

  // ignore: missing_return
  bool? checkDrip({String? dripType, String? dripDays, String? dripDate}) {
    if (dripType == "date") {
      if (dripDate != null)
        return DateTime.parse(dripDate).millisecondsSinceEpoch <=
            DateTime.now().millisecondsSinceEpoch;
      else
        return false;
    } else if (dripType == "days") {
      if (dripDays != null) {
        return widget.purchaseDate
                .add(Duration(days: int.parse(dripDays)))
                .millisecondsSinceEpoch <
            DateTime.now().millisecondsSinceEpoch;
      } else
        return false;
    } else if (dripType == null) return true;
    return null;
  }

  List<Chapter> dripFilteredChapters = [];
  List<Courseclass> dripFilteredClasses = [];

  void dripFilter() {
    bool isDripEnabled = widget.details.course!.dripEnable == "1";
    print("isDripEnabled : $isDripEnabled");

    var courseChapterData = widget.details.course!.chapter;
    for (Chapter element in courseChapterData!) {
      if (isDripEnabled) {
        bool? isDrip = checkDrip(
            dripType: element.dripType,
            dripDate: element.dripDate,
            dripDays: element.dripDays);
        print("isDrip : $isDrip");
        if (isDrip as bool) {
          dripFilteredChapters.add(element);
          print("Chapter : ${element.chapterName}");
        }
      } else {
        dripFilteredChapters.add(element);
        print("Chapter : ${element.chapterName}");
      }
    }

    var courseClassData = widget.details.course!.courseclass;
    for (Courseclass element in courseClassData!) {
      if (isDripEnabled) {
        bool? isDrip = checkDrip(
            dripType: element.dripType,
            dripDate: element.dripDate,
            dripDays: element.dripDays);
        print("isDrip : $isDrip");
        if (isDrip as bool) {
          dripFilteredClasses.add(element);
          print("Class : ${element.title}");
        }
      } else {
        dripFilteredClasses.add(element);
        print("Class : ${element.title}");
      }
    }
  }

  Future<bool> resetProgress() async {
    String url = "${APIData.updateProgress}${APIData.secretKey}";
    http.Response res = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json",
     // "Authorization": "Bearer $authToken",
    }, body: {
      "course_id": widget.details.course!.id.toString(),
      "checked": "[]"
    });
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<String>?> getProgress(int id) async {
    String url = "${APIData.courseProgress}${APIData.secretKey}";
    http.Response res = await http.post(Uri.parse(url), headers: {
      "Accept": "application/json",
     // HttpHeaders.authorizationHeader: "Bearer $authToken",
    }, body: {
      "course_id": id.toString()
    });
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body)["progress"];
      if (body == null) return [];
      Progress pro = Progress.fromJson(body);
      return pro.markChapterId;
    } else {
      return [];
    }
  }

  List<VideoClip> _allClips = [];

  List<VideoClip> getClips(List<Courseclass> allLessons) {
    List<VideoClip> clips = [];
    allLessons.forEach((element) {
      if (element.type == "video") {
        if (element.url != null) {
          clips.add(VideoClip(
              element.title,
              "lecture_",
              "images/ForBiggerFun.jpg",
              100,
              element.url,
              element.id,
              element.user,
              element.dateTime,
              null));
        } else {
          if (element.iframeUrl != null) {
            clips.add(VideoClip(
                element.title,
                "lecture_",
                "images/ForBiggerFun.jpg",
                100,
                element.iframeUrl,
                element.id,
                element.user,
                element.dateTime,
                null,
                isIframe: true));
          } else {
            clips.add(VideoClip(
              element.title,
              "lecture_",
              "images/ForBiggerFun.jpg",
              100,
              APIData.videoLink + element.video.toString(),
              element.id,
              element.user,
              element.dateTime,
              null,
            ));
          }
        }
      } else if (element.type == "pdf") {
        if (element.url != null) {
          clips.add(VideoClip(
            element.title,
            "lecture_",
            "images/ForBiggerFun.jpg",
            100,
            element.url,
            element.id,
            element.user,
            element.dateTime,
            null,
          ));
        } else {
          clips.add(VideoClip(
            element.title,
            "lecture_",
            "images/ForBiggerFun.jpg",
            100,
            APIData.pdfLink + element.pdf.toString(),
            element.id,
            element.user,
            element.dateTime,
            null,
          ));
        }
      } else if (element.type == "audio") {
        if (element.url != null) {
          clips.add(VideoClip(
            element.title,
            "lecture_",
            "images/ForBiggerFun.jpg",
            100,
            element.url,
            element.id,
            element.user,
            element.dateTime,
            null,
          ));
        } else {
          clips.add(VideoClip(
            element.title,
            "lecture_",
            "images/ForBiggerFun.jpg",
            100,
            '${APIData.domainLink}files/audio/' + element.audio,
            element.id,
            element.user,
            element.dateTime,
            null,
          ));
        }
      }
    });
    return clips;
  }

  List<VideoClip> getLessons(Chapter chap, List<Courseclass> allLessons) {
    List<Courseclass> less = [];
    allLessons.forEach((element) {
      if (chap.id.toString() == element.coursechapterId &&
          element.url != null) {
        less.add(element);
      } else if (chap.id.toString() == element.coursechapterId &&
          element.video != null) {
        less.add(element);
      } else if (chap.id.toString() == element.coursechapterId &&
          element.iframeUrl != null) {
        less.add(element);
      } else if (chap.id.toString() == element.coursechapterId &&
          element.pdf != null) {
        less.add(element);
      } else if (chap.id.toString() == element.coursechapterId &&
          element.audio != null) {
        less.add(element);
      }
    });
    if (less.length == 0) return [];
    return getClips(less);
  }

  int findIndToResume(List<Section> sections, List<String> markedSecs) {
    int idx = 0;
    for (int i = 0; i < sections.length; i++) {
      if (markedSecs.contains(sections[i].sectionDetails!.id.toString())) {
        idx += sections[i].sectionLessons!.length;
      } else {
        break;
      }
    }
    return idx;
  }

  List<Section> generateSections(
      List<Chapter> sections, List<Courseclass> allLessons) {
    List<Section> sectionList = [];

    sections.forEach((element) {
      List<VideoClip> lessons = getLessons(element, allLessons);
      if (lessons.length > 0) {
        sectionList.add(Section(element, lessons));
        _allClips.addAll(lessons);
      }
    });
    if (sectionList.length == 0) return [];
    return sectionList;
  }

  bool strtBeginLoad = false;

  @override
  Widget build(BuildContext context) {
    _allClips.clear();
   // CoursesProvider courses = Provider.of<CoursesProvider>(context);
    List<Section> sections =
        generateSections(dripFilteredChapters, dripFilteredClasses);
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          children: [
            CustomPaint(
              painter: TrianglePainter(
                strokeColor: Colors.white,
                strokeWidth: 4,
                paintingStyle: PaintingStyle.fill,
              ),
              child: Container(
                height: 20,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height /
                  (MediaQuery.of(context).orientation == Orientation.landscape
                      ? 1.5
                      : 3.9),
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              margin: EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        List<String> marksSecs = widget.progress;
                        int defaultIdx = findIndToResume(sections, marksSecs);
                        defaultIdx =
                            defaultIdx > _allClips.length - 1 ? 0 : defaultIdx;

                        // Resume course or start course
                        if (_allClips.length > 0) {

                          if(!(widget.progress.length > 0)){
                            startCourse() ;
                            print('_____________________startCourse');
                          }
                          bool isWatching = false/*Provider.of<WatchlistProvider>(
                                  context,
                                  listen: false)
                              .isWatching(widget.details.course!.id)*/;
                          if (!isWatching) {
                            Navigator.of(context).push( MaterialPageRoute(
                                builder: (context) => PlayListScreen(
                                      markedSec: marksSecs,
                                      clips: _allClips,
                                      sections: sections,
                                      defaultIndex: defaultIdx,
                                      courseDetails: widget.details,isPaid: widget.isPaid,
                                    )));
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Already_watching_from_another_device",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EmptyVideosPage()));
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        height: 55.0,
                        width: MediaQuery.of(context).size.width - 50,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border:
                                Border.all(width: 1.0, color: Colors.black12),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                widget.progress.length > 0
                                    ? "Resume_"
                                    : "Start_Course",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 4,
                              child: Container(
                                margin: EdgeInsets.all(3.0),
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.00),
                                ),
                                child:
                                    Icon(Icons.play_arrow, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () async {
                        List<String> marksSecs = [];
                        setState(() {
                          strtBeginLoad = true;
                        });
                        bool x = await resetProgress();
                        setState(() {
                          strtBeginLoad = false;
                        });

                        if (x) {
                          setProgress(
                              widget.details.course!.id, [], null);
                        }
                        if (_allClips.length > 0) {
                          bool isWatching = false;/*Provider.of<WatchlistProvider>(
                                  context,
                                  listen: false)
                              .isWatching(widget.details.course!.id);*/
                          if (!isWatching) {
                            /*Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PlayListScreen(
                                      markedSec: marksSecs,
                                      clips: _allClips,
                                      sections: sections,
                                      defaultIndex: 0,
                                      courseDetails: widget.details,
                                    )));*/
                          } else {
                            Fluttertoast.showToast(
                                msg:
                                    "Already_watching_from_another_device",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EmptyVideosPage()));
                        }
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width - 50,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0, color: Colors.black12),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: strtBeginLoad
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                    )
                                  : Text(
                                      "Start_From_Beginning",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                            Positioned(
                              right: 0,
                              top: 4,
                              child: Container(
                                margin: EdgeInsets.all(3.0),
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.00)),
                                child: Icon(
                                  Icons.replay,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    dripFilter();
  }
  List<EnrollDetail>? studyingList = [];
  void setProgress(int? id, List<String>? chpIds, RecievedProgress? x) {
    int idx = 0;
    int progressidx = -1;
    for (int i = 0; i < studyingList!.length; i++) {
      if (id == studyingList![i].course!.id) {
        idx = i;
        if (studyingList![idx].course!.progress == null) {
          studyingList![idx].course!.progress = [];
          studyingList![idx].course!.progress!.add(Progress(
              id: x!.createdProgress!.id,
              userId: x.createdProgress!.userId.toString(),
              courseId: x.createdProgress!.userId.toString(),
              markChapterId: getListOfString(
                  x.createdProgress!.markChapterId as List<int>),
              allChapterId: x.createdProgress!.allChapterId,
              createdAt: x.createdProgress!.createdAt,
              updatedAt: x.createdProgress!.updatedAt));
          return;
        }
        for (int j = 0; j < studyingList![idx].course!.progress!.length; j++) {
          if (studyingList![idx].course!.progress![j].userId ==
              studyingList![idx].enroll!.userId) {
            progressidx = j;
            break;
          }
        }
        break;
      }
    }

    if (progressidx == -1) {
      if (x != null)
        studyingList![idx].course!.progress!.add(Progress(
            id: x.createdProgress!.id,
            userId: x.createdProgress!.userId.toString(),
            courseId: x.createdProgress!.userId.toString(),
            markChapterId:
            getListOfString(x.createdProgress!.markChapterId as List<int>),
            allChapterId: x.createdProgress!.allChapterId,
            createdAt: x.createdProgress!.createdAt,
            updatedAt: x.createdProgress!.updatedAt));
    }

    if (progressidx != -1) {
      studyingList![idx].course!.progress![progressidx].markChapterId = chpIds;
    }

    setState(() {

    });
  }

  Future<void> startCourse() async {



    var sendResponse = await http.get(
      Uri.parse("${APIData.startCourse}${widget.details.course!.id}?secret=${APIData.secretKey}"),

      headers: {
        HttpHeaders.authorizationHeader: "Bearer $authToken",
        HttpHeaders.acceptHeader: "Application/json",
      },

    );

    print(sendResponse.request);

    if (sendResponse.statusCode == 200) {

    } else {
    }
  }

}
