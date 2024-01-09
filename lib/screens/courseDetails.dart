//
// import 'package:campusclap/Models/course_detail_response.dart';
// import 'package:campusclap/screens/courses_screen.dart';
// import 'package:campusclap/screens/paymentSuccessful.dart';
// import 'package:campusclap/utils/app_bar.dart';
// import 'package:campusclap/utils/color.dart';
// import 'package:campusclap/utils/globle.dart';
// import 'package:campusclap/widgets/rating_star.dart';
// import 'package:campusclap/widgets/resume_and_startbeg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:carousel_slider/carousel_slider.dart';
//
// class CourseDetailsPage extends StatefulWidget {
//   const CourseDetailsPage({super.key});
//
//   @override
//   State<CourseDetailsPage> createState() => _CourseDetailsPageState();
// }
//
// class _CourseDetailsPageState extends State<CourseDetailsPage> {
//   final items = [
//     Container(
//       //width: MediaQuery.of(context).size.width,
//       child: Image.asset(
//         'assets/images/team-job-photo-young-businessmans-working-with-new-project-office (1).png',
//         fit: BoxFit.fill,
//       ),
//     ),
//     Image.asset(
//       'assets/images/team-job-photo-young-businessmans-working-with-new-project-office (1).png',
//       fit: BoxFit.fill,
//     ),
//     Image.asset(
//       'assets/images/team-job-photo-young-businessmans-working-with-new-project-office (1).png',
//       fit: BoxFit.fill,
//     ),
//   ];
//   Color? txtcolor;
//   int currentIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//
//
//     String currency = selectedCurrency;
//
//     txtcolor = colors.textColor;
//     CoursesDetail apiData = ModalRoute.of(context)!.settings.arguments as CoursesDetail;
//     //CoursesProvider course = Provider.of<CoursesProvider>(context);
//     bool useAsInt = false;
//    // if (apiData.categoryId is int) useAsInt = true;
//    /* List<Course> allCategory = course.getCategoryCourses(
//         useAsInt ? apiData.categoryId : int.tryParse(apiData.categoryId));
//     var category = Provider.of<HomeDataProvider>(context).getCategoryName(
//         !useAsInt ? apiData.categoryId : apiData.categoryId.toString());*/
//     double progress = 0.0;
//     //Progress? allProgress;
//     var allProgress;
//     bool isProgressEmpty = false;
//     List<String>? markedChpIds = [];
//     if (/*apiData.purchased as bool*/true) {
//       progress = 0.5 ;//course.getProgress('apiData.id');
//       //allProgress =  0.6;//course.getAllProgress('apiData.id');
//       if (allProgress == null) {
//         isProgressEmpty = true;
//       }
//       if (!isProgressEmpty) {
//         markedChpIds = allProgress!.markChapterId;
//       } else {
//         markedChpIds = [];
//       }
//     }
//
//
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: colors.bgColor,
//         appBar: PreferredSize(
//             preferredSize: Size.fromHeight(80),
//             child: commonAppBar(
//               context,
//               text: "Course Details",
//             )),
//         body: scaffoldBody(
//           'demo',
//           markedChpIds!,
//           true,
//           apiData.courseType.toString(),
//           currency,
//           progress,
//           //allCategory,
//         ),//bodyWidget(),
//       ),
//     );
//   }
//   var detail;
//   Widget scaffoldBody(
//       String category,
//       List<String> markedChpIds,
//       bool purchased,
//       String type,
//       String currency,
//       double progress,
//       /*List<Course> relatedCourses*/) {
//     /*var recentCoursesList =
//         Provider.of<RecentCourseProvider>(context).recentCourseList;*/
//
//     return FutureBuilder(
//       future: detail,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           CourseDetailResponse details = snapshot.data as CourseDetailResponse;
//
//           return Container(
//             color: Color(0xffE5E5EF),
//             child: CustomScrollView(
//               slivers: [
//                 appB(category, details, markedChpIds, purchased),
//                 detailsSection(purchased, details, currency, progress),
//
//                 // if course is not free
//                 if (!purchased && type == "1")
//                   AddAndBuy(details.course!.id as int, details.course!.price,
//                       details),
//                 // if course is free
//                 if (!purchased && type == "0")
//                 //AddAndBuy(details.course!.id as int, null, details),
//                   AddAndBuy(details.course!.id as int, "", details),
//                 if (purchased)
//                   ResumeAndStart(details, markedChpIds, purchaseDate),
//
//                 if (details.course!.url != null &&
//                     details.course!.video == null)
//                   previewVideoPlayer(details.course!.url.toString()),
//                 if (details.course!.url == null &&
//                     details.course!.video != null)
//                   previewVideoPlayer(
//                       APIData.previewVideoLink + details.course!.video),
//
//                 // what will you learn
//                 if (details.course!.whatlearns!.length == 0)
//                   SliverToBoxAdapter(
//                     child: SizedBox.shrink(),
//                   )
//                 else
//                   SliverToBoxAdapter(
//                     child: headingTitle(translate("What_will_you_learn"),
//                         Color(0xff404455), 20),
//                   ),
//
//                 whatWillYouLearn(details.course!.whatlearns),
//
//                 // requirement's
//                 if (details.course!.requirement!.length == 0)
//                   SliverToBoxAdapter(
//                     child: SizedBox.shrink(),
//                   )
//                 else
//                   SliverToBoxAdapter(
//                     child:
//                     headingTitle(translate("Requirements_"), txtcolor!, 20),
//                   ),
//
//                 //requirement text
//                 if (details.course!.requirement!.length == 0)
//                   SliverToBoxAdapter(
//                     child: SizedBox.shrink(),
//                   )
//                 else
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                       child: details.course!.requirement!.length > 400
//                           ? ExpandableText(
//                         txtcolor!,
//                         details.course!.requirement.toString(),
//                         4,
//                       )
//                           : Text(
//                         details.course!.requirement.toString(),
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ),
//
//                 SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: 20.0,
//                   ),
//                 ),
//
//                 //tabBar for lesson and overview
//                 tabBar(),
//
//                 SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: 20.0,
//                   ),
//                 ),
//
//                 if (tabIndex == 1)
//                   overview(details.course!.detail, txtcolor!,
//                       details.course!.include)
//                 else if (tabIndex == 0)
//                   Lessons(details, purchased, markedChpIds, type != "1",
//                       purchaseDate),
//
//                 //RecentCourses
//                 relatedCourses.length == 0
//                     ? SliverToBoxAdapter(
//                   child: SizedBox.shrink(),
//                 )
//                     : SliverToBoxAdapter(
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 5.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Recent_Courses",
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xff0083A4),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 relatedCourses.length == 0
//                     ? SliverToBoxAdapter(
//                   child: SizedBox.shrink(),
//                 )
//                     : SliverToBoxAdapter(
//                   child: Container(
//                     height: MediaQuery.of(context).size.height /
//                         (MediaQuery.of(context).orientation ==
//                             Orientation.landscape
//                             ? 1.5
//                             : 2.5),
//                     child: ListView.builder(
//                       padding: EdgeInsets.only(
//                           left: 18.0, bottom: 24.0, top: 5.0),
//                       itemBuilder: (context, idx) =>
//                           CourseListItem(recentCoursesList[idx], true),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: recentCoursesList!.length,
//                     ),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: showBannerAd_(),
//                 ),
//                 //AboutTheInstructor
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(12.0, 25.0, 12.0, 5.0),
//                     child: Text(
//                       "About_The_Instructor",
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff0083A4),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 FutureBuilder(
//                     future: getinstdetails,
//                     builder: (context, snap) {
//                       if (snap.hasData)
//                         return SliverToBoxAdapter(
//                             child: InstructorWidget(snap.data as Instructor));
//                       else
//                         return SliverToBoxAdapter(
//                           child: Center(
//                             child: CircularProgressIndicator(
//                               valueColor:
//                               new AlwaysStoppedAnimation<Color>(Colors.red),
//                             ),
//                           ),
//                         );
//                     }),
//
//                 if (purchased)
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         bottom: 10.0,
//                         right: 80.0,
//                         left: 80.0,
//                       ),
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                             Color(0xfff44a4a),
//                           ),
//                           shape:
//                           MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(18.0),
//                             ),
//                           ),
//                         ),
//                         onPressed: () {
//                           /*Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return RateCourseScreen(
//                                   courseName: details.course!.title.toString(),
//                                   courseId: details.course!.id as int,
//                                 );
//                               },
//                             ),
//                           );*/
//                         },
//                         child: Text(
//                           "Rate_this_Course",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 15.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                 if (details.review != null)
//                   SliverToBoxAdapter(
//                     child: Container(
//                       margin: EdgeInsets.only(top: 23.0, bottom: 5.0),
//                       padding: EdgeInsets.symmetric(horizontal: 12.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Student_FeedBack",
//                                 style: TextStyle(
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xff0083A4),
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(top: 5.0),
//                                 width: 50.0,
//                                 height: 30.0,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey[400]!),
//                                   borderRadius: BorderRadius.circular(15.0),
//                                 ),
//                                 child: Text(
//                                   getLength(details.review).toString(),
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 getRating(details.review),
//                                 style: TextStyle(
//                                   fontSize: 27.0,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xff404455),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 20.0,
//                               ),
//                               StarRating(
//                                 size: 28.0,
//                                 rating: double.parse(getRating(details.review)),
//                                 color: Color(0xffFDC600),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 if (details.review != null)
//                   SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                           (context, idx) => Studentfeedback(
//                           details.review![idx], details.course!.id as int),
//                       childCount: details.review!.length > 3
//                           ? 3
//                           : details.review!.length,
//                     ),
//                   )
//                 else
//                   SliverToBoxAdapter(
//                     child: SizedBox(
//                       height: 25.0,
//                     ),
//                   ),
//
//                 SliverToBoxAdapter(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 10.0,
//                       horizontal: 12.0,
//                     ),
//                     child: Text(
//                       translate("Related_Courses"),
//                       style: TextStyle(
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff0083A4),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SliverGrid(
//                   delegate: SliverChildBuilderDelegate(
//                         (context, idx) => CourseGridItem(relatedCourses[idx], idx),
//                     childCount: relatedCourses.length,
//                   ),
//                   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                     maxCrossAxisExtent: 200,
//                     mainAxisSpacing: 13,
//                     crossAxisSpacing: 13,
//                     childAspectRatio: 0.72,
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: 40,
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: 120,
//                     child: showNativeBannerAd_(),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else if (snapshot.hasError) {
//           print("xxx: ${snapshot.error}");
//           return Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//             ),
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//
//
//
//
//  Widget bodyWidget() {
//   return Container(
//        padding: EdgeInsets.symmetric(horizontal: 20),
//        child: ListView(physics: BouncingScrollPhysics(), children: [
//          SizedBox(
//            height: 10,
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          CarouselSlider(
//            options: CarouselOptions(
//              height: MediaQuery.of(context).size.height * 0.18,
//              autoPlay: false,
//              enlargeFactor: 1,
//              // aspectRatio: 16 / 9,
//              enlargeCenterPage: true,
//              onPageChanged: (index, reason) {
//                setState(() {
//                  currentIndex = index;
//                });
//              },
//            ),
//            items: items,
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Center(
//            child: Container(
//              width: 50,
//              height: 5.5,
//              child: ListView.separated(
//                shrinkWrap: true,
//                itemCount: items.length,
//                scrollDirection: Axis.horizontal,
//                itemBuilder: (context, index) {
//                  return Container(
//                    height: 0.5,
//                    width: index == currentIndex ? 20 : 10,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      color: index == currentIndex
//                          ? colors.primary
//                          : Color(0xffFEE9E9E9),
//                    ),
//                  );
//                },
//                separatorBuilder: (context, index) {
//                  return SizedBox(
//                    width: 5,
//                  );
//                },
//              ),
//            ),
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Text(
//            "Holistic Personality Development Course",
//            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          Container(
//            decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.circular(15)),
//            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//            width: MediaQuery.of(context).size.width,
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: [
//                Text(
//                  "Description",
//                  style: TextStyle(
//                      fontSize: 16,
//                      fontWeight: FontWeight.bold,
//                      color: colors.primary),
//                ),
//                SizedBox(
//                  height: 5,
//                ),
//                Text(
//                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s , when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
//                  style: TextStyle(fontSize: 14, color: Colors.grey),
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Row(
//                  children: [
//                    Text(
//                      "Duration: ",
//                      style: TextStyle(
//                        fontSize: 14,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                    SizedBox(
//                      width: 8,
//                    ),
//                    Text(
//                      "03:14:00",
//                      style: TextStyle(
//                        fontSize: 14,
//                      ),
//                    ),
//                  ],
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Row(
//                  children: [
//                    Text(
//                      "Language: ",
//                      style: TextStyle(
//                        fontSize: 14,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                    SizedBox(
//                      width: 8,
//                    ),
//                    Text(
//                      "English",
//                      style: TextStyle(
//                        fontSize: 14,
//                      ),
//                    ),
//                  ],
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Row(
//                  children: [
//                    Text(
//                      "Level: ",
//                      style: TextStyle(
//                        fontSize: 14,
//                        fontWeight: FontWeight.bold,
//                      ),
//                    ),
//                    SizedBox(
//                      width: 30,
//                    ),
//                    Text(
//                      "Beginner",
//                      style: TextStyle(
//                        fontSize: 14,
//                      ),
//                    ),
//                  ],
//                ),
//                SizedBox(
//                  height: 20,
//                )
//              ],
//            ),
//          ),
//          SizedBox(
//            height: 15,
//          ),
//          Container(
//            height: MediaQuery.of(context).size.height * 0.2,
//            width: MediaQuery.of(context).size.width,
//            child: Image(
//                image: AssetImage("assets/images/side-view-businesswomen-using-sign-language.png"),
//                fit: BoxFit.fill),
//          ),
//          SizedBox(
//            height: 15,
//          ),
//          Container(
//            width: MediaQuery.of(context).size.width,
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: [
//                InkWell(
//                  onTap: () {
//                    showDialog<String>(
//                      context: context,
//                      builder: (BuildContext context) => Container(
//                        height: MediaQuery.of(context).size.height * 0.2,
//                        child: AlertDialog(
//                          title: Center(
//                            child: const Text(
//                              'Payment Certification',
//                              style: TextStyle(
//                                  fontSize: 16,
//                                  color: colors.primary,
//                                  fontWeight: FontWeight.bold),
//                            ),
//                          ),
//                          content: Container(
//                            height: 40,
//                            child: Column(
//                              children: [
//                                Text(
//                                  'Amount',
//                                  style: TextStyle(
//                                      fontSize: 16,
//                                      color: colors.secondary,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                                SizedBox(
//                                  height: 5,
//                                ),
//                                Text(
//                                  '₹ 7898',
//                                  style: TextStyle(
//                                    fontSize: 14,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          actions: <Widget>[
//                            Center(
//                              child: InkWell(
//                                onTap: () {
//                                  Navigator.of(context).pop();
//                                },
//                                child:
//                                InkWell(
//
//                                  onTap: () {
//                                    Navigator.push(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (context) => const PaymentSuccessful()),
//                                    );
//                                  },
//                                  child: Container(
//                                    padding: const EdgeInsets.symmetric(
//                                        horizontal: 15, vertical: 10),
//                                    decoration: BoxDecoration(
//                                        gradient: LinearGradient(
//                                            begin: Alignment.bottomLeft,
//                                            end: Alignment.topRight,
//                                            colors: [
//                                              colors.primary,
//                                              colors.secondary,
//                                              colors.secondary
//                                            ]),
//                                        borderRadius:
//                                        BorderRadius.circular(10)),
//                                    child: Text(
//                                      "Pay Now",
//                                      style: TextStyle(
//                                          fontSize: 16, color: Colors.white),
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
//                    );
//                  },
//                  child: Container(
//                    padding:
//                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                    decoration: BoxDecoration(
//                        gradient: LinearGradient(
//                            begin: Alignment.bottomLeft,
//                            end: Alignment.topRight,
//                            colors: [
//                              colors.primary,
//                              colors.secondary,
//                              colors.secondary
//                            ]),
//                        borderRadius: BorderRadius.circular(10)),
//                    child: Text(
//                      "Apply For Certificate",
//                      style: TextStyle(fontSize: 16, color: Colors.white),
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  width: 20,
//                ),
//                Container(
//                  padding:
//                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                  decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                          begin: Alignment.bottomLeft,
//                          end: Alignment.topRight,
//                          colors: [
//                            colors.primary,
//                            colors.secondary,
//                            colors.secondary
//                          ]),
//                      borderRadius: BorderRadius.circular(10)),
//                  child: Text(
//                    "Start",
//                    style: TextStyle(fontSize: 16, color: Colors.white),
//                  ),
//                ),
//              ],
//            ),
//          ),
//          SizedBox(
//            height: 35,
//          )
//        ]));
//  }
// }