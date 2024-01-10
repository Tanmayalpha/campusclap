import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:campusclap/Models/content_model.dart';
import 'package:campusclap/Models/course_with_progress.dart';
import 'package:campusclap/Models/get_profile_response.dart';
import 'package:campusclap/Models/my_courses_model.dart';
import 'package:campusclap/Models/recieved_progress.dart';
import 'package:campusclap/Models/update_profile_response.dart';
import 'package:campusclap/Models/watchlist_model.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/api_services/apiConstants.dart';
String selectedCurrency = 'INR';
int selectedCurrencyRate = 1;
List<EnrollDetail>? studyingList = [];
ContentModel? contentModel;
var authToken;

Map categoryMap = {};
final storage = FlutterSecureStorage();
WatchlistModel? watchlistModel;

String currencySymbol(String currencyCode) {
  NumberFormat format =
  NumberFormat.simpleCurrency(name: currencyCode.toUpperCase());

  if (currencyCode.toUpperCase() == "NGN") {
    return "${format.currencyName}";
  }
  return "${format.currencySymbol}";
}

Widget cusprogressbar(double? width, double? progress) {
  progress = progress!.isNaN ? 0.0 : progress;
  return Container(
    width: width,
    height: 25.0,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.0),
        border: Border.all(color: Colors.grey[200]!)),
    child: Center(
      child: LinearPercentIndicator(
        width: width! - 3,
        lineHeight: 10.0,
        percent: progress,
        barRadius: Radius.circular(5.0),
        backgroundColor: Color(0xFFF1F3F8),
        progressColor: Color(0xff0284A2),
      ),
    ),
  );
}

Widget headingTitle(String x, Color clr, double size) {
  return Padding(
    padding: EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 7.0),
    child: Text(
      x,
      style: TextStyle(
        color: clr,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget cusDivider(Color clr) {
  return  Center(
    child:  Container(
      margin:  const EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
      height: 1.0,
      color: clr,
    ),
  );
}

Widget func(var num, String tag, int a, String x, Color clr, int ch) {
  var n;
  Color c = ch == 1 ? Color(0xffb4bac6) : Color(0x993f4654);
  if (a != 2) {
    n = num.toInt();
    if (n > 999) {
      num /= 1000;
      n = num.toString() + "k";
    }
  } else {
    n = num == null ? "N/A" : num;
  }
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      if (a == 3)
        Icon(Icons.favorite_border, color: c)
      else
        Image.asset(
          x,
          color: c,
          height: 24.0,
        ),
      Text(
        n.toString(),
        style:
        TextStyle(fontSize: 20.0, color: clr, fontWeight: FontWeight.bold),
      ),
      Text(
        tag,
        style: TextStyle(
            color: c,
            fontWeight: ch == 1 ? FontWeight.bold : FontWeight.normal),
      ),
      SizedBox(
        height: 5.0,
      )
    ],
  );
}


 getCategoryName(String? id) {
  if (id == null) {
    return '';
  }else {
    return categoryMap[int.tryParse(id)];
  }


}



Future<void> loadData({int delayInSeconds = 0}) async {
  String url = APIData.getAllWatchlist + APIData.secretKey;

  await Future.delayed(Duration(seconds: delayInSeconds));
  Response response = await get(
    Uri.parse(url),
    headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    },
  );
  if (response.statusCode == 200) {
    String data = response.body;
    print('Watchlist Response :-> $data');
    watchlistModel = WatchlistModel.fromJson(await jsonDecode(data));
  } else {
    print('Watchlist Response Code :-> ${response.statusCode}');
  }
}

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

}


Future<ContentModel?> getContent(BuildContext context, int? id) async {
  String url =
      APIData.courseContent + id.toString() + "?secret=${APIData.secretKey}";
  Response res = await get(Uri.parse(url));
  log("Course Content API Status Code :-> ${res.statusCode}");
  if (res.statusCode == 200) {
    log("Course Content API Response :-> ${res.body}");
    contentModel = ContentModel.fromJson(json.decode(res.body));
  } else {
    throw "Can't get content";
  }
  return contentModel;
}

