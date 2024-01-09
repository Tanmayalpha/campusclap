
import 'dart:convert';

import 'package:campusclap/Models/get_profile_response.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/screens/My_Certificate.dart';
import 'package:campusclap/screens/about_us_screen.dart';
import 'package:campusclap/screens/my_courses.dart';
import 'package:campusclap/screens/paymentHistory.dart';
import 'package:campusclap/screens/terms_condition.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Auth/login_page.dart';
import 'Auth/subscription_plan.dart';
import 'ReferAndEran.dart';
import 'contactUsPage.dart';
import 'courses_screen.dart';
import 'faq.dart';
import 'homepage_screen.dart';
import 'jobs_screen.dart';
import 'mySubscription.dart';
import 'myprofile_screen.dart';
import 'offeredjobs_screen.dart';
import 'privacy_policy.dart';

class BottomNavBar extends StatefulWidget {
  int? dIndex;
  BottomNavBar({super.key, this.dIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Widget? _child;
  int selectedIndex = 2;
  int currentIndex = 99;
  String?  name ;
  String?  email ;
  String?  isPlaneActive ;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  ProfileData? profileData ;
// Create a key
  @override
  void initState() {
    if (widget.dIndex != null) {
      selectedIndex = widget.dIndex!;
      _child = widget.dIndex == 1
          ? const CoursesPage()
          : widget.dIndex == 3
          ? const CoursesPage()
          : const CoursesPage();
    } else {
      _child = const HomePageWidget();
    }

getUserData();
    initPurchasedCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
          child: Scaffold(
            key: _key,
            backgroundColor: colors.bgColor,
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(selectedIndex == 4 ? 0 : 80),
                child: selectedIndex == 2
                    ? homeAppBar(
                  context,
                  text: "Home",
                  ontap: () {
                    _key.currentState!.openDrawer();
                  },
                )
                    : selectedIndex == 4
                    ? Container()
                    : PreferredSize(
                    preferredSize: const Size.fromHeight(80),
                    child: commonAppBar2(context,
                        text: selectedIndex == 0
                            ? "Jobs"
                            : selectedIndex == 3
                            ? "Offer Jobs"
                            : selectedIndex == 4
                            ? "My Profile"
                            : "Courses"))),
            body: _child,
            drawer: Drawer(
              child: ListView(children: [
                 DrawerHeader(
                  decoration: const BoxDecoration(
                    // border: Border(bottom: BorderSide(color: Colors.black)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [colors.primary, colors.secondary])),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(
                          "assets/images/profile.png",
                        ),
                        radius: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            name ?? '',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            email ?? '',
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {

                      if(isPlaneActive == '0'){

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const  SubscriptionPlanScreen(isFromDrawer: true,)),
                        );
                      }else {

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const  MyProfileScreen(isDrawer: true,)),
                        );
                      }


                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'My Profile',
                      icon: Icons.person,
                      tabb: 1,
                      indexx: currentIndex,
                    )),
                isPlaneActive == '0' ? const SizedBox() : const SizedBox(
                  height: 5,
                ),
                isPlaneActive == '0' ? const SizedBox():  InkWell(
                     onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const  AppliedJobScreen(isFromDrawer: true,)),
                      );

                      setState(() {
                        currentIndex = 2;
                      });
                    },
                    child: DrawerIconTab(
                        titlee: 'Offer Job',
                        icon: Icons.file_present_outlined,
                        tabb: 2,
                        indexx: currentIndex)),
                isPlaneActive == '0' ? const SizedBox() : const SizedBox(
                  height: 5,
                ),
                isPlaneActive == '0' ? const SizedBox():InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CoursesPage(isDrawer: true,)),
                      );

                      setState(() {
                        currentIndex = 3;
                      });
                    },
                    child: DrawerIconTab(
                        titlee: 'Courses',
                        icon: Icons.file_copy,
                        tabb: 3,
                        indexx: currentIndex)),
                isPlaneActive == '0' ? const SizedBox(): const SizedBox(
                  height: 5,
                ),
                isPlaneActive == '0' ? const SizedBox():InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>   MyCourses(visible: true)),
                      );

                      setState(() {
                        currentIndex = 4;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'My Courses',
                      icon: Icons.file_copy,
                      tabb: 4,
                      indexx: currentIndex,
                    )),
                 isPlaneActive == '0' ? const SizedBox(): const SizedBox(
                  height: 5,
                ),
                isPlaneActive == '0' ? const SizedBox():InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const  MyCertificate()),
                      );

                      setState(() {
                        currentIndex = 5;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'My Certificate',
                      icon: Icons.file_copy,
                      tabb: 5,
                      indexx: currentIndex,
                    )),
                /*
                isPlaneActive == '0' ? const SizedBox():const SizedBox(
                  height: 5,
                ),
                isPlaneActive == '0' ? const SizedBox():InkWell(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentHistoryPage()),
                        );
                        setState(() {
      currentIndex = 6;
      });
      },
                    child: DrawerIconTab(
                      titlee: 'Payment History',
                      icon: Icons.payment,
                      tabb: 6,
                      indexx: currentIndex,
                    )),
                isPlaneActive == '0' ? const SizedBox(): const SizedBox(
                  height: 5,
                ),
                isPlaneActive == '0' ? const SizedBox():InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const mySubscription()),
                      );

                      setState(() {
                        currentIndex = 7;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'My Subscription',
                      icon: Icons.my_library_books_sharp,
                      tabb: 7,
                      indexx: currentIndex,
                    )),*/
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ContectUsPage()),
                      );

                      setState(() {
                        currentIndex = 8;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'Contact Us',
                      icon: Icons.headphones,
                      tabb: 8,
                      indexx: currentIndex,
                    )),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  const PrivacyPolicy ()),
                      );

                      setState(() {
                        currentIndex = 9;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'Privacy Policy',
                      icon: Icons.privacy_tip,
                      tabb: 9,
                      indexx: currentIndex,
                    )),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsConditionsWidget()),
                      );

                      setState(() {
                        currentIndex = 10;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'Terms & Conditions',
                      icon: Icons.confirmation_num,
                      tabb: 10,
                      indexx: currentIndex,
                    )),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FaqPage()),
                      );

                      setState(() {
                        currentIndex = 11;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'FAQ',
                      icon: Icons.question_answer,
                      tabb: 11,
                      indexx: currentIndex,
                    )),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  AboutUsScreen()),
                      );

                      setState(() {
                        currentIndex = 12;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'About Us',
                      icon: Icons.headphones,
                      tabb: 12,
                      indexx: currentIndex,
                    )),
                const SizedBox(
                  height: 5,
                ),
               profileData?.referralCodeStatus == '0' ? const SizedBox() : InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ReferAndEranScreen(referCode: profileData?.referralCode,)),
                      );


                      setState(() {
                        currentIndex = 13;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'Refer & Earn',
                      icon: Icons.monetization_on,
                      tabb: 13,
                      indexx: currentIndex,
                    )),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );*/

                      onLogOutPressed();

                      setState(() {
                        currentIndex = 14;
                      });
                    },
                    child: DrawerIconTab(
                      titlee: 'Sign Out',
                      icon: Icons.logout_outlined,
                      tabb: 14,
                      indexx: currentIndex,
                    )),
                const SizedBox(
                  height: 20,
                ),
              ]),
            ),
            bottomNavigationBar: FluidNavBar(
              icons: [
                FluidNavBarIcon(
                    icon: Icons.message,
                    // unselectedForegroundColor: Colors.grey,
                    selectedForegroundColor: Colors.white,
                    //  svgPath: "assets/home.svg",
                    backgroundColor: selectedIndex == 0 ? colors.secondary : colors.white10,
                    extras: {"label": "Job"}),
                FluidNavBarIcon(
                  // unselectedForegroundColor: Colors.grey,
                    selectedForegroundColor: Colors.white,
                    icon: Icons.check_circle,
                    backgroundColor:
                    selectedIndex == 1 ? colors.secondary : colors.white10,
                    extras: {"label": "Courses"}),
                FluidNavBarIcon(
                    icon: Icons.home,
                    // unselectedForegroundColor: Colors.grey,
                    selectedForegroundColor: Colors.white,
                    backgroundColor:
                    selectedIndex == 2 ? colors.secondary : colors.white10,
                    extras: {"label": "Home"}),
                FluidNavBarIcon(
                    icon: Icons.document_scanner_sharp,
                    // unselectedForegroundColor: Colors.grey,
                    selectedForegroundColor: Colors.white,
                    backgroundColor:
                    selectedIndex == 3 ? colors.secondary : colors.white10,
                    extras: {"label": "Offered jobs"}),
                FluidNavBarIcon(
                    icon: Icons.person,
                    // unselectedForegroundColor: Colors.grey,
                    selectedForegroundColor: Colors.white,
                    backgroundColor:
                    selectedIndex == 4 ? colors.secondary : colors.white10,
                    extras: {"label": "My Profile"}),
              ],
              onChange: _handleNavigationChange,
              style: const FluidNavBarStyle(
                barBackgroundColor: Colors.white,
              ),
              scaleFactor: 1.2,
              defaultIndex: selectedIndex,
              animationFactor: 0.5,
              itemBuilder: (icon, item) => Semantics(
                label: icon.extras!["label"],
                container: true,
                enabled: true,
                child: Stack(
                  children: [
                    item,
                    Container(
                        width: MediaQuery.of(context).size.width * 0.25 - 25,
                        margin: const EdgeInsets.only(top: 40),
                        child: Center(
                            child: Text(
                              icon.extras!["label"],
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            )))
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<bool> onBackPressed() {
    bool? value;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: const Text(
          "Confirm Exit",
          style: TextStyle(
              fontFamily: 'Mada',
              fontWeight: FontWeight.w700,
              color: colors.secondary),
        ),
        content: const Text(
          "Are you sure that you want to exit",
          style: TextStyle(
            fontFamily: 'Mada',
            color: Color(0xFF3F4654),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel".toUpperCase(),
              style: const TextStyle(
                color: colors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
             // cancelInternetStatus();
              SystemNavigator.pop();
              Navigator.pop(context);
            },
            child: Text(
              "Yes".toUpperCase(),
              style: const TextStyle(
                color: colors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
    return  Future.value(value);
  }

  Future<bool> onLogOutPressed() {
    bool? value;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: const Text(
          "Confirm Exit",
          style: TextStyle(
              fontFamily: 'Mada',
              fontWeight: FontWeight.w700,
              color: colors.secondary),
        ),
        content: const Text(
          "Are you sure you want to logout?",
          style: TextStyle(
            fontFamily: 'Mada',
            color: Color(0xFF3F4654),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async{
              Navigator.pop(context);

            },
            child: Text(
              "Cancel".toUpperCase(),
              style: const TextStyle(
                color: colors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () async{
              // cancelInternetStatus();
              LocalRepository.clearUserSession(context);
              await storage.deleteAll();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage(),), (Route<dynamic> route) => false);
            },
            child: Text(
              "Yes".toUpperCase(),
              style: const TextStyle(
                color: colors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
    return  Future.value(value);
  }



  void _handleNavigationChange(int index) {
    setState(() {
      selectedIndex = index;

      switch (index) {
        case 0:
          _child = const JobScreen();
          break;
        case 1:
          _child = const CoursesPage();
          break;
        case 2:
          _child = const HomePageWidget();
          break;
        case 3:
          _child = const AppliedJobScreen();
          break;
        case 4:
          _child = isPlaneActive == '0' ? const SubscriptionPlanScreen() : const MyProfileScreen() ;
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.bounceOut,
        switchOutCurve: Curves.bounceIn,
        duration: const Duration(milliseconds: 100),
        child: _child,
      );
    });
  }

  void  getUserData() async{
    name = await LocalRepository.getPrefrence(LocalRepository.userName);
    email = (await LocalRepository.getPrefrence(LocalRepository.userEmail));

    profileData =  await getProfile();
    await LocalRepository.setPrefrence(LocalRepository.userPlaneActiveStatus, profileData?.planActive ?? '0') ;
    isPlaneActive = profileData?.planActive ?? '0' ;
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

class DrawerIconTab extends StatefulWidget {
  final IconData? icon;
  final String? titlee;
  final int? tabb;
  final int? indexx;

  DrawerIconTab({Key? key, this.icon, this.titlee, this.tabb, this.indexx})
      : super(key: key);

  @override
  State<DrawerIconTab> createState() => _DrawerIconTabState();
}

class _DrawerIconTabState extends State<DrawerIconTab> {
  var Select = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          gradient: widget.indexx == widget.tabb
              ? const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [colors.secondary, colors.white10])
              : null),
      // color:
      //     widget.indexx == widget.tabb ? colors.secondary : Colors.transparent,
      child: Row(
        children: [
          const SizedBox(
            width: 13,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3), shape: BoxShape.circle),
            height: 40,
            width: 40,
            child: Center(
                child: Icon(
                  widget.icon,
                  color: widget.indexx == widget.tabb ? Colors.amber : Colors.grey,
                  size: 20,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            '${widget.titlee}',
            style: TextStyle(
                fontSize: 15,
                fontWeight: widget.indexx == widget.tabb
                    ? FontWeight.bold
                    : FontWeight.normal,
                color:
                widget.indexx == widget.tabb ? Colors.black : Colors.grey),
          ),
        ],
      ),
    );
  }
}

// class DrawerImageTab extends StatefulWidget {
//   final String? titlee;
//   final String? img;
//   final int? tabb;
//   final int? indexx;
//   DrawerImageTab({Key? key, this.titlee, this.img, this.tabb, this.indexx})
//       : super(key: key);

//   @override
//   State<DrawerImageTab> createState() => _DrawerImageTabState();
// }

// class _DrawerImageTabState extends State<DrawerImageTab> {
//   var Select = 0;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 50,
//       color:
//           widget.indexx == widget.tabb ? colors.secondary : Colors.transparent,
//       child: Row(
//         children: [
//           SizedBox(
//             width: 15,
//           ),
//           Container(
//             height: 25,
//             width: 25,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage('${widget.img}'), fit: BoxFit.fill)),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           Text(
//             '${widget.titlee}',
//             style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: widget.indexx == widget.tabb
//                     ? FontWeight.bold
//                     : FontWeight.normal,
//                 color: Colors.black),
//           ),
//         ],
//       ),
//     );
//   }
// }