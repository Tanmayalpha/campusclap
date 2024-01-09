import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:campusclap/Models/get_jobs_response.dart';
import 'package:campusclap/Models/view_job_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:campusclap/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../local_repository/preferences.dart';
import 'appliedjob_details.dart';
import 'job_details_screen.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({super.key, this.isDrawer});

  final bool? isDrawer;

  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  bool isLoading = false;

  List<ViewJobData> filteredProducts = [];
  List<ViewJobData> jobDataList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      appBar: widget.isDrawer ?? false ?  PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: commonAppBar(context, text: "Jobs")) : const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: SizedBox()),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(physics: const BouncingScrollPhysics(), children: [
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
            const SizedBox(
              height: 10,
            ),
            isLoading
                ? Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3.5,
                        ),
                        const CircularProgressIndicator(color: colors.primary)
                      ],
                    ),
                  )
                : filteredProducts.isEmpty
                    ? Center(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 3.5,
                          ),
                          const Text('Job not available!')
                        ],
                      ))
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: filteredProducts.length ?? 0,
                        itemBuilder: (context, index) {
                          return isPlaneActive == '0'
                              ? Stack(
                                  children: [
                                    jobOpeningContainer(index),
                                    SizedBox(
                                      //  width: 600,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 1, sigmaY: 1),
                                        child: Container(
                                            //color: Colors.black.withOpacity(0.1),
                                            ),
                                      ),
                                    )
                                  ],
                                )
                              : jobOpeningContainer(index);
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
          ])),
    );
  }

  Widget jobOpeningContainer(int index) {
    var item = filteredProducts[index];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JobDetailsScreen(
                      jobId: item.id.toString(),
                    )));
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
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: colors.primary, width: 2)),
                            child: AppCachedImage(image: item.image),
                          )),
                      Expanded(
                          flex: 4,
                          child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.companyname ?? '',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    item.location ?? "Mumbai",
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text(
                            '${daysBetween(DateTime.now(), DateTime.parse('${item.lastDate}T00:00:00.000000Z'))} Days left',
                            style: const TextStyle(
                                color: colors.primary, fontSize: 10),
                          )),
                    ])),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Text(
                    item.title ?? '',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),
            // SizedBox(
            //   height: 5,
            // ),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1, color: Colors.grey))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      applyJobHelper(value: '${item.jobDuration}'),
                      const SizedBox(
                        width: 10,
                      ),
                      applyJobHelper(value: '${item.jobType}'),
                      const SizedBox(
                        width: 10,
                      ),
                      applyJobHelper(
                          value:
                              '${item.minExperience}-${item.maxExperience}${item.experience}'),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            applyJob(item.id.toString());
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      colors.primary,
                                      colors.secondary,
                                      colors.secondary
                                    ]),
                                // color: colors.primary,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15))),
                            child: const Center(
                              child: Text(
                                'Apply',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
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

  Widget applyJobHelper({required String value}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        value,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  String? isPlaneActive;

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

  /*getJobs() async {
    setState(() {
      isLoading = true;
    });
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $authToken',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6ImFBODZxZlNDK0lrYjJoVk40UWpMZ0E9PSIsInZhbHVlIjoiZVRGSlJpNGIwamFSdXFiZW5SZmdkTlJwUUNFVFp4Z2hmV1BNd0w2S3lCWmxzOEd1cm1rMkhtUGJlK21za3NZRTdpeFlaZm1sV2hEcEp1R0NBR2RZU2VsamF0OFp1ZS81REE0c3BSdjMvMjhpNTRDQlFOR3U4R3lMZmF0aVVvNm8iLCJtYWMiOiI2MGFiYzVmMTI1Mzk3Mzc0YmNlNWU2ZDI3MWY3Y2IxOTZhMjU3NGZmZjg1NmNhMzRhZTMyYjJmODc2ZGEwZmE5IiwidGFnIjoiIn0%3D; campus_clicks_session=eyJpdiI6Ik5wdkRKQllhaWI0WnFBQWoxZVhyTnc9PSIsInZhbHVlIjoiU1hXTjdiL0VSZEpPSG9RbXVHOGJUR0hDR3VGcVo2TGZkY293LzJGVFBQaEFadGx6Y3pDOWVVL0pYd2dscjRCTkIzbm9UUkwyZ0U1YUtQMnp3MU5rY0Z3MXlwWE5MNzZlV1Fka3NPQWIra0E5cDZUd0Z1RWM3eWNiblNlNUppa1ciLCJtYWMiOiI4ZDQwYjRhZmIxNGJmZTg3ZDhmMzM4MmE1NDExMjIxYTU1YzkwYWI5MWYwMWZlYjViNTBjNWNmOWJlOTg5OThmIiwidGFnIjoiIn0%3D'
    };

    apiBaseHelper.getAPICall(getJobApi).then((getData) {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        jobDataList = GetJobsResponse.fromJson(getData).data ?? [];
        filteredProducts = jobDataList;
        setState(() {
          isLoading = false;
        });
      } else {
        Fluttertoast.showToast(msg: msg);
        setState(() {
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }*/

  Future<void> getJobs() async {
    setState(() {
      isLoading = true;
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
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
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
}