double getProgress(int? id) {
  double ans = 0.0;
  for (int idx = 0; idx < studyingList!.length; idx++) {
    if (studyingList![idx].course!.id == id) {
      studyingList![idx].course!.progress!.forEach((element) {
        if (element.userId == studyingList![idx].enroll!.userId) {
          ans = (element.markChapterId!.length * 1.0) /
              element.allChapterId!.length;
        }
      });
      break;
    }
  }
  return ans;
}


Future<UpdateProfileResponse?> updateProfile(var parms, {File? resume,File? selfie,File? aadhaar }) async {
  var convertedMap;
if(parms.isNotEmpty){
   convertedMap = parms.cast<String, String>();
}
  UpdateProfileResponse? response ;
 await apiBaseHelper.postMultipartAPICall(updateProfileApi, parms.isEmpty ? {}: convertedMap,resume: resume,aadhaar: aadhaar,selfie: selfie).then((getData) async {
    bool error = getData['status'];
     String msg = getData['message'];

    if (error) {
      Fluttertoast.showToast(msg: msg);
       response = UpdateProfileResponse.fromJson(getData);
    } else {
      Fluttertoast.showToast(msg: msg);
    }



  });
  return response ;
}


Future<ProfileData?> getProfile() async {
  ProfileData? profileData ;
  var prms = {};
 await apiBaseHelper.postAPICall(getProfileApi, prms).then((getData) async {
    bool error = getData['status'];
    String msg = getData['message'];

    log('${getData}');

    if (error) {

      profileData =   GetProfileResponse.fromJson(getData).data ;
    } else {
      Fluttertoast.showToast(msg: msg);
    }


  });
  return profileData ;
}


int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day);
  to = DateTime(to.year, to.month, to.day);
  return (to.difference(from).inHours / 24).round();
}

Color getColorByStatus(String status) {
  switch (status) {
    case '0':
      return colors.primary;
    case '1':
      return Colors.amber;
    case '2':
      return Colors.green;
    case '3':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

String getStatusString(String status) {
  switch (status) {
    case '0':
      return 'In Progress';
    case '1':
      return 'Interview In Progress';
    case '2':
      return 'Job Offered';
    case '3':
      return 'Reject';
    default:
      return '';
  }
}

List<int> getYears(int year) {
  int currentYear = DateTime.now().year;

  List<int> yearsTilPresent = [];

  while (year <= currentYear) {
    yearsTilPresent.add(year);
    year++;
  }

  return yearsTilPresent;
}

MyCoursesModel? myCoursesModel;
List<int>? bundlePurchasedListIds = [];
List<int>? bundlePurchasedListCoursesIds = [];



Future<MyCoursesModel?> initPurchasedCourses() async {
  print("stud${APIData.myCourses}${APIData.secretKey}");
  http.Response res = await http.post(
    Uri.parse("${APIData.myCourses}${APIData.secretKey}"),
    headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    },
  );

  log('${authToken} toke');
  debugPrint('${res.request}');


  //debugPrint(res.body);
 // debugPrint('initially purchased${res.statusCode.toString()}');
  if (res.statusCode == 200) {
    myCoursesModel = MyCoursesModel.fromJson(json.decode(res.body));

    studyingList?.clear() ;

    myCoursesModel!.enrollDetails!.forEach((element) {

      /*if (element.enroll!.bundleId == null) {*/
        print('${ myCoursesModel!.enrollDetails?.length}_________length___');
        if (studyingList!.length > 0) {
          if (!studyingList!
              .any((_element) => _element.course!.id == element.course!.id)) {
            studyingList!.add(element);
          }
        } else {
          studyingList!.add(element);
        }
      /*} else {*/

        bundlePurchasedListIds!.add(int.parse(element.enroll!.bundleId.toString()));
        element.enroll!.bundleCourseId!.forEach((element) {
          bundlePurchasedListCoursesIds!.add(int.parse(element));
        });
      /*}*/
      print('StudyingList$studyingList');
    });
  } else {
    throw "Can't get courses.";
  }
  return myCoursesModel;
}

bool isBundlePurchased(int? id) {
  bool ans = false;
  print('${ans}______________');
  bundlePurchasedListIds!.forEach((element) {
    print('${element == id}______________');
    if (element == id) ans = true;
  });
  return ans;
}



