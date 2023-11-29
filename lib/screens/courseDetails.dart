
import 'package:campusclap/screens/paymentSuccessful.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CourseDetailsPage extends StatefulWidget {
  const CourseDetailsPage({super.key});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  final items = [
    Container(
      //width: MediaQuery.of(context).size.width,
      child: Image.asset(
        'assets/images/team-job-photo-young-businessmans-working-with-new-project-office (1).png',
        fit: BoxFit.fill,
      ),
    ),
    Image.asset(
      'assets/images/team-job-photo-young-businessmans-working-with-new-project-office (1).png',
      fit: BoxFit.fill,
    ),
    Image.asset(
      'assets/images/team-job-photo-young-businessmans-working-with-new-project-office (1).png',
      fit: BoxFit.fill,
    ),
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: commonAppBar(
              context,
              text: "Course Details",
            )),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(physics: BouncingScrollPhysics(), children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.18,
                  autoPlay: false,
                  enlargeFactor: 1,
                  // aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
                items: items,
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 50,
                  height: 5.5,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: items.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 0.5,
                        width: index == currentIndex ? 20 : 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: index == currentIndex
                              ? colors.primary
                              : Color(0xffFEE9E9E9),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 5,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Holistic Personality Development Course",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colors.primary),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s , when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Duration: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "03:14:00",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Language: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "English",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Level: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          "Beginner",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: Image(
                    image: AssetImage("assets/images/side-view-businesswomen-using-sign-language.png"),
                    fit: BoxFit.fill),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: AlertDialog(
                              title: Center(
                                child: const Text(
                                  'Payment Certification',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: colors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              content: Container(
                                height: 40,
                                child: Column(
                                  children: [
                                    Text(
                                      'Amount',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: colors.secondary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '₹ 7898',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child:
                                      InkWell(

                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => const PaymentSuccessful()),
                                          );
                                          },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  colors.primary,
                                                  colors.secondary,
                                                  colors.secondary
                                                ]),
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: Text(
                                          "Pay Now",
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  colors.primary,
                                  colors.secondary,
                                  colors.secondary
                                ]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Apply For Certificate",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                colors.primary,
                                colors.secondary,
                                colors.secondary
                              ]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Start",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              )
            ])),
      ),
    );
  }
}