
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:campusclap/Models/course.dart';
import 'package:campusclap/Models/courses_model.dart';
import 'package:campusclap/Models/view_job_response.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/screens/Auth/subscription_plan.dart';
import 'package:campusclap/screens/CourseDetailScreenNew.dart';
import 'package:campusclap/screens/job_details_screen.dart';
import 'package:campusclap/screens/jobs_screen.dart';
import 'package:campusclap/screens/offeredjobs_screen.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/extentions.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:campusclap/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';


import '../Models/get_jobs_response.dart';
import 'appliedjob_details.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getJobs();
    getAppliedJobs();
    getAllCourse();
    initPurchasedCourses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    filteredProducts = jobDataList
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
                        borderSide: const BorderSide(color: Colors.white, width: 1)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 1)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white, width: 1)),
                  ),
                ),
              /*EasySearchBar(
                  title: 'Example',
                  onSearch: (value) => setState(() => searchValue = value)
              ),*/
                const SizedBox(
                  height: 10,
                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    topDetailContainer(title: 'Notified', value: "20"),
                    topDetailContainer(title: 'Applied', value: "15"),
                    topDetailContainer(title: 'Offers', value: "10"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    topDetailContainer(title: 'Denied', value: "10"),
                    topDetailContainer(title: 'Accepted', value: "12"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),*/
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Job Openings And Internships",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: colors.primary),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const JobScreen(isDrawer: true),));
                      },
                      child: const Text(
                        "View all",
                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                 const SizedBox(
                  height: 10,
                ) ,
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredProducts.isEmpty ? 0 :filteredProducts.length >= 2 ? 2 : 1,
                  itemBuilder: (context, index) {
                    return jobOpeningContainer(index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Applied Jobs",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: colors.primary),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AppliedJobScreen(isFromDrawer: true),));
                      },
                      child: const Text(
                        "View all",
                        style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                    //physics: BouncingScrollPhysics(),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: appliedJobDataList.isEmpty ? 0 :appliedJobDataList.length >=2 ? 2 : 1,
                  itemBuilder: (context, index) {
                    return isPlaneActive == '0' ?  Stack(

                        children: [
                          applyJobContainer(index: index),
                          SizedBox(
                        //  width: 600,
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                            child: Container(
                              //color: Colors.black.withOpacity(0.1),
                            ),
                          ),
                        )]) : applyJobContainer2(index: index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Courses And Certifications",
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: colors.primary),
                    ),
                    Text(
                      "",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: allCourses.length < 4 ? allCourses.length : 4,
                  itemBuilder: (context, index) {
                    return isPlaneActive == '0' ? Stack(
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
                    ) : coursesWidget2(index: index);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget coursesWidget({required int index}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              height: 140,
                width: 125,
                image: NetworkImage(index == 0
                    ? 'https://res.infoq.com/articles/continuous-testing-best-practices/en/headerimage/unlocking-continuous-testing-logo-big-1564402385131.jpg'
                    : index == 1
                        ? 'https://res.infoq.com/articles/continuous-testing-best-practices/en/headerimage/unlocking-continuous-testing-logo-big-1564402385131.jpg'
                        : 'https://res.infoq.com/articles/continuous-testing-best-practices/en/headerimage/unlocking-continuous-testing-logo-big-1564402385131.jpg'),
                fit: BoxFit.cover),
          ),
          Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0
                          ? 'Holistic Personality Development Course'
                          : index == 1
                              ? 'Effective Communication Mastery Course'
                              : 'Beginners Guide For Digital Marketing',
                      style:
                          const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Free Course',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colors.primary),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [

                                    colors.secondary,
                                    colors.primary,
                                  ]),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Start',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
  Widget coursesWidget2({required int index}) {
    var item = allCourses[index];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: item.previewImage == "null" || item.previewImage == null
                ? Image.asset(
              "assets/placeholder/exp_course_placeholder.png",
              height: 140,
              width: 125,
              fit: BoxFit.cover,
            )
                : CachedNetworkImage(
              fit: BoxFit.cover,
    height: 140,
    width: 125,
              imageUrl: "${APIData.courseImages}${item.previewImage}",
              placeholder: (context, x) => Image.asset(
                  "assets/placeholder/exp_course_placeholder.png"),
            ),
          ),
          Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title ?? '',
                      style:
                      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Free Course',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colors.primary),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CourseDetailScreen(
                                  courseType: item.type,
                                  detailId: item.id,
                                  userId: item.userId,
                                  categoryId: item.categoryId,
                                  isPurchased: false),
                            ));
                      },
                      child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [

                                    colors.secondary,
                                    colors.primary,
                                  ]),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Start',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          )),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget jobOpeningContainer(int index) {

    var item =filteredProducts[index];
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  JobDetailsScreen(jobId: item.id.toString(),)));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 3,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: colors.primary, width: 2)
                                ),child: AppCachedImage(image: item.image),
                          )),
                      Expanded(
                          flex:4,
                          child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.companyname ?? '',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item.location ?? '',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ))),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child:  Text(
                              "${daysBetween(DateTime.now(), DateTime.parse('${item.lastDate}T00:00:00.000000Z'))} Days left",
                              style: const TextStyle(
                                  color: colors.primary, fontSize: 8,fontWeight: FontWeight.bold),
                            ),
                          )),
                    ])),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child:  Text(
                    item.title ?? '',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),
            // SizedBox(
            //   height: 5,
            // ),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                      border:
                          Border(top: BorderSide(width: 1, color: Colors.grey))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      applyJobHelper(value: item.jobDuration ?? ''),
                      const SizedBox(
                        width: 10,
                      ),
                      applyJobHelper(value: item.jobType ?? ''),
                      const SizedBox(
                        width: 10,
                      ),
                      applyJobHelper(value: '${item.minExperience}-${item.maxExperience}${item.experience}'),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            applyJob(item.id.toString()) ;
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [colors.secondary, colors.primary],begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15))),
                            child: const Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget applyJobContainer({required int index}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      "assets/icons/jobsDummyIcon.png"))),
                        )),
                    Expanded(
                        flex: 4,
                        child:
                            InkWell(

                              onTap: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AppliedJobDetailsScreen()),
                                );*/
                              },
                          child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Aglowid IT Solutions PVT. LTD.",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Mumbai",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )),
                        )),
                  ])),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Ui/Ux designer",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    index == 0
                        ? "Interview In Progress"
                        : index == 1
                            ? 'Job Offered'
                            : 'Rejected',
                    style: TextStyle(
                      fontSize: 12,fontWeight: FontWeight.bold,
                      color: index == 0
                          ? Colors.amber
                          : index == 1
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                ],
              ))),
          // SizedBox(
          //   height: 5,
          // ),
          Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    applyJobHelper(value: 'Full Time'),
                    const SizedBox(
                      width: 10,
                    ),
                    applyJobHelper(value: 'Onsite'),
                    const SizedBox(
                      width: 10,
                    ),
                    applyJobHelper(value: '0-2 year'),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "15 days left",
                      style: TextStyle(color: colors.primary, fontSize: 10,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget applyJobContainer2({required int index}) {
    var item = appliedJobDataList[index];
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: colors.primary, width: 2)),child: AppCachedImage(image: item.image),
                        )),
                    Expanded(
                        flex: 4,
                        child:
                        InkWell(

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  AppliedJobDetailsScreen(jobId: item.jobId.toString(),jobOfferExpireDate: item.lastDate,status: item.jobStatus.toString(),offerPdf: item.pdf.toString())),
                            );
                          },
                          child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child:  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.companyname ?? '',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item.location ?? '',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )),
                        )),
                  ])),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        item.title ??'',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        getStatusString(item.jobStatus ?? '0'),
                        style: TextStyle(
                          fontSize: 12,fontWeight: FontWeight.bold,
                          color: getColorByStatus(item.jobStatus ?? '0' ),
                        ),
                      ),
                    ],
                  ))),
          // SizedBox(
          //   height: 5,
          // ),
          Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                    border:
                    Border(top: BorderSide(width: 1, color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    applyJobHelper(value: '${item.jobDuration}'),
                    /*const SizedBox(
                      width: 10,
                    ),*/
                    applyJobHelper(value: '${item.jobType}'),
                    /*const SizedBox(
                      width: 10,
                    ),*/
                    //applyJobHelper(value: '${item.minExperience}-${item.maxExperience} ${item.experience}'),
                    const SizedBox(
                      width: 10,
                    ),
                     Text(
                      "${daysBetween(DateTime.now(), DateTime.parse('${item.lastDate}T00:00:00.000000Z'))} Days left",
                      style: const TextStyle(color: colors.primary, fontSize: 10,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }


  Widget applyJobHelper({required String value}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        value.capitalize(),
        style: const TextStyle(fontSize: 12, color: colors.whiteTemp),
      ),
    );
  }

  Widget topDetailContainer({required String title, required String value}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.28,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      decoration: BoxDecoration(
          boxShadow: [const BoxShadow(color: Colors.grey)],
          color: Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 10, color: colors.primary),
          )
        ],
      ),
    );
  }
