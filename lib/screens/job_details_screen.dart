import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:campusclap/Models/get_jobs_response.dart';
import 'package:campusclap/Models/view_job_response.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:campusclap/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../Widgets/html_text.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key, this.jobId});

  final String? jobId;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

List<String> listDetails = [
  "Applied Successfully",
  "Application sent",
  "Application Viewed",
  "Application Approved",
  "Cleared all the interview round"
];

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isLoadingBtn = false ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobDetail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: commonAppBar(context,
                text: 'Job Details' /*"Applied Job Details"*/)),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(physics: BouncingScrollPhysics(), children: [
                  const SizedBox(
                    height: 20,
                  ),
                  jobOfferContainer(),
                  /*Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(color: Colors.grey)],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Application Status',
                      style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold, color: colors.primary),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listDetails.length,
                      itemBuilder: (context, index) {
                        return stapperWidget(index: index);
                      },
                    ),
                  ],
                ),
              ),*/
                  const SizedBox(
                    height: 10,
                  ),
                  jobDetailWidget()
                ])),
      ),
    );
  }

  Widget stapperWidget({required int index}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffEEEEEE),
                radius: 22,
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
              index == listDetails.length - 1
                  ? Container()
                  : Container(
                      height: 25,
                      width: 1,
                      color: Colors.grey,
                    )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listDetails[index],
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '20 Nov',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 22,
        child: Icon(
          Icons.check,
          color: Colors.green,
        ),
      ),
      title: Text(
        'Applied Successfuly',
        style: TextStyle(fontSize: 12),
      ),
      subtitle: Text(
        '20 Nov',
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  Widget jobOfferContainer() {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.only(top: 60),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey)],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  viewJobDetailResponse?.data?.title ?? '',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  viewJobDetailResponse?.data?.companyname ?? '',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  viewJobDetailResponse?.data?.location ?? '',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    applyJobHelper(
                        value: '${viewJobDetailResponse?.data?.jobDuration}'),
                    applyJobHelper(
                        value: '${viewJobDetailResponse?.data?.jobType}'),
                    applyJobHelper(
                        value:
                            '${viewJobDetailResponse?.data?.minExperience}-${viewJobDetailResponse?.data?.maxExperience} ${viewJobDetailResponse?.data?.experience}'),
                  ],
                ),
              ],
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              //set border radius more than 50% of height and width to make circle
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                    AppCachedImage(image: viewJobDetailResponse?.data?.image),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget jobDetailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colors.darkIcon.withOpacity(0.5),
                //<---- Insert Gradient Here
                width: 1.5,
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.location_on_outlined,
                      color: colors.primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: Text(
                    viewJobDetailResponse?.data?.location ?? '',
                    style: TextStyle(color: colors.darkIcon.withOpacity(0.5)),
                  ))
                ],
              ),
              const VerticalDivider(
                width: 20,
                thickness: 1,
                indent: 10,
                endIndent: 10,
                color: Colors.grey,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.monetization_on,
                      color: colors.primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: Text(
                    '${numtoReadableformat(double.parse(viewJobDetailResponse?.data?.minSalary ?? '0'))} to ${numtoReadableformat(double.parse(viewJobDetailResponse?.data?.maxSalary ?? '0'))} ${viewJobDetailResponse?.data?.salary}',
                    style: TextStyle(color: colors.darkIcon.withOpacity(0.5)),
                  ))
                ],
              ),
              VerticalDivider(
                width: 20,
                thickness: 1,
                indent: 15,
                endIndent: 15,
                color: colors.darkColor.withOpacity(0.5),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(
                    child: Icon(
                      Icons.work,
                      color: colors.primary,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: Text(
                    viewJobDetailResponse?.data?.jobDuration ?? '',
                    style: TextStyle(color: colors.darkIcon.withOpacity(0.5)),
                  ))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Job Description',
          style: TextStyle(
              color: colors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        html(viewJobDetailResponse?.data?.description ?? '',
            colors.darkColor.withOpacity(0.5), 14),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Skills Required',
          style: TextStyle(
              color: colors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: (viewJobDetailResponse?.data?.skills?.split(',') ?? [])
              .map((str) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '\u2022',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.55,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Text(
                    str,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.6),
                      height: 1.55,
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Job Type',
          style: TextStyle(
              color: colors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        Text(
          viewJobDetailResponse?.data?.jobType ?? '',
          textAlign: TextAlign.left,
          softWrap: true,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
            height: 1.55,
          ),
        ),
        const SizedBox(height: 20,),
        const Text(
          'Dead Line',
          style: TextStyle(
              color: colors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
        Text(
          viewJobDetailResponse?.data?.lastDate ?? '',
          textAlign: TextAlign.left,
          softWrap: true,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
            height: 1.55,
          ),
        ),
        const SizedBox(height: 20,),
        Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.13),
            child: isLoadingBtn ? const Center(child: CircularProgressIndicator(color: colors.primary,),)  :ComenBtn(
              title: 'Apply',
              onPress: () {
                applyJob();
              },
            ))
      ],
    );
  }

  Widget applyJobContainer({required int index}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/Logo Icon.png"))),
                          )),
                      Expanded(
                          flex: 4,
                          child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
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
                              ))),
                    ]),
              )),
          SizedBox(
            height: 5,
          ),
          Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ui/Ux designer",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    index == 0
                        ? "Interview In Progress"
                        : index == 1 || index == 3
                            ? 'Job Offered'
                            : 'Rejected',
                    style: TextStyle(
                      fontSize: 14,
                      color: index == 0
                          ? Colors.amber
                          : index == 1 || index == 3
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
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    applyJobHelper(value: 'Full Time'),
                    SizedBox(
                      width: 10,
                    ),
                    applyJobHelper(value: 'Onsite'),
                    SizedBox(
                      width: 10,
                    ),
                    applyJobHelper(value: '0-2 year'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "15 days left",
                      style: TextStyle(color: colors.primary, fontSize: 10),
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        value,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

  ViewJobDetailResponse? viewJobDetailResponse;

  bool isLoading = false;

  Future<void> getJobDetail() async {
    setState(() {
      isLoading = true;
    });
    final String coursesURL =
        "${APIData.jobDetail}${widget.jobId}?secret=${APIData.secretKey}";
    print("All Courses API Status Code : ${coursesURL}");

    Response res = await get(Uri.parse(coursesURL), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });

    print("All Courses API Status Code : ${res.statusCode}");

    log("All Courses API Response : ${res.body}");

    if (res.statusCode == 200) {
      viewJobDetailResponse =
          ViewJobDetailResponse.fromJson(jsonDecode(res.body));
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

  Future<void> applyJob() async {
    setState(() {
      isLoadingBtn = true;
    });
    String coursesURL = "${APIData.applyJob}${APIData.secretKey}";
    print("All Courses API Status Code : ${coursesURL}");

    Response res = await post(Uri.parse(coursesURL), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    }, body: {
      "job_id": "${widget.jobId}"
    });
    log("apply job API Response : ${res.body}");

    print("apply job  Status Code : ${res.statusCode}");

    if (res.statusCode == 200) {
      var result = jsonDecode(res.body);
      if (result['status']) {
        Fluttertoast.showToast(msg: '${result['message']}');
        Navigator.pop(context);
        setState(() {
          isLoadingBtn = false;
        });
      } else {
        Fluttertoast.showToast(msg: '${result['message']}');
        setState(() {
          isLoadingBtn = false;
        });
      }
    } else {
      setState(() {
        isLoadingBtn = false;
      });
      throw "Can't apply.";
    }
  }

  String numtoReadableformat(double numberToFormat) {
    var _formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: 1,
      locale: 'en_IN',
      symbol: '',
    ).format(numberToFormat);
    return _formattedNumber.toString();
  }
}
