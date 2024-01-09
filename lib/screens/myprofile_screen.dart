import 'package:cached_network_image/cached_network_image.dart';
import 'package:campusclap/Models/get_profile_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/screens/personal_information.dart';
import 'package:campusclap/screens/upload_image.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Academic_details.dart';
import 'College_details.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key,this.isDrawer });
  final bool? isDrawer ;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileData ();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                MediaQuery.of(context).size.height * 0.25,
              ),
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  //padding: EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                      color: colors.secondary,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     widget.isDrawer ?? false ? InkWell(
                        onTap: () {
                             Navigator.pop(context);
                        },
                        child: Container(
                          // margin: EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.arrow_back,
                            color: colors.secondary,
                          ),
                        ),
                      ) : const SizedBox(width: 35,),

                      const Column(children: [
                        SizedBox(height: 10,),
                        Text(
                          "My Profile",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      ],),
                      Container(
                        // margin: EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),

                        child: const Icon(
                          Icons.notifications_active_rounded,
                          color: colors.secondary,
                        ),
                      ),
                    ],
                  ))),
          backgroundColor: colors.bgColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                 Center(
                    child: Text(
                      profileData?.fname ?? "",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                const SizedBox(
                  height: 5,
                ),
                 Center(
                    child: Text(
                      profileData?.email ?? '',
                  style: TextStyle(fontSize: 20),
                )),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonalInformation(isPromDrawerMenu: true,)),
                    ).then((value)  {

                      if(value !=null) {
                           getProfileData();
                      }

                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.white,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(
                              color: colors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tell us about Personal Details',
                          style: TextStyle(
                            //  color: colors.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const College_Details(isFromDrawerMenu: true,)),
                    ).then((value)  {

                      if(value !=null) {
                        getProfileData();
                      }

                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.white,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Present college details',
                          style: TextStyle(
                              color: colors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tell us if you Education',
                          style: TextStyle(
                            //  color: colors.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AcademicDetails(isFromDrawerMenu: true,)),
                    ).then((value)  {

                      if(value !=null) {
                        getProfileData();
                      }

                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.white,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Academic Details',
                          style: TextStyle(
                              color: colors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tell us if you Education',
                          style: TextStyle(
                            //  color: colors.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadProfileDocScreen(isFromDrawerMenu: true,)),
                    ).then((value)  {

                      if(value !=null) {
                        getProfileData();
                      }

                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    color: Colors.white,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Uploads',
                          style: TextStyle(
                              color: colors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Tell us if you Education',
                          style: TextStyle(
                            //  color: colors.primary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.31,
          alignment: Alignment.bottomCenter,
          child:  CachedNetworkImage(imageUrl: profileData?.selfieImage ?? '', placeholder: (context, url) => const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(
                "assets/placeholder/avatar.png",
              )),
            imageBuilder: (context, imageProvider) => Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            errorWidget: (context, url, error) =>  CircleAvatar(
              radius: 55,
            backgroundImage: NetworkImage(
                "https://picsum.photos/800/600/?random",
            )),),
        )
      ],
    );
  }

  ProfileData? profileData;
getProfileData () async{
  profileData = await getProfile();
  setState(() {

  });
}


}
