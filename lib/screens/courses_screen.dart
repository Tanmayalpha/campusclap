import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:campusclap/Models/course.dart';
import 'package:campusclap/Models/course_detail_response.dart';
import 'package:campusclap/Models/courses_model.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:campusclap/widgets/courses_screen_list_tile.dart';
import 'package:campusclap/widgets/network_image_widget.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';

import '../widgets/custom_expansion_tile_courses.dart';
import 'CourseDetailScreenNew.dart';
import 'courseDetails.dart';

class CoursesPage extends StatefulWidget {
  final bool? isDrawer;

  const CoursesPage({super.key, this.isDrawer});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getAllCourse();
  }

  bool ispurchased = false;
  

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      backgroundColor: colors.bgColor,
      floatingActionButton: selected && openedidxs.length > 0
          ? floatingButton(ispurchased)
          : const SizedBox.shrink(),
      appBar: widget.isDrawer ?? false
          ? PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: commonAppBar(context, text: "Courses"))
          : const PreferredSize(preferredSize: Size.fromHeight(0), child: SizedBox()),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
                onChanged: (value) {
                  filteredAllCourses = allCourses
                      .where((product) => (product.title ?? '')
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1)),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             isPlaneActive == '0'? ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return
                     Stack(
                        children: [
                          coursesWidget(index: index),
                          SizedBox(
                            //  width: 600,
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                              child: Container(
                                  //color: Colors.black.withOpacity(0.1),
                                  ),
                            ),
                          )
                        ],
                      );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ) :
            coursesLists(),
          ])),
    ));
  }

  Widget coursesWidget({required int index}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        children: [
          const Expanded(
              flex: 3,
              child: AppCachedImage(image: '')),
          Expanded(
              flex: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CourseDetailScreen()),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        index == 0
                            ? 'Holistic Personality Development Course'
                            : index == 1 || index == 3
                                ? 'Effective Communication Mastery Course'
                                : 'Beginners Guide For Digital Marketing',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'Free Course',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: colors.primary),
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    colors.primary,
                                    colors.secondary,
                                    colors.secondary
                                  ]),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Start',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  String? isPlaneActive;

  final _fadecontroller = ScrollController();

  List<CoursesDetail> courseList = [
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        whatYouLearn: [
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development'
        ],
        discountPrice: '10',
        durationType: 'm',
        courseType: '1'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        whatYouLearn: [
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development'
        ],
        discountPrice: '20',
        durationType: 'd',
        courseType: '1'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        whatYouLearn: [
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development',
          'Wordpress Theme Development'
        ],
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
    CoursesDetail(
        image:
            'https://blog.coursify.me/wp-content/uploads/2018/08/plan-your-online-course.jpg',
        title: 'Wordpress Theme Development',
        dec: 'Have access to a code editor and free to learn...',
        price: '800',
        period: '30',
        discountPrice: '0',
        durationType: 'm',
        courseType: '0'),
  ];
  List<int> openedidxs = [];
  bool selected = false;

  Widget coursesLists() {
    /* CoursesProvider coursePro =
    Provider.of<CoursesProvider>(context, listen: false);*/
    return FadingEdgeScrollView.fromSingleChildScrollView(
      gradientFractionOnStart: 0.05,
      gradientFractionOnEnd: 0.0,
      child: SingleChildScrollView(
        controller: _fadecontroller,
        child: Column(children: <Widget>[
          ListView.builder(
              padding: const EdgeInsets.only(bottom: 25.0, top: 10.0),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: filteredAllCourses?.length ?? 0,
              itemBuilder: (context, idx) {
                String category = 'Demo';

                return CustomExpansionTile(
                  title: ExpCoursesListItem(
                      filteredAllCourses?[idx] ?? CourseData(),
                      true,
                      colors.textColor),
                  onExpansionChanged: ((newState) {
                    if (newState) {
                      openedidxs.add(idx);
                    }
                    if (!newState) {
                      openedidxs.remove(idx);
                    }
                    if (openedidxs.length > 0) {
                      setState(() {
                        selected = true;
                      });
                    }
                    if (openedidxs.length == 0) {
                      setState(() {
                        selected = false;
                      });
                    }
                  }),
                  children: filteredAllCourses?[idx].whatlearns?.isEmpty ??
                          false && courseList[idx].include!.isEmpty
                      ? []
                      : <Widget>[
                          SingleChildScrollView(
                            controller: ScrollController(),
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 10.0),
                            child: Column(
                              children: buildCards(
                                  filteredAllCourses?[idx].whatlearns,
                                  filteredAllCourses?[idx].whatlearns,
                                  colors.textColor,
                                  category),
                            ),
                          )
                        ],
                );
              })
        ]),
      ),
    );
  }

  List<Widget> buildCards(List<Include>? whatlearns,
      List<Include>? whatincludes, Color? txtColor, String? category) {
    return [
      Container(
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        height: ((whatlearns?.length ?? 1) * 95 + 40) * 1.2,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Icon(
                    FontAwesomeIcons.question,
                    color: Colors.red,
                  ),
                ),
                Container(
                  height: ((whatlearns?.length ?? 0) * 80).toDouble(),
                  width: 10.0,
                  child: ListView.builder(
                      itemCount: (whatlearns?.length ?? 0) * 2,
                      itemBuilder: (context, idx) {
                        if (idx % 2 == 0) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            height: 57.0,
                            color: Colors.grey,
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            height: 10.0,
                            width: 4.0,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0)),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildchildren(whatlearns, 0, txtColor, category),
            ),
          )
        ]),
      ),
      Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        height: ((whatincludes?.length ?? 0) * 95 + 40) * 1.2,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Row(children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: const Icon(
                    FontAwesomeIcons.hashtag,
                    color: Colors.red,
                  ),
                ),
                Container(
                  height: ((whatincludes?.length ?? 0) * 62).toDouble(),
                  width: 10.0,
                  child: ListView.builder(
                      itemCount: (whatincludes?.length ?? 0) * 2,
                      itemBuilder: (context, idx) {
                        if (idx % 2 == 0) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            height: 45.0,
                            color: Colors.grey,
                          );
                        } else {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 4.0),
                            height: 10.0,
                            width: 4.0,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0)),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15.0,
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildchildren(whatincludes, 1, txtColor, category),
            ),
          )
        ]),
      )
    ];
  }

  List<Widget> buildchildren(
      List<Include>? a, int? x, Color? txtColor, String? category) {
    List<Widget> items = [];
    items.add(SizedBox(
      height: 10.0,
    ));
    items.add(Container(
      height: 40.0,
      child: Text(
        x == 0 ? "What_you_will_learn" : "Course_Includes",
        style: TextStyle(
            color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ));
    items.add(SizedBox(
      height: 20.0,
    ));
    for (int i = 0; i < (a?.length ?? 0); i++) {
      items.add(Expanded(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                a?[i].detail.toString() ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: txtColor),
              ),
              Text(category.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                      color: txtColor))
            ],
          ),
        ),
      ));
    }
    return items;
  }

  Widget floatingButton(bool ispur) {
    return FloatingActionButton.extended(
        backgroundColor: Color(0xffF44A4A),
        onPressed: () {
          CourseData details =
              filteredAllCourses[openedidxs[openedidxs.length - 1]];
          setState(() {
            openedidxs.remove(openedidxs.length - 1);
          });
          /*Navigator.of(context).pushNamed("/courseDetails",
              arguments: DataSend(details.userId, ispur, details.id,
                  details.categoryId, details.type));*/
          bool isPaid = isBundlePurchased(details.id);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailScreen(
                    courseType: details.type,
                    detailId: details.id,
                    userId: details.userId,
                    categoryId: details.categoryId,
                    isPurchased: false,isPaid: isPaid,allCourse: allCourses),
              ));
        },
        label: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("View_more"),
            SizedBox(
              width: 5.0,
            ),
            Icon(
              FontAwesomeIcons.angleRight,
              color: Colors.white,
              size: 18.0,
            ),
          ],
        ));
  }

  List<CourseData> allCourses = [];
  List<CourseData> filteredAllCourses = [];
  List<CourseData>? newCourses = [];

  CoursesModel? coursesModel;
  String countryName = "###";

  void getUserData() async {
    /* name = await LocalRepository.getPrefrence(LocalRepository.userName);
    email = (await LocalRepository.getPrefrence(LocalRepository.userEmail));*/
    isPlaneActive = (await LocalRepository.getPrefrence(
        LocalRepository.userPlaneActiveStatus));
    setState(() {});

    /*String? data1 = ll?.replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |})'), (match) {
      //return '"${match.group(0)!}"';
     final value = match.group(0)!;

     // Check if the value is empty and handle accordingly
     return value.isEmpty ? '$value' : '"$value"';
    });*/

    //var data = json.decode(data1!);
  }

  Future<CoursesModel?> getAllCourse() async {
    final String coursesURL = "${APIData.allCourse}${APIData.secretKey}";

    Response res = await get(Uri.parse(coursesURL));

    print("All Courses API Status Code : ${res.statusCode}");
    log("All Courses API Response : ${res.body}");

    if (res.statusCode == 200) {
      coursesModel = CoursesModel.fromJson(jsonDecode(res.body));
      await getCountry();
      allCourses = List.generate(
        coursesModel!.course!.length,
        (index) => CourseData(
          id: coursesModel!.course![index].id,
          userId: coursesModel!.course![index].userId,
          categoryId: coursesModel!.course![index].categoryId,
          subcategoryId: coursesModel!.course![index].subcategoryId,
          childcategoryId: coursesModel!.course![index].childcategoryId,
          languageId: coursesModel!.course![index].languageId,
          title: coursesModel!.course![index].title,
          shortDetail: coursesModel!.course![index].shortDetail,
          detail: coursesModel!.course![index].detail,
          requirement: coursesModel!.course![index].requirement,
          price: coursesModel!.course![index].price,
          discountPrice: coursesModel!.course![index].discountPrice,
          day: coursesModel!.course![index].day,
          video: coursesModel!.course![index].video,
          url: coursesModel!.course![index].url,
          featured: coursesModel!.course![index].featured,
          slug: coursesModel!.course![index].slug,
          status: coursesModel!.course![index].status,
          previewImage: coursesModel!.course![index].previewImage,
          videoUrl: coursesModel!.course![index].videoUrl,
          previewType: coursesModel!.course![index].previewType,
          type: coursesModel!.course![index].type,
          duration: coursesModel!.course![index].duration,
          durationType: coursesModel!.course![index].durationType,
          lastActive: coursesModel!.course![index].lastActive,
          createdAt: coursesModel!.course![index].createdAt,
          updatedAt: coursesModel!.course![index].updatedAt,
          include: coursesModel!.course![index].include,
          whatlearns: coursesModel!.course![index].whatlearns,
          review: coursesModel!.course![index].review,
          country: coursesModel!.course![index].country,
        ),
      );
      allCourses!.removeWhere((element) => element.status == "0");
      allCourses!.removeWhere((element) =>
          element.country!.toUpperCase().contains(countryName.toUpperCase()) ==
          true);
      newCourses = allCourses!.reversed.toList();
      filteredAllCourses = allCourses;
    } else {
      throw "Can't get courses.";
    }
    setState(() {});
    return coursesModel;
  }



  Future<void> getCountry() async {
    String apiKey = "ENTER_API_KEY_HERE";
    String url = "https://api.ipgeolocation.io/ipgeo?apiKey=$apiKey";
    Response response = await get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );
    print("Country API Status Code : ${response.statusCode}");
    log("Country API Response : ${response.body}");
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      countryName = body["country_name"];
      print("Country : $countryName");
    } else {
      print("Country : ${response.body}");
    }
  }
}

class CoursesDetail {
  String? title;

  String? dec;

  String? image;

  String? price;

  String? period;
  String? durationType;
  String? courseType;
  String? discountPrice;

  List<String>? whatYouLearn;
  List<String>? include;

  CoursesDetail(
      {this.title,
      this.dec,
      this.image,
      this.price,
      this.period,
      this.whatYouLearn,
      this.include,
      this.courseType,
      this.durationType,
      this.discountPrice});
}

