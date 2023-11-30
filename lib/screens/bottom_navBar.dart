
import 'dart:convert';

import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/screens/paymentHistory.dart';
import 'package:campusclap/screens/terms_condition.dart';
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import 'Auth/login_page.dart';
import 'Auth/subscription_plan.dart';
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
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  void initState() {
    if (widget.dIndex != null) {
      selectedIndex = widget.dIndex!;
      _child = widget.dIndex == 1
          ? Container()
          : widget.dIndex == 3
          ? Container()
          : Container();
    } else {
      _child = const HomePageWidget();
    }

getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  child: commonAppBar(context,
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
                decoration: BoxDecoration(
                  // border: Border(bottom: BorderSide(color: Colors.black)),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [colors.primary, colors.secondary])),
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/profile.png",
                      ),
                      radius: 40,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          email ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.white),
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
                        MaterialPageRoute(builder: (context) => const  SubscriptionPlanScreen()),
                      );
                    }else {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const  MyProfileScreen()),
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
              const SizedBox(
                height: 5,
              ),
              isPlaneActive == '0' ? const SizedBox():  InkWell(
                   onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const  OfferJobWidget()),
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
              const SizedBox(
                height: 5,
              ),
              isPlaneActive == '0' ? const SizedBox():InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CoursesPage()),
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
              const SizedBox(
                height: 5,
              ),
              isPlaneActive == '0' ? const SizedBox():InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const  CoursesPage()),
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
              const SizedBox(
                height: 5,
              ),
              isPlaneActive == '0' ? const SizedBox():InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const  CoursesPage()),
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
              const SizedBox(
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
              const SizedBox(
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
                  )),
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
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );

                    setState(() {
                      currentIndex = 12;
                    });
                  },
                  child: DrawerIconTab(
                    titlee: 'Sign Out',
                    icon: Icons.logout_outlined,
                    tabb: 12,
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
        ));
  }

  void _handleNavigationChange(int index) {
    setState(() {
      selectedIndex = index;

      switch (index) {
        case 0:
          _child = const JobOfferWidget();
          break;
        case 1:
          _child = const CoursesPage();
          break;
        case 2:
          _child = const HomePageWidget();
          break;
        case 3:
          _child = const OfferJobWidget();
          break;
        case 4:
          _child = const MyProfileScreen();
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