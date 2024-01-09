import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:campusclap/Models/get_certificate_response.dart';
import 'package:campusclap/Utils/Color.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';


import '../utils/globle.dart';
import '../widgets/course_grid_item.dart';

class MyCertificate extends StatefulWidget {
  const MyCertificate({Key? key}) : super(key: key);

  @override
  State<MyCertificate> createState() => _MyCertificateState();
}

class _MyCertificateState extends State<MyCertificate> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    my_certificates() ;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight( 80),
            child: commonAppBar(context,text: 'My Certificate') ),
        body: isLoading ? const Center(child: CircularProgressIndicator(color: colors.primary),) : certificateList.isEmpty ? const Center(child: Text('Certificate not available')) : ListView.builder(
          itemCount: certificateList.length,
          itemBuilder: (context, index) {
            return myCertificate(index) ;/*ListTile(
              title: Text('Certificate ${certificateList[index].id}'),
              subtitle: Text('Course ID: ${certificateList[index].courseId}'),
              trailing: IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  shareCertificate(certificateList[index].certificate ?? '');
                },
              ),
            );*/
          },
        ),
      ),
    );

  }

  void shareCertificate(String certificateUrl) {
    Share.share('Check out my certificate: $certificateUrl');
  }
  List <CertificateData> certificateList = [] ;
bool   isLoading =  false ;
  Future<void> my_certificates() async {

    setState(() {
      isLoading = true ;
    });

    var sendResponse = await http.get(
      Uri.parse("${APIData.getCertificate}${APIData.secretKey}"),

      headers: {
        HttpHeaders.authorizationHeader: "Bearer $authToken",
        HttpHeaders.acceptHeader: "Application/json",
      },

    );

    print(sendResponse.request);
    if (sendResponse.statusCode == 200) {
      certificateList =  GetCertificateResponse.fromJson(jsonDecode(sendResponse.body)).data ?? [];
    setState(() {
    isLoading = false ;
    });

    } else {
      setState(() {
        isLoading = false ;
      });
    }
  }


  Widget myCertificate(int index) {
    var item = certificateList [index];
    return Container(
      margin: EdgeInsets.all(10),

      width: MediaQuery.of(context).orientation == Orientation.landscape
          ? 300
          : MediaQuery.of(context).size.width / 1.32,
      decoration: BoxDecoration(
        color: colors.primary,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
              color: const Color(0x1c2464).withOpacity(0.30),
              blurRadius: 20.0,
              offset: Offset(0.0, 15.0),
              spreadRadius: -15.0)
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        color: colors.whiteTemp,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height /
                    (MediaQuery.of(context).orientation == Orientation.landscape
                        ? 4.8
                        : 7.8),
                child: true
                    ? Image.asset("assets/images/Group 75380.png")
                    : CachedNetworkImage(
                  imageUrl: '',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                        image: DecorationImage(
                          image:
                          AssetImage('assets/placeholder/studying.png'),
                          fit: BoxFit.cover,
                        ),
                      )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Certificate: ${item.id}",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            foreground: Paint()..shader = linearGradient,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            shareCertificate(certificateList[index].certificate ?? '');
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Date ${item.createdAt}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: colors.textColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),

                            ],

                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Course : ${item.courseId}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                color: colors.textColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              )
            ],
          ),
          onTap: () {

          },
        ),
      ),
    );
  }

}
