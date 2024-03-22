import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:campusclap/Models/book_slot_response.dart';
import 'package:campusclap/Models/course_detail_response.dart';
import 'package:campusclap/Models/get_assessment_response.dart';
import 'package:campusclap/Services/payment_services/razor_pay.dart';
import 'package:campusclap/Utils/Color.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificateExamScreen extends StatefulWidget {
  const CertificateExamScreen({Key? key, this.courseDetails, this.ispaid})
      : super(key: key);
  final CourseDetailResponse? courseDetails;
  final bool? ispaid;

  @override
  State<CertificateExamScreen> createState() => _CertificateExamScreenState();
}

class _CertificateExamScreenState extends State<CertificateExamScreen> {
  bool? isCoursePaid;

  String? amount;

  String? slotId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.courseDetails?.assessmentBookingSlotId == null) {
      getBookingSlots();
    } else {
      getaAssessmentDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: commonAppBar(context, text: 'Certificate Exam')),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: colors.primary,
                ),
              )
            : widget.courseDetails?.assessmentBookingSlotId == null
                ? slotList.isEmpty
                    ? const Center(child: Text('No slot found'))
                    : Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: colors.whiteTemp,
                                  boxShadow: const [
                                    BoxShadow(
                                        spreadRadius: 0.5,
                                        blurRadius: 1,
                                        offset: Offset(1, 1),
                                        color: colors.darkColor),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: colors.darkColor)),
                              child: Center(
                                child: selectedDate != null
                                    ? Text('${date}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: colors.textColor,
                                            fontSize: 20))
                                    : const Text('Select Date',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: colors.textColor,
                                            fontSize: 20)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 50,
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 2.0,
                              ),
                              itemCount: slotList.length,
                              itemBuilder: (context, index) {
                                final date = slotList[index];
                                DateTime time = DateFormat('HH:mm:ss')
                                    .parse(date.fromTime ?? '');
                                DateTime time2 = DateFormat('HH:mm:ss')
                                    .parse(date.toTime ?? '');

                                String formaTime =
                                    DateFormat('h:mm a').format(time);
                                String toTime =
                                    DateFormat('h:mm a').format(time2);
                                return Card(
                                    child: InkWell(
                                  onTap: () {
                                    slotList.forEach((element) {
                                      element.isSelected = false;
                                    });
                                    slotList[index].isSelected = true;

                                    setState(() {});
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    height: 40,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        color: date.isSelected ?? false
                                            ? colors.primary
                                            : colors.whiteTemp,
                                        boxShadow: const [
                                          BoxShadow(
                                              spreadRadius: 0.5,
                                              blurRadius: 1,
                                              offset: Offset(1, 3),
                                              color: colors.darkColor),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: colors.primary)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          ' ${formaTime}',
                                          style: TextStyle(
                                              color: date.isSelected ?? false
                                                  ? colors.whiteTemp
                                                  : colors.textColor),
                                        ),
                                        Text(
                                          'To',
                                          style: TextStyle(
                                              color: date.isSelected ?? false
                                                  ? colors.whiteTemp
                                                  : colors.textColor),
                                        ),
                                        Text('${toTime}',
                                            style: TextStyle(
                                                color: date.isSelected ?? false
                                                    ? colors.whiteTemp
                                                    : colors.textColor))
                                      ],
                                    ),
                                  ),
                                ));
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          btnLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: colors.primary,
                                  ),
                                )
                              : ComenBtn(
                                  title: 'Book Selected Slots',
                                  onPress: () {
                                    for (int i = 0; i < slotList.length; i++) {
                                      if (slotList[i].isSelected ?? false) {
                                        slotId = slotList[i].id;
                                      }
                                    }

                                    if (slotId != null) {
                                      checkCertificatePaidOnNot();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'select slot first');
                                    }
                                  },
                                ),
                          SizedBox(height: 16),
                        ],
                      )
                : assessmentWidget(),
      ),
    );
  }

  List<SlotData> slotList = [];

  List<List<SlotData>> finalSlotList = [];

  bool isLoading = false;

  bool btnLoading = false;

  String? userId ;

  Future<void> getBookingSlots() async {
    String id = widget.courseDetails!.course!.id.toString();
    setState(() {
      isLoading = true;
    });
    print("stud${APIData.getSlotes}${APIData.secretKey}");
    http.Response res = await http
        .post(Uri.parse("${APIData.getSlotes}${APIData.secretKey}"), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    }, body: {
      'course_id': id //'40'/*widget.courseDetails?.course?.id.toString()*/
    });

    log('${res.headers}');
    debugPrint('${res.request}');
    debugPrint('${widget.courseDetails?.course?.id}');

    //debugPrint(res.body);
    // debugPrint('initially purchased${res.statusCode.toString()}');
    if (res.statusCode == 200) {
      log('${res.body}');
      slotList = BookSlotResponse.fromJson(json.decode(res.body)).data ?? [];

      /*Map<String, List<SlotData>> groupedSlots = {};

      for (SlotData number in slotList) {

        groupedSlots[number.date ?? ''] = groupedSlots.containsKey(number.date)
             ? [...groupedSlots[number.date]!, number]
            : [number];

      }


      List<SlotData> duplicates = [];
      Set<String> uniqueNumbers = Set<String>();

      for (SlotData number in slotList) {
        if (!uniqueNumbers.add(number.date ?? '')) {
          // If add returns false, it means the number is a duplicate
          duplicates.add(number);
        }
      }

      for(int i=0;i<duplicates.length;i++){
        print(groupedSlots[duplicates[i].date]);
      }*/

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

  Future<void> bookingSlots() async {
    print("stud${APIData.bookSlot}${APIData.secretKey}");
    http.Response res = await http
        .post(Uri.parse("${APIData.bookSlot}${APIData.secretKey}"), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    }, body: {
      'slot_id': slotId,
      'booking_date': selectedDate.toString()
    });

    log('${res.headers}');
    debugPrint('${res.request}');
    debugPrint('${widget.courseDetails?.course?.id}');

    //debugPrint(res.body);
    // debugPrint('initially purchased${res.statusCode.toString()}');
    var result = jsonDecode(res.body);
    if (res.statusCode == 200) {
      log('${res.body}');

      var result = jsonDecode(res.body);

      Fluttertoast.showToast(msg: 'slot booked');
      setState(() {
        btnLoading = false;
      });
      Navigator.pop(context);
    } else {
      result['message'];
      setState(() {
        btnLoading = false;
      });
      throw "Can't book slot.";
    }
  }

  Future<bool> checkCertificatePaidOnNot() async {
    setState(() {
      btnLoading = true;
    });
    var sendResponse = await http.get(
      Uri.parse(
          "${APIData.checkCertificate}${widget.courseDetails!.course!.id}?secret=${APIData.secretKey}"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $authToken",
        HttpHeaders.acceptHeader: "Application/json",
      },
    );

    print(sendResponse.request);
    if (sendResponse.statusCode == 200) {
      var result = jsonDecode(sendResponse.body);
      isCoursePaid = result['status'];
      if (!(isCoursePaid ?? true)) {
        amount = result['data']['price'].toString();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Book Your Exam Slot',
          desc: 'You have to pay $amount to book slot!',
          btnCancelOnPress: () {
            Navigator.pop(context);
          },
          btnOkOnPress: () {
            RazorPayHelper razorPay =
                RazorPayHelper(amount ?? '1', context, (result) {
              if (result != "error") {
                //payOrder(widget.model.bookingId, result);
                addtocart(result);
              } else {}
            });
            razorPay.init();
          },
        ).show();
        setState(() {});
      } else {
        isCoursePaid = true;
        bookingSlots();
      }

      return true;
    } else {
      var result = jsonDecode(sendResponse.body);
      Fluttertoast.showToast(msg: result[0]);
      Navigator.pop(context);
      return false;
    }
  }

  Future<bool> addtocart(String transactionid) async {
    String id = widget.courseDetails!.course!.id.toString();
    authToken = await storage.read(key: "token");
    String url = APIData.addToCart + "${APIData.secretKey}";
    http.Response res = await http.post(Uri.parse(url), body: {
      "course_id": id
    }, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });
    print('${res.statusCode}______addtocart_______');
    print('${res.body}__________addtocart___');

    if (res.statusCode == 200) {
      payForCertificate(transactionid);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> payForCertificate(String transactionId) async {
    var sendResponse = await http.post(
      Uri.parse("${APIData.payStore}${APIData.secretKey}"),
      body: {
        "transaction_id": "$transactionId",
        "payment_method": "online",
        "pay_status": "1",
        "sale_id": "null",
      },
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $authToken",
        HttpHeaders.acceptHeader: "Application/json",
      },
    );
    print('${sendResponse.statusCode}______payForCertificate_______');
    print('${sendResponse.body}__________payForCertificate___');
    if (sendResponse.statusCode == 200) {
      // loadData();

      bookingSlots();
      return true;
    } else {
      return false;
    }
  }

  GetAssessmentResponse? assessmentResponse;

  Future<void> getaAssessmentDetail() async {
    setState(() {
      isLoading = true;
    });
    String id = widget.courseDetails!.course!.id.toString();
    authToken = await storage.read(key: "token");
    String url = APIData.getAssessment + "${APIData.secretKey}";
    http.Response res = await http.post(Uri.parse(url), body: {
      "course_id": id //'40'
    }, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });
    print('${res.statusCode}______addtocart_______');
    print('${res.body}__________addtocart___');

    if (res.statusCode == 200) {
      assessmentResponse = GetAssessmentResponse.fromJson(jsonDecode(res.body));
      userId = await LocalRepository.getPrefrence(LocalRepository.userId) ;

      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget assessmentWidget() {


    DateTime fromDate = DateTime.parse(
        '${assessmentResponse?.data?.bookedslotes?.date} ${assessmentResponse?.data?.bookedslotes?.fromTime}');
    DateTime toDate = DateTime.parse(
        '${assessmentResponse?.data?.bookedslotes?.date} ${assessmentResponse?.data?.bookedslotes?.toTime}');


    bool isButtonVisible = DateTime.now().isAfter(fromDate) && DateTime.now().isBefore(toDate);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeading('Assessment Details'),
              _buildDetail(
                  'Title', assessmentResponse?.data?.details?.title ?? ''),
              _buildDetail('Description',
                  assessmentResponse?.data?.details?.description ?? ''),
              _buildDetail('Marks',
                  assessmentResponse?.data?.details?.marks.toString() ?? ''),
              _buildDetail(
                  'Passing Marks',
                  assessmentResponse?.data?.details?.passingMarks.toString() ??
                      ''),
              _buildDetail('Course Name',
                  assessmentResponse?.data?.details?.coursename ?? ''),
              const SizedBox(height: 16),
              _buildHeading('Booked Slot Details'),
              _buildDetail(
                  'Slot ID',
                  assessmentResponse?.data?.bookedslotes?.slotId.toString() ??
                      ''),
              // _buildDetail('User ID', bookedSlotDetails.userId.toString()),
              _buildDetail2('Booked on',
                  assessmentResponse?.data?.bookedslotes?.createdAt ?? ''),
              _buildDetail('Booking',
                  assessmentResponse?.data?.bookedslotes?.date ?? ''),
              const SizedBox(height: 16),

              isButtonVisible
                  ? Center(
                      child: ComenBtn(
                        title: 'Give Exam',
                        onPress: () {
                          launchUrl(Uri.parse(
                              '${assessmentResponse?.data?.bookedslotes?.url}/${widget.courseDetails?.course?.id.toString()}/${userId}'));
                        },
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }




  ///https://campus.developmentalphawizz.com/course/assessment/40/10
  Widget _buildHeading(String heading) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        heading,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildDetail2(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(value))),
        ],
      ),
    );
  }

  var selectedDate;

  String? date;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }
}
