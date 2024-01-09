import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:campusclap/Models/get_jobs_response.dart';
import 'package:campusclap/Models/view_job_response.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/screens/appliedjob_details.dart';
import 'package:campusclap/screens/jobs_screen.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:campusclap/widgets/network_image_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class AppliedJobScreen extends StatefulWidget {
  final bool? isFromDrawer;

  const AppliedJobScreen({super.key, this.isFromDrawer});

  @override
  State<AppliedJobScreen> createState() => _AppliedJobScreenState();
}

class _AppliedJobScreenState extends State<AppliedJobScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: widget.isFromDrawer ?? false
            ? PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: commonAppBar(context, text: "Applied Job"))
            : const PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: SizedBox(),
              ),
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
                  hintStyle: TextStyle(color: Colors.black),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white, width: 1)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white, width: 1)),
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
                            const Text('Not Available')
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
                                      applyJobContainer(index: index),
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
                                : applyJobContainer(index: index);
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        ),
              const SizedBox(
                height: 20,
              )
            ])),
      ),
    );
  }

  Widget applyJobContainer({required int index}) {
    var item = filteredProducts[index];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppliedJobDetailsScreen(
                      jobId: item.jobId.toString(),
                      status: item.jobStatus.toString(),offerPdf: item.pdf.toString(), jobOfferExpireDate: item.jobOfferExpireDate,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 4,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: colors.primary,
                                  width: 2,
                                )),
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
                                    "${item.companyname}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${item.location}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ))),
                    ])),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${item.title}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      getStatusString(item.jobStatus ?? '0'),
                      style: TextStyle(
                        fontSize: 14,
                        color: getColorByStatus(item.jobStatus ?? '0'),
                      ),
                    ),
                  ],
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
                              '${item.minExperience}-${item.maxExperience} year'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${daysBetween(DateTime.now(), DateTime.parse('${item.lastDate}T00:00:00.000000Z'))} Days left",
                        style: const TextStyle(
                            color: colors.primary, fontSize: 10),
                      ),
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        value,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  String? isPlaneActive;

  bool isLoading = false;

  List<ViewJobData> jobDataList = [];
  List<ViewJobData> filteredProducts = [];

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

  Future<void> getJobs() async {
    setState(() {
      isLoading = true;
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
}
