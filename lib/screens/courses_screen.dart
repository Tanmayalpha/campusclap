
import 'dart:ui';

import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'courseDetails.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
      backgroundColor: colors.bgColor,
       //appBar: PreferredSize(
         //  preferredSize: Size.fromHeight(80),
           //child: commonAppBar(context, text: "Courses")),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 2,
              child: TextFormField(
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
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return isPlaneActive == '0' ? Stack(
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
                ) : coursesWidget(index: index);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
            ),
          ])),
      )
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
          Expanded(
              flex: 3,
              child: Container(
                child: Image(
                    image: AssetImage(index == 0
                        ? 'assets/images/team-job-photo-young-businessmans-working-with-new-project-office.png'
                        : index == 1 || index == 3
                            ? 'assets/images/side-view-businesswomen-using-sign-language.png'
                            : 'assets/images/business-partners-discussing-deal (1).png'),
                    fit: BoxFit.fill),
              )),
          Expanded(
              flex: 5,
                child:
                InkWell(

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CourseDetailsPage()),
                    );
                  },

               child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        index == 0
                            ? 'Holistic Personality Development Course'
                            : index == 1 || index == 3
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
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    colors.primary,
                                    colors.secondary,
                                    colors.secondary
                                  ]),
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            'Start',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  String ? isPlaneActive ;
  void  getUserData() async{
    /* name = await LocalRepository.getPrefrence(LocalRepository.userName);
    email = (await LocalRepository.getPrefrence(LocalRepository.userEmail));*/
    isPlaneActive = (await LocalRepository.getPrefrence(LocalRepository.userPlaneActiveStatus));
    setState(() {

    });

    /*String? data1 = ll?.replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |})'), (match) {
      //return '"${match.group(0)!}"';
     final value = match.group(0)!;

     // Check if the value is empty and handle accordingly
     return value.isEmpty ? '$value' : '"$value"';
    });*/



    //var data = json.decode(data1!);



  }
}