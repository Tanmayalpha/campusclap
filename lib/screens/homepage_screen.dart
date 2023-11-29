
import 'dart:ui';

import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'appliedjob_details.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {},
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
            const SizedBox(
              height: 10,
            ),
            Row(
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
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Job Openings And Internships",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: colors.primary),
                ),
                Text(
                  "View all",
                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (context, index) {
                return jobOpeningContainer();
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
                  "Applied Jobs",
                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: colors.primary),
                ),
                Text(
                  "View all",
                  style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
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
              itemCount: 3,
              itemBuilder: (context, index) {
                return Stack(

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
                    )]);
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
              itemCount: 3,
              itemBuilder: (context, index) {
                return Stack(
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
                );
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
                    Container(
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
                        ))
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget jobOpeningContainer() {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10),
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
                            margin: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        "assets/icons/jobsDummyIcon.png"))),
                          )),
                      Expanded(
                          flex: 4,
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
                              ))),
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: const Text(
                              "15 days left",
                              style: TextStyle(
                                  color: colors.primary, fontSize: 8,fontWeight: FontWeight.bold),
                            ),
                          )),
                    ]),
              )),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: const Text(
                  "Ui/Ux designer",
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
                    Expanded(
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
                    )
                  ],
                ),
              )),
        ],
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AppliedJobDetailsWidget()),
                                );
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
}