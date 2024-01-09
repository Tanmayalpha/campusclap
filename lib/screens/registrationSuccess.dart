
import 'dart:convert';

import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;


import 'bottom_navBar.dart';

class RegistrationSuccessScreen extends StatefulWidget {
  const RegistrationSuccessScreen({super.key});

  @override
  State<RegistrationSuccessScreen> createState() =>
      _RegistrationSuccessScreenState();
}

class _RegistrationSuccessScreenState extends State<RegistrationSuccessScreen> {

  bool isLoading = false ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContent() ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      body: isLoading ? const Center(child: CircularProgressIndicator(color: colors.primary),) :  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(color: Colors.grey, blurRadius: 1)
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Great !",
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: colors.secondary),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "your account Created Successfully ! \n$content ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  ),

                  Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: const Center(
                        child: Image(
                            image: AssetImage('assets/images/yeeeeeeeeeehhhh.png')),
                      ))
                ],
                
              ),
              
              
            ),
             const SizedBox(
                            height: 50,
                          ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.13),
              child: ComenBtn(
                title: 'Get Certification',
                onPress: () {
                   Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => BottomNavBar(dIndex: 1,)),
                       );

                },
              ),
            )
          ],
        ),
      ),
    );
  }

String content = 'Enhance your profile by gaining certifications! Explore free courses on the platform';
  Future<void> getContent() async {
    setState(() {
      isLoading = true ;
    });

    authToken = await storage.read(key: "token");
    String url = APIData.addToCart + "${APIData.secretKey}";
    http.Response res = await http.post(Uri.parse(url), body: {
      "slug": 'post-profile-completion'
    }, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });
    print('${res.statusCode}______addtocart_______');
    print('${res.body}__________addtocart___');

    if (res.statusCode == 200) {

      var result = jsonDecode(res.body) ;
      content = result ['content']  ;
      setState(() {
        isLoading = false ;
      });

    } else {
      setState(() {
        isLoading = false ;
      });
    }
  }

}