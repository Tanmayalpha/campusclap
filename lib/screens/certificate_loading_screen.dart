import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:campusclap/Models/course_detail_response.dart';
import 'package:campusclap/Models/course_with_progress.dart';
import 'package:campusclap/Services/payment_services/razor_pay.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/screens/pdf_viewer.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class CertificateLoadingScreen extends StatefulWidget {
  CertificateLoadingScreen({this.courseDetails, this.isPaid});

  final CourseDetailResponse? courseDetails;
  final bool? isPaid;

  @override
  _CertificateLoadingScreenState createState() =>
      _CertificateLoadingScreenState();
}

class _CertificateLoadingScreenState extends State<CertificateLoadingScreen> {

  Future<void>  loadData() async {
    int? progressId = widget.courseDetails!.course!.id;//await getProgressId(widget.courseDetails!.course!.id as int);

    String url = APIData.certificate +
        progressId.toString() +
        "?secret=${APIData.secretKey}";

    print('${url}');

    http.Response response = await http.get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $authToken",
      },
    );
print('${response.body}');
    if (response.statusCode == 200) {
      Uint8List bytes = response.bodyBytes;
      String dir = (await getApplicationDocumentsDirectory()).path;
      File file = File(
          "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + ".pdf");
      await file.writeAsBytes(bytes);
      var filePath = file.path;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewer(
            filePath: filePath,
            isLocal: true,
            isCertificate: true,
          ),
        ),
      );
    } else if (response.statusCode == 400) {
      await Fluttertoast.showToast(
          msg: "Please_Complete_your_course_to_get_certificate",
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      Navigator.pop(context);
    } else {
      print("Certificate API Status Code :-> ${response.statusCode}");
      print('Certificate is not loading!');
      Navigator.pop(context);
    }
  }

  Future<int?> getProgressId(int courseId) async {
    String url = "${APIData.courseProgress}${APIData.secretKey}";
    http.Response res = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
      //  HttpHeaders.authorizationHeader: "Bearer $authToken",
      },
      body: {"course_id": courseId.toString()},
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body)["progress"];
      if (body == null) return 0;
      Progress progress = Progress.fromJson(body);
      return progress.id;
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
   // loadData();
   // checkCertificatePaidOnNot();
    print('${widget.isPaid}__________bvbnvm___');
  /*  if(widget.isPaid ?? false){*/
      loadData();
    /*}else {
      checkCertificatePaidOnNot();
    }*/

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          ),
          Text(
            'Loading',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20.0,
            ),
          ),
        ],
      )),
    );
  }


  Future<bool> addtocart(String transactionid) async {
    String id = widget.courseDetails!.course!.id.toString() ;
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

    } else
      return false;
  }

  Future<bool> payForCertificate( String transactionId) async {
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
      loadData();
      return true;
    } else {
      return false;
    }
  }

bool? isCoursePaid ;
  String? amount ;

  Future<bool> checkCertificatePaidOnNot() async {
    https://campus.developmentalphawizz.com/api/check_certificate/38?secret=63e3df9b-cf41-42f1-a149-80cf768e74b1
    var sendResponse = await http.get(
      Uri.parse("${APIData.checkCertificate}${widget.courseDetails!.course!.id}?secret=${APIData.secretKey}"),

      headers: {
        HttpHeaders.authorizationHeader: "Bearer $authToken",
        HttpHeaders.acceptHeader: "Application/json",
      },

    );

    print(sendResponse.request);
    if (sendResponse.statusCode == 200) {

      var result = jsonDecode(sendResponse.body);
      isCoursePaid = result['status'];
      if(!(isCoursePaid ?? true)){
        amount  = result['data']['price'].toString() ;
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'This is paid certificate',
          desc: 'You have to pay $amount to get certificate!',
          btnCancelOnPress: () {
            Navigator.pop(context);
          },
          btnOkOnPress: () {
            RazorPayHelper razorPay =  RazorPayHelper(
                amount ?? '1', context, (result) {
              if (result != "error") {
                //payOrder(widget.model.bookingId, result);
                addtocart(result);

              } else {

              }
            });
            razorPay.init();
          },
        ).show();
        setState(() {

        });
      }else {
        isCoursePaid = true ;
        loadData();
      }

      return true;
    } else {
      var result = jsonDecode(sendResponse.body);
      Fluttertoast.showToast(msg: result[0]);
      Navigator.pop(context);
      return false;
    }
  }


}