String ? isPlaneActive ;
 List<ViewJobData> jobDataList = [] ;
 List<ViewJobData> filteredProducts = [] ;
 List<ViewJobData> appliedJobDataList = [] ;
  List< CourseData> allCourses = [];
  CoursesModel? coursesModel;



  void  getUserData() async{
   /* name = await LocalRepository.getPrefrence(LocalRepository.userName);
    email = (await LocalRepository.getPrefrence(LocalRepository.userEmail));*/
    isPlaneActive = (await LocalRepository.getPrefrence(LocalRepository.userPlaneActiveStatus));


    setState(() {

    });


    if(isPlaneActive == '0') {
      showDialog(
        context: context,
        builder: (BuildContext context) => buildSuccessDialog(context),
      );
    }
    /*String? data1 = ll?.replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |})'), (match) {
      //return '"${match.group(0)!}"';
     final value = match.group(0)!;

     // Check if the value is empty and handle accordingly
     return value.isEmpty ? '$value' : '"$value"';
    });*/



    //var data = json.decode(data1!);



  }

  Future<void> getJobs() async {
    setState(() {
      //isLoading = true;
    });
    final String coursesURL = "${APIData.getJob}${APIData.secretKey}";
    print("All Courses API Status Code : ${coursesURL}");

    Response res = await get(Uri.parse(coursesURL), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });

    print("All Courses API Status Code : ${res.statusCode}");

    log("All Courses API Response : ${res.body}");

    if (res.statusCode == 200) {
      jobDataList = GetJobsResponse.fromJson(jsonDecode(res.body)).data ?? [];
     filteredProducts = jobDataList;

      setState(() {
       // isLoading = false;
      });
    } else {
      setState(() {
       // isLoading = false;
      });
      throw "Can't get courses.";
    }
  }

  Future<void> applyJob(String jobId) async {
    String coursesURL = "${APIData.applyJob}${APIData.secretKey}";
    print("All Courses API Status Code : ${coursesURL}");

    Response res = await post(Uri.parse(coursesURL), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    }, body: {
      "job_id": "${jobId}"
    });
    log("apply job API Response : ${res.body}");

    print("apply job  Status Code : ${res.statusCode}");

    if (res.statusCode == 200) {
      var result = jsonDecode(res.body);
      if (result['status']) {
        Fluttertoast.showToast(msg: '${result['message']}');
        Navigator.pop(context);
        setState(() {
          // isLoadingBtn = false;
        });
      } else {
        Fluttertoast.showToast(msg: '${result['message']}');
        setState(() {
          //isLoadingBtn = false;
        });
      }
    } else {
      setState(() {
        // isLoadingBtn = false;
      });
      throw "Can't apply.";
    }
  }

  Future<void> getAppliedJobs() async {
    setState(() {
     // isLoading = true;
    });
    const String coursesURL = "${APIData.appliedJob}${APIData.secretKey}";
    print("All Courses API Status Code : ${coursesURL}");

    Response res = await get(Uri.parse(coursesURL), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });

    print("Applied course Status Code : ${res.statusCode}");

    log("Applied course API Response : ${res.body}");

    if (res.statusCode == 200) {
      appliedJobDataList = GetJobsResponse.fromJson(jsonDecode(res.body)).data ?? [];
     // filteredProducts = jobDataList;

      setState(() {
        //isLoading = false;
      });
    } else {
      setState(() {
       // isLoading = false;
      });
      throw "Can't get courses.";
    }
  }

  Future<void> getAllCourse() async {
    const String coursesURL = "${APIData.allCourse}${APIData.secretKey}";

    Response res = await get(Uri.parse(coursesURL));

    print("All Courses API Status Code : ${res.statusCode}");
    log("All Courses API Response : ${res.body}");

    if (res.statusCode == 200) {
      coursesModel = CoursesModel.fromJson(jsonDecode(res.body));
      //await getCountry();
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
      /*allCourses.removeWhere((element) => element.status == "0");
      allCourses.removeWhere((element) =>
      element.country!.toUpperCase().contains(countryName.toUpperCase()) ==
          true);*/
      //newCourses = allCourses!.reversed.toList();
      //filteredAllCourses = allCourses ;
    } else {
      throw "Can't get courses.";
    }
    setState(() {

    });
  }


  Widget buildSuccessDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dialogBox(),
        ],
      ),
      actions: const <Widget>[],
    );
  }


  Widget dialogBox() {
    return SizedBox(
      width: 250,
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(

                      5.00
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                        top: 24,
                        right: 18,
                      ),
                      child: Image(
                        image: AssetImage ('assets/images/Group 75380.png'),
                        height: 175,
                        width: 175,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                        top: 14,
                        right: 18,
                      ),
                      child: Text(
                        "Subscribe Plan",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      width: 152,
                      margin: const EdgeInsets.only(
                        left: 18,
                        top: 3,
                        right: 18,
                      ),
                      child: const Text(
                        "Please, first purchase the plan, then explore app content ",
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colors.darkColor,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                    ),
/*
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 39,
                        right: 5,
                      ),
                      child: Text(
                        "Download payment slip.",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: colors.darkColor,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 1.00,
                        ),
                      ),
                    ),
*/
                    const SizedBox(
                      height: 14,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 39,
                          right: 5,
                          bottom: 10
                        ),
                      child: ComenBtn(title: 'Subscribe',onPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionPlanScreen(),));
                      }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



}