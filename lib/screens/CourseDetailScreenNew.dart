import 'dart:convert';
import 'dart:developer';
import 'package:campusclap/Models/course.dart';
import 'package:campusclap/Models/course_detail_response.dart';
import 'package:campusclap/Models/course_with_progress.dart';
import 'package:campusclap/Models/instructor_model.dart';
import 'package:campusclap/Models/my_courses_model.dart';
import 'package:campusclap/Models/purchase_history_model.dart';
import 'package:campusclap/Models/recieved_progress.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/screens/courses_screen.dart';
import 'package:campusclap/screens/rate_course_screen.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:campusclap/widgets/add_and_buy.dart';
import 'package:campusclap/widgets/course_detail_menu.dart';
import 'package:campusclap/widgets/course_grid_item.dart';
import 'package:campusclap/widgets/course_key_points.dart';
import 'package:campusclap/widgets/expandable_text.dart';
import 'package:campusclap/widgets/html_text.dart';
import 'package:campusclap/widgets/instructorwidget.dart';
import 'package:campusclap/widgets/lessons.dart';
import 'package:campusclap/widgets/rating_star.dart';
import 'package:campusclap/widgets/resume_and_startbeg.dart';
import 'package:campusclap/widgets/studfeedwid.dart';
import 'package:campusclap/widgets/videoplayer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../Models/watchlist_model.dart';


// ignore: must_be_immutable
class CourseDetailScreen extends StatefulWidget {

  String? userId ;
  int? detailId ;
  String? categoryId ;
  String? courseType ;
  bool? isPurchased ;
  bool? isPaid ;
  List<CourseData>? allCourse ;

