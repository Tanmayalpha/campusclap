import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class AppliedJobDetailsScreen extends StatefulWidget {
  const AppliedJobDetailsScreen(
      {super.key,
      this.jobId,
      this.status,
      this.offerPdf,
      this.jobOfferExpireDate});

  final String? jobId;
  final String? status;
  final String? offerPdf;
  final String? jobOfferExpireDate;

  @override
  State<AppliedJobDetailsScreen> createState() =>
      _AppliedJobDetailsScreenState();
}

class _AppliedJobDetailsScreenState extends State<AppliedJobDetailsScreen> {
  List<String> listDetails = [
    "Applied Successfully",
    "Application sent",
    "Application Viewed",
    "Application Approved",
    "Cleared all the interview round",
    "Job Offered"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobDetail();
  }

  @override
  Widget build(BuildContext context) {
    print('${DateTime.now()}');

    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: commonAppBar(context,
                text: /*'Job Details'*/ "Applied Job Details")),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                    ListView(physics: const BouncingScrollPhysics(), children: [
                  const SizedBox(
                    height: 20,
                  ),
                  jobOfferContainer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    //   height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                        boxShadow: const [BoxShadow(color: Colors.grey)],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.status == '2'
                            ? DateTime.now().isBefore(DateTime.parse(
                            '${widget.jobOfferExpireDate}')  ) ? const Text(
                             'Job Offer Expired',
                             style: TextStyle(color: Colors.red),
                              )  : downloadBtn(() async {
                                if (widget.offerPdf != '' &&
                                    widget.offerPdf != null) {
                                  launchUrl(Uri.parse(widget.offerPdf ?? ''));
                                }
                              },
                                'Download offer letter',
                                viewJobDetailResponse?.data?.lastDate
                                        .toString() ??
                                    '')

                                : const SizedBox.shrink(),
                        widget.status == '2'
                            ? const SizedBox(
                                height: 10,
                              )
                            : const SizedBox.shrink(),
                        const Text(
                          'Your Application Status',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colors.primary),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.status == '0'
                              ? 2
                              : widget.status == '1'
                                  ? 3
                                  : widget.status == '2'
                                      ? 6
                                      : listDetails.length,
                          itemBuilder: (context, index) {
                            return stapperWidget(index: index);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ])),
      ),
    );
  }

  Widget stapperWidget({required int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: index == 1 &&
                  (viewJobDetailResponse?.data?.jobRounds?.isNotEmpty ?? false)
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Color(0xffEEEEEE),
              radius: 22,
              child: index == 5 && widget.status == '3'
                  ? const Icon(
                      Icons.close,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
            ),
            index == listDetails.length - 1
                ? Container()
                : (viewJobDetailResponse?.data?.jobRounds?.isNotEmpty ??
                            false) &&
                        index == 1
                    ? Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 15,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              for (int i = 0;
                                  i <
                                      (viewJobDetailResponse
                                              ?.data?.jobRounds?.length ??
                                          0);
                                  i++)
                                JobRoundWidget(
                                  roundTitle: viewJobDetailResponse
                                          ?.data?.jobRounds?[i].roundTitle ??
                                      '',
                                  roundDescription: viewJobDetailResponse?.data
                                          ?.jobRounds?[i].roundDescription ??
                                      '',
                                  status: viewJobDetailResponse
                                          ?.data?.jobRoundsStatus?[i].status ??
                                      1,
                                ),
                            ],
                          )
                        ],
                      )
                    : Container(
                        height: 25,
                        width: 1,
                        color: Colors.grey,
                      )
          ],
        ),
        index != 1 &&
                (viewJobDetailResponse?.data?.jobRounds?.isNotEmpty ?? false)
            ? const SizedBox(
                width: 90,
              )
            : const SizedBox(
                width: 0,
              ),
        Container(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  index == 5 && widget.status == '3'
                      ? 'Rejected'
                      : listDetails[index],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.status == '0'
                    ? '${DateFormat('ddMMM').format(DateTime.parse(viewJobDetailResponse?.data?.createdAt ?? ''))}'
                    : '${DateFormat('ddMMM').format(DateTime.parse(viewJobDetailResponse?.data?.updatedAt ?? ''))}',
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
        )
      ],
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
      height: MediaQuery.of(context).size.height * 0.35,
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
    print(widget.jobId);
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
      isLoading = true;
    });
    String coursesURL = "${APIData.jobDetail}${APIData.secretKey}";
    print("All Courses API Status Code : ${coursesURL}");

    Response res = await post(Uri.parse(coursesURL), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    }, body: {
      "job_id": "${widget.jobId}"
    });
    log("All Courses API Response : ${res.body}");

    print("All Courses API Status Code : ${res.statusCode}");

    if (res.statusCode == 200) {
      var result = jsonDecode(res.body);
      if (result['status']) {
        Fluttertoast.showToast(msg: '${result['message']}');
      } else {
        Fluttertoast.showToast(msg: '${result['message']}');
      }
    } else {
      throw "Can't get courses.";
    }
  }

  Widget downloadBtn(VoidCallback onPress, String title, String lastDate) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: colors.lightgray,
              offset: Offset(
                0.0,
                3.0,
              ),
              blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colors.secondary, colors.primary]),
          //  color: colors.primary,
        ),
        width: MediaQuery.of(context).size.width * 0.6,
        height: 50,
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$title",
              style: const TextStyle(
                  color: colors.whiteTemp,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "*expire on $lastDate",
              style: TextStyle(
                  color: colors.whiteTemp,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ],
        )),
      ),
    );
  }
}

// Assuming your job rounds data is stored in a variable named jobRoundsDat

// Create a new widget for displaying job rounds
class JobRoundWidget extends StatelessWidget {
  final String roundTitle;
  final String roundDescription;
  final int status;

  const JobRoundWidget({
    Key? key,
    required this.roundTitle,
    required this.roundDescription,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xffEEEEEE),
              radius: 10,
              child: status == 1
                  ? const Icon(
                      Icons.check,
                      size: 10,
                      color: Colors.green,
                    )
                  : const Icon(
                      Icons.close,
                      size: 10,
                      color: Colors.red,
                    ),
            ),
            // Add the vertical line if it's not the last round
            true
                ? Container(
                    height: 25,
                    width: 1,
                    color: Colors.grey,
                  )
                : Container()
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                roundTitle,
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(
                    status == 0 ? 'Not Cleared' : 'Cleared',
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => buildSuccessDialog(
                            context, roundDescription, roundTitle),
                      );
                    },
                    child: const Text(
                      'See detail',
                      style: TextStyle(
                          fontSize: 10,
                          color: colors.primary,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSuccessDialog(
      BuildContext context, String roundDescription, String roundTitle) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          dialogBox(roundDescription, roundTitle),
        ],
      ),
      actions: const <Widget>[],
    );
  }

  Widget dialogBox(String roundDescription, String roundTitle) {
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
                  borderRadius: BorderRadius.circular(5.00),
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
                        image: AssetImage('assets/images/Group 75380.png'),
                        height: 175,
                        width: 175,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 18,
                        top: 14,
                        right: 18,
                      ),
                      child: Text(
                        roundTitle,
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
                      child: Text(
                        roundDescription,
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
                    /*Padding(
                      padding: const EdgeInsets.only(
                          left: 10,
                          top: 39,
                          right: 5,
                          bottom: 10
                      ),
                      child: FilledBtn(title: 'Subscribe',onPress: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SubscriptionPlanScreen(),));
                      }),
                    )*/
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

// Use the new JobRoundWidget in your existing widget