  CourseDetailScreen({super.key, this.courseType, this.detailId,this.categoryId,this.userId, this.isPurchased,this.isPaid,this.allCourse});
  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen>
    with TickerProviderStateMixin {
  int tabIndex = 0;

  double textSize = 15.0;
  double textSizeCol = 15.0;
  Color? txtcolor;

  var purchaseDate;
  Future<void> getPurchaseDate(int? courseId) async {
    List<Orderhistory> orderHistory = await fetchPurchaseHistory();

    if (orderHistory.isNotEmpty) {
      Orderhistory? singleOrder;
      orderHistory.forEach((element) {
        if (element.courses != null) {
          if (element.courses!.id == courseId) {
            singleOrder = element;
          }
        }
      });
      if (singleOrder != null)
        purchaseDate = singleOrder!.createdAt;
      else
        purchaseDate = DateTime.now();
    } else
      purchaseDate = DateTime.now();
  }

  Future<List<Orderhistory>> fetchPurchaseHistory() async {

    var response = await http.get(
      Uri.parse(APIData.purchaseHistory + "${APIData.secretKey}"),
      /*headers: {
        HttpHeaders.authorizationHeader: "Bearer $authToken",
        HttpHeaders.acceptHeader: "application/json",
      },*/
    );
    if (response.statusCode != 200) {
      return [];
    }
    PurchaseHistory jsonResponse =
    PurchaseHistory.fromJson(jsonDecode(response.body));
    return jsonResponse.orderhistory!;
  }

  Widget include(Include inc) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 10, 0, 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Image.asset(
              "assets/icons/requirements.png",
              width: 15.0,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.17,
            child: Text(
              inc.detail.toString(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: txtcolor, fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }

  Widget courseIncludes(List<Include>? whatIncludes) {
    return Container(
      child: Column(
        children: whatIncludes!.map((e) => include(e)).toList(),
      ),
    );
  }

  Widget overview(
      String? overview, Color txtcolor, List<Include>? whatIncludes) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          headingTitle("Course_Includes", txtcolor, 20),
          courseIncludes(whatIncludes),
          headingTitle("Description_", txtcolor, 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: html(overview, txtcolor, 16),
          ),
        ],
      ),
    );
  }


  var detail;

  int checkDatatype(dynamic x) {
    if (x is int)
      return 0;
    else
      return 1;

  }

  String getRating(List<Review>? data) {
    double ans = 0.0;
    bool calcAsInt = true;
    if (data!.length > 0)
      calcAsInt = checkDatatype(data[0].learn) == 0 ? true : false;

    data.forEach((element) {
      if (!calcAsInt)
        ans += (int.tryParse(element.price)! +
            int.parse(element.value) +
            int.parse(element.learn))
            .toDouble() /
            3.0;
      else {
        ans += (int.tryParse(element.price)! +
            int.parse(element.value) +
            int.parse(element.learn)) /
            3.0;
      }
    });
    if (ans == 0.0) return 0.toString();
    return (ans / data.length).toStringAsPrecision(2);
  }

  Widget fun(String a, String b) {
    return Row(
      children: [
        Text(
          a + " : ",
          style: TextStyle(color: Colors.grey, fontSize: textSize),
        ),
        Text(
          b,
          style: TextStyle(fontSize: textSize),
        )
      ],
    );
  }

  Widget funcol(String a, String b) {
    return Column(
      children: [
        Text(
          a,
          style: TextStyle(color: Colors.grey, fontSize: textSizeCol),
        ),
        Container(
          alignment: Alignment.topCenter,
          width: 90.0,
          child: Text(
            b,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: textSizeCol,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Future<Instructor> getinstdata(dynamic id) async {
    Instructor insdetail;
    String url = "${APIData.instructorProfile}${APIData.secretKey}";
    Response res = await post(Uri.parse(url), body: {"instructor_id": "$id",}, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      insdetail = Instructor.fromJson(body);
    } else {
      print("Instructor API Status Code :-> ${res.statusCode}");
      throw "err";
    }

    return insdetail;
  }

  var getinstdetails;

  bool adShown = false;
  void didChangeDependencies() {
    loadData(delayInSeconds: 2);

   // DataSend apiData = ModalRoute.of(context)!.settings.arguments as DataSend;

    detail = getCourseDetail2 ();//getCourseDetail();
    // log(detail);
    getinstdetails = getinstdata(widget.userId);
    if (!adShown) {
     // loadInterstitialAd().then((value) => showInterstitialAd_());
      adShown = true;
    }
    super.didChangeDependencies();
  }

  Route _menuRoute(
      int id, bool isPurchased, CourseDetailResponse details, List<String> pro) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CourseDetailMenuScreen(isPurchased, details, pro, purchaseDate),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  int getLength(List<Review>? revs) {
    if (revs == null)
      return 0;
    else
      return revs.length;
  }

  Widget purchasedCourseDetails(CourseDetailResponse details, double progress) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Text(
              details.course!.title.toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Color(0xff404455)),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StarRating(
                rating: details.review == null
                    ? 0.0
                    : double.parse(getRating(details.review)),
                size: 15.0,
                color: const Color(0xff0284a2),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                details.review == null
                    ? "0 ${'Rating_'} ${'and_'} 0 ${'Review_'}"
                    : "${getRating(details.review)} ${'Rating_'} ${'and_'} ${getLength(details.review)} ${'Review_'}",
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          cusprogressbar(MediaQuery.of(context).size.width / 1.38, progress),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            details.course!.shortDetail.toString(),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: txtcolor, fontSize: 16),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Container(
            height: 75.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: fun(
                        "Course_By",
                        "${details.course!.user!.fname}" +
                            " " +
                            "${details.course!.user!.lname}")),
                Expanded(
                    child: fun(
                        ("Last_Updated"),
                        DateFormat.yMMMd()
                            .format(DateTime.parse(details.course?.createdAt ?? '')))),
                Expanded(
                    child: fun(
                        "Language_",
                        details.course!.language == null
                            ? "N/A"
                            : "${details.course!.language!.name}")),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String tMonth(String x) {
    List<String> months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[int.tryParse(x)! - 1];
  }

  String convertDate(String x) {
    String ans = x.substring(0, 4);
    ans = x.substring(8, 10) + " " + tMonth(x.substring(5, 7)) + " " + ans;
    return ans;
  }

  Widget unPurchasedCourseDetails(CourseDetailResponse details, String currency) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 15.0),
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:
      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Text(
            details.course!.title.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
                color: Color(0xff404455)),
          ),
        ),

        // ignore: unrelated_type_equality_checks
        if (details.course!.type.toString() == "1")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (details.course!.discountPrice != null)
                Text(
                    "${currencySymbol(currency)} ${(num.tryParse(details.course!.discountPrice.toString())! * selectedCurrencyRate)}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Color(0xff404455))),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                "${currencySymbol(currency)} ${(num.tryParse(details.course!.price.toString())! * selectedCurrencyRate)}",
                style: TextStyle(
                  color: details.course!.discountPrice != null
                      ? const Color(0xff943f4654)
                      : const Color(0xff404455),
                  fontWeight: details.course!.discountPrice != null
                      ? FontWeight.normal
                      : FontWeight.bold,
                  fontSize: details.course!.discountPrice != null ? 16.0 : 22.0,
                  decoration: details.course!.discountPrice != null
                      ? TextDecoration.lineThrough
                      : null,
                ),
              )
            ],
          )
        else
          const Text("Free_",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0,
                  color: Colors.red)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            details.course!.shortDetail.toString(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 4.0,
        ),
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: funcol("Course_By",
                      details.course!.user!.fname.toString())),
              Expanded(
                  child: funcol(
                      ("Last_Updated"),
                      DateFormat.yMMMd()
                          .format( DateTime.parse(details.course!.createdAt ?? '')))),
              Expanded(
                  child: funcol(
                      "Language_",
                      details.course!.language == null
                          ? "N/A"
                          : details.course!.language!.name.toString())),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: func(
                      details.studentEnrolled,
                      "Students_",
                      1,
                      "assets/icons/studentsicon.png",
                      const Color(0xff3f4654),
                      0)),
              Expanded(
                  child: func(
                      details.review == null ? "0" : getRating(details.review),
                      "Rating_",
                      2,
                      "assets/icons/star_icon.png",
                      const Color(0xff3f4654),
                      0)),
              Expanded(
                  child: func(
                      details.course!.courseclass!.length.toDouble(),
                      "Lecture_",
                      4,
                      "assets/icons/lecturesicon.png",
                      const Color(0xff3f4654),
                      0)),
            ],
          ),
        )
      ]),
    );
  }

  SliverAppBar appB(String category, CourseDetailResponse details,
      List<String> markedChpIds, bool isPur) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: const Color(0xff29303b),
      centerTitle: true,
      title: Text(
        "$category",
        style: const TextStyle(fontSize: 16.0),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: 18.0,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                _menuRoute(
                    details.course?.id as int, isPur, details, markedChpIds),
              );
            },
            child: Image.asset("assets/icons/coursedetailmenu.png", width: 17),
          ),
        ),
      ],
    );
  }

  Widget tabBar() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0),
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  tabIndex = 0;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 12,
                height: 50.0,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        topLeft: Radius.circular(15.0))),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "LESSONS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                      tabIndex == 0 ? colors.primary : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  tabIndex = 1;
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2 - 12,
                height: 50.0,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "OVERVIEW",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: tabIndex == 1
                            ? colors.primary
                            : Colors.grey[600]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget scaffoldBody(
      String category,
      List<String> markedChpIds,
      bool purchased,
      String type,
      String currency,
      double progress,
      List<CourseData> relatedCourses) {
    /*var recentCoursesList =
        Provider.of<RecentCourseProvider>(context).recentCourseList;*/
    return FutureBuilder(
      future: detail,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          CourseDetailResponse details = snapshot.data as CourseDetailResponse;
          return Container(
            color: const Color(0xffE5E5EF),
            child: CustomScrollView(
              slivers: [
               // appB(category, details, markedChpIds, purchased),
                detailsSection(purchased, details, currency, progress),

                // if course is not free
                /*if (!purchased && type == "1")
                  AddAndBuy(details.course!.id as int, details.course!.price,
                      details),
                // if course is free
                if (!purchased && type == "0")
                //AddAndBuy(details.course!.id as int, null, details),
                  AddAndBuy(details.course!.id as int, "", details),*/
                /*if (purchased)*/
                  ResumeAndStart(details, markedChpIds, purchaseDate ?? DateTime.now(),isPaid: widget.isPaid),

                if (details.course!.url != null/* &&
                    details.course!.video == null*/)
                  previewVideoPlayer(details.course!.url.toString()),
                if (details.course!.url == null &&
                    details.course!.video != null && details.course!.video!='')
                  previewVideoPlayer(
                      APIData.previewVideoLink + details.course!.video),

                // what will you learn
                if (details.course!.whatlearns!.length == 0)
                  const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  )
                else
                  SliverToBoxAdapter(
                    child: headingTitle("What_will_you_learn",
                        const Color(0xff404455), 20),
                  ),

                whatWillYouLearn(details.course!.whatlearns),

                // requirement's
                if (details.course!.requirement!.length == 0)
                  const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  )
                else
                  SliverToBoxAdapter(
                    child:
                    headingTitle("Requirements_", txtcolor!, 20),
                  ),

                //requirement text
                if (details.course!.requirement!.length == 0)
                  const SliverToBoxAdapter(
                    child: SizedBox.shrink(),
                  )
                else
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: details.course!.requirement!.length > 400
                          ? ExpandableText(
                        txtcolor!,
                        details.course!.requirement.toString(),
                        4,
                      )
                          : Text(
                        details.course!.requirement.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),

                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),

                //tabBar for lesson and overview
                tabBar(),

                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20.0,
                  ),
                ),

                if (tabIndex == 1)
                  overview(details.course!.detail, txtcolor!,
                      details.course!.include)
                else if (tabIndex == 0)
                  Lessons(details, purchased, markedChpIds, type != "1",
                      purchaseDate),

                //RecentCourses
                /*relatedCourses.length == 0
                    ? SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                )
                    : SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent_Courses",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0083A4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),*/
                /*relatedCourses.length == 0
                    ? SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                )
                    : SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height /
                        (MediaQuery.of(context).orientation ==
                            Orientation.landscape
                            ? 1.5
                            : 2.5),
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                          left: 18.0, bottom: 24.0, top: 5.0),
                      itemBuilder: (context, idx) =>
                          CourseListItem(recentCoursesList[idx], true),
                      scrollDirection: Axis.horizontal,
                      itemCount: recentCoursesList!.length,
                    ),
                  ),
                ),*/
                /*SliverToBoxAdapter(
                  child: showBannerAd_(),
                ),*/
                //AboutTheInstructor
                /*SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 25.0, 12.0, 5.0),
                    child: Text(
                      "About_The_Instructor",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0083A4),
                      ),
                    ),
                  ),
                ),

                FutureBuilder(
                    future: getinstdetails,
                    builder: (context, snap) {
                      if (snap.hasData)
                        return SliverToBoxAdapter(
                            child: InstructorWidget(snap.data as Instructor));
                      else
                        return SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                               AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                        );
                    }),*/

                if (purchased)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 10.0,
                        right: 80.0,
                        left: 80.0,
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xfff44a4a),
                          ),
                          shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return RateCourseScreen(
                                  courseName: details.course!.title.toString(),
                                  courseId: details.course!.id as int,
                                );
                              },
                            ),
                          );
                        },
                        child: const Text(
                          "Rate_this_Course",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                if (details.review != null)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(top: 23.0, bottom: 5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Student_FeedBack",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0083A4),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 5.0),
                                width: 50.0,
                                height: 30.0,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[400]!),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text(
                                  getLength(details.review).toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                getRating(details.review),
                                style: const TextStyle(
                                  fontSize: 27.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff404455),
                                ),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              StarRating(
                                size: 28.0,
                                rating: double.parse(getRating(details.review)),
                                color: const Color(0xffFDC600),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                if (details.review != null)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, idx) => Studentfeedback(
                          details.review![idx], details.course!.id as int),
                      childCount: details.review!.length > 3
                          ? 3
                          : details.review!.length,
                    ),
                  )
                else
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 25.0,
                    ),
                  ),

                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      "Related_Courses",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff0083A4),
                      ),
                    ),
                  ),
                ),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                        (context, idx) => CourseGridItem(relatedCourses[idx], idx),
                    childCount: relatedCourses.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    mainAxisSpacing: 13,
                    crossAxisSpacing: 13,
                    childAspectRatio: 0.72,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                /*SliverToBoxAdapter(
                  child: SizedBox(
                    height: 120,
                    child: showNativeBannerAd_(),
                  ),
                ),*/
              ],
            ),
          );
        } else if (snapshot.hasError) {
          print("xxx: ${snapshot.error}");
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            ),
          );
        }
      },
    );
  }

  Widget whatWillYouLearn(List<Whatlearns>? whatlearns) {
    return whatlearns!.length == 0
        ? const SliverToBoxAdapter(
      child: SizedBox.shrink(),
    )
        : KeyPoints(whatlearns);
  }

  Widget previewVideoPlayer(String? url) {
    return url == null
        ? const SliverToBoxAdapter(
      child: SizedBox.shrink(),
    )
        : SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: VideoPlayerScreen(url)),
      ),
    );
  }

  Widget detailsSection(
      bool purchased, CourseDetailResponse details, String currency, double progress) {
    return SliverToBoxAdapter(
      child: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height / (5.5),
          color: Colors.transparent //Color(0xff29303b),
        ),
        !purchased
            ? unPurchasedCourseDetails(details, currency)
            : purchasedCourseDetails(details, progress),
      ]),
    );
  }

 // final HttpService httpService = HttpService();
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    String currency = selectedCurrency;
    txtcolor = colors.textColor;
    //CoursesDetail apiData = ModalRoute.of(context)!.settings.arguments as CoursesDetail;
    //CoursesProvider course = Provider.of<CoursesProvider>(context);
    bool useAsInt = false;
    /*if (widget.categoryId is int) useAsInt = true;*/
    //print('${widget.categoryId.toString()}_____________');
    List<CourseData> allCategory = getCategoryCourses(int.parse(widget.categoryId ?? '1') );
    var category = getCategoryName(widget.categoryId);
    double progress = 0.0;
    var allProgress;
    bool isProgressEmpty = false;
    List<String>? markedChpIds = [];

    if (/*widget.isPaid ?? false*/true) {
      progress = getProgress(widget.detailId);
      allProgress = getAllProgress(widget.detailId);
      if (allProgress == null) {
        isProgressEmpty = true;
      }
      if (!isProgressEmpty) {
        markedChpIds = allProgress!.markChapterId;
      } else {
        markedChpIds = [];
      }
    }

    // apiData.purchased as bool,
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
          appBar: PreferredSize(
           preferredSize: const Size.fromHeight(80),
          child: commonAppBar(context, text: "Courses")),
        body: scaffoldBody(
          category.toString(),
          markedChpIds!,
            widget.isPaid ?? false/*apiData.purchased as bool*/,
          widget.courseType.toString(),
          currency,
          progress,
          allCategory
        ),
      ),
    );
  }

  CourseDetailResponse? courseDetails ;
  MyCoursesModel? myCoursesModel;
  List<int>? bundlePurchasedListIds = [];
  List<int>? bundlePurchasedListCoursesIds = [];



  Future<CourseDetailResponse?> getCourseDetail() async{

    var prms = {
      'course_id': widget.detailId.toString()
    } ;
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjAwZjQwY2I1YTA5N2ZhOWJlMTA1YTE4OGYzNjE4YjM0Zjk4OTFkNjY1OGFkYjBmOWIwNmYxMWE5ZGM2YTg1NDk4ZWNhMDJiZDMyYThhMWUiLCJpYXQiOjE3MDAyOTQ4MDkuMDk4ODEzMDU2OTQ1ODAwNzgxMjUsIm5iZiI6MTcwMDI5NDgwOS4wOTg4MTU5MTc5Njg3NSwiZXhwIjoxNzMxOTE3MjA5LjA5NjM4NDA0ODQ2MTkxNDA2MjUsInN1YiI6IjgwIiwic2NvcGVzIjpbXX0.PQ4u8qf6SWMkw87ArAaOyCaAd3nZRv7ZTvbJ4127ek9fuEcuvl5YD6orEsy6HeP9vjfs6N4lb3lKhAO7kbdjab4feWfAhP3jemTP4CJXFu-nmy389J3EYJIFUrqyM3b2SNgFdZuU7D-7-TI2n1ZolibtFUZAibxgT3onM-1JsUR_8RU8n53ouZuuGPA24G_Tmls0jG7iq6PMqSy43_mkZpULvqul4bUsIaNsJLr9kUd0N2XB8K_Q2zG4DezcnWwJLagAAtb597uO6kBssvcfVAqeRaeH9de3eXwu8iM-LvNGcNhk7JOM0zbZ8uD4AGAIAuJVrrMB4XCHQss9DKQj5Yo3kkfJHuQ1YXFFbhoAbEWrClMDp3PM8Sm7I1M1mudgF3BvfZaiJR0GE1E3CBVGmSogbDOrxpqat6n2q1TkpZ7JfAbq4rj9QhTmO15DP5aK4N59wRKLMsXFSmDnZSCuAYRHZecsVNf4wdiM8wU35FJM8buyTxCx42nLvbeFR-PZNyAFVskxTiwJYf48PmbdziRTXNuqFkL8YCP3htoiljTrzYlApspEH_fiiTDjRp0LJpj4G-kPrY7e0fB4d8f0e6m6cWs_dcj41KWVAIvnOBG1JfyaeujtdP0YRZaEn2YhrqAsAeTKGfiluXEOIcMFQhdXfhjRGBCqSZSlVr7I2mo'
    };
    var response = await post( Uri.parse('https://digibetter.in/digibetter/public/api/course/detail?secret=90efc0b2-8058-47f7-9469-9a25c94382c7'),body: jsonEncode(prms), headers: headers);
    if (response.statusCode == 200) {
      print('${response.body}');
      print('${prms}');
      var body = jsonDecode(response.body);
      try{
        courseDetails = CourseDetailResponse.fromJson(body) ;
      }catch (e){
        if (kDebugMode) {
          print("Exception : $e");
        }
      }

    }
    else {
      if (detail == null) {
        Fluttertoast.showToast(
            msg: "You_cant_access_this_course",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Future.delayed(const Duration(seconds: 3));
        Navigator.pop(context);
      }
    }
    return courseDetails ;
  }

  List<CourseData> getCategoryCourses(int? id) {
    List<CourseData> ans = [];
    for (int i = 0; i < (widget.allCourse?.length ?? 0); i++) {
      if (widget.allCourse?[i].categoryId == id.toString()) ans.add(widget.allCourse![i]);
    }
    return ans;
  }




  Future<CourseDetailResponse?> getCourseDetail2 () async{
    final String coursesURL = "${APIData.courseDetail}${APIData.secretKey}";
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken'
    };
    var request = http.MultipartRequest('POST', Uri.parse(coursesURL));
    request.fields.addAll({
      'course_id': widget.detailId.toString()
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print('${response.statusCode}');

    if (response.statusCode == 200) {
var result = await response.stream.bytesToString();
      var body = jsonDecode(result);
      try{
        courseDetails = CourseDetailResponse.fromJson(body) ;
      }catch (e){
        if (kDebugMode) {
          print("Exception : $e");
        }
      }

    }
    else {
      print(response.reasonPhrase);
    }
return courseDetails ;
  }

  Progress? getAllProgress(int? id) {
    Progress? pro;
    for (int idx = 0; idx < studyingList!.length; idx++) {
      if (studyingList![idx].course!.id == id) {
        studyingList![idx].course!.progress!.forEach((element) {
          if (element.userId == studyingList![idx].enroll!.userId) {
            pro = element;
          }
        });
        break;
      }
    }
    return pro;
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

});  }

  Future<MyCoursesModel?> initPurchasedCourses(BuildContext context) async {
    print("stud${APIData.myCourses}${APIData.secretKey}");
    http.Response res = await http.post(
      Uri.parse("${APIData.myCourses}${APIData.secretKey}"),
      headers: {
        "Accept": "application/json",
       // "Authorization": "Bearer $authToken",
      },
    );

    debugPrint(res.body);
    debugPrint('initially purchased${res.statusCode.toString()}');
    if (res.statusCode == 200) {
      myCoursesModel = MyCoursesModel.fromJson(json.decode(res.body));
      myCoursesModel!.enrollDetails!.forEach((element) {
        if (element.enroll!.bundleId == null) {
          if (studyingList!.length > 0) {
            if (!studyingList!
                .any((_element) => _element.course!.id == element.course!.id)) {
              studyingList!.add(element);
            }
          } else {
            studyingList!.add(element);
          }
        } else {
          bundlePurchasedListIds!.add(int.parse(element.enroll!.bundleId));
          element.enroll!.bundleCourseId!.forEach((element) {
            bundlePurchasedListCoursesIds!.add(int.parse(element));
          });
        }
        print('StudyingList$studyingList');
      });
    } else {
      throw "Can't get courses.";
    }
    setState(() {

    });
    return myCoursesModel;
  }

  /*List<CourseData> getCategoryCourses(int? id) {
    List<CourseData> ans = [];
    for (int i = 0; i < allCourses!.length; i++) {
      if (allCourses![i].categoryId == id.toString()) ans.add(allCourses![i]);
    }
    return ans;
  }*/


  Future<void> loadData({int delayInSeconds = 0}) async {
    String url = APIData.getAllWatchlist + APIData.secretKey;

    await Future.delayed(Duration(seconds: delayInSeconds));
    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
     //   "Authorization": "Bearer $authToken",
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
}
