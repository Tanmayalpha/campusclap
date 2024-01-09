import 'dart:convert';

import 'package:campusclap/Models/get_profile_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import '../Models/get_city_response.dart';
import 'Academic_details.dart';

class College_Details extends StatefulWidget {
  final bool? isFromDrawerMenu;

  const College_Details({super.key, this.isFromDrawerMenu});

  @override
  State<College_Details> createState() => _College_DetailsState();
}

class _College_DetailsState extends State<College_Details> {
  TextEditingController collegeNameC = TextEditingController();
  TextEditingController collegeSateC = TextEditingController();
  TextEditingController collegeDistrictC = TextEditingController();
  TextEditingController collegePlaceC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  TextEditingController mobileController = TextEditingController();
  ProfileData? profileData ;
  StateData? selectedStated;
  StateData? selectedDistrict;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getState();
    if (widget.isFromDrawerMenu ?? false){
      getProfileData();
    }

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context, false);
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        colors.primary,
                        colors.secondary,
                        colors.secondary
                      ]),
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ),
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              //    padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: _formKey,
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Present College Details",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: colors.primary),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Fill up the following details to Present College Details and enjoy our services ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'College Name',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          style: const TextStyle(color: colors.black54),
                          controller: collegeNameC,
                          cursorColor: Colors.black54,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            fillColor: Colors.white,
                            hintText: 'College Name',
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return " College Name is required";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'College State',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        /*TextFormField(
                          style: const TextStyle(color: colors.black54),
                          controller: collegeSateC,
                          cursorColor: Colors.black54,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            fillColor: Colors.white,
                            hintText: 'College State',
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return " College State is required";
                            }
                          },
                        )*/
                        Container(
                          decoration: BoxDecoration(
                            // color: MyColorName.colorBg2,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: colors.black12,width: 2)
                          ),
                          child: DropdownButton<StateData>(
                            padding: const EdgeInsets.only(left: 15,right: 10),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            style: const TextStyle(color: Colors.black54,fontSize: 16,),
                            menuMaxHeight: 600,
                            hint: const Text("Select State",style: TextStyle(color: Colors.black54),),
                            value: selectedStated,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              // color: MyColorName.primaryDark,
                            ),
                            items: stateList.map((StateData value) {
                              return DropdownMenuItem<StateData>(
                                value: value,
                                child: Text(value.statenName!),
                              );
                            }).toList(),
                            isExpanded: true,
                            underline: const SizedBox(),
                            onChanged: (StateData? value) {
                              setState(() {
                                selectedStated = value;

                              });
                              getCity(selectedStated?.id.toString() ?? '');
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'College District',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        /*TextFormField(
                          style: const TextStyle(color: colors.black54),
                          controller: collegeDistrictC,
                          cursorColor: Colors.black54,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            fillColor: Colors.white,
                            hintText: 'College District',
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return " College District is required";
                            }
                          },
                        )*/
                Container(
                  decoration: BoxDecoration(
                    // color: MyColorName.colorBg2,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: colors.black12,width: 2)
                  ),
                  child: DropdownButton<StateData>(
                    padding: const EdgeInsets.only(left: 15,right: 10),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    style: const TextStyle(color: Colors.black54,fontSize: 16,),
                    menuMaxHeight: 600,
                    hint: const Text("Select District",style: TextStyle(color: Colors.black54),),
                    value: selectedDistrict,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      // color: MyColorName.primaryDark,
                    ),
                    items: cityList.map((StateData value) {
                      return DropdownMenuItem<StateData>(
                        value: value,
                        child: Text(value.cityName!),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox(),
                    onChanged: (StateData? value) {
                      setState(() {
                        selectedDistrict = value;

                      });
                    },
                  ),
                ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'College Place',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          style: const TextStyle(color: colors.black54),
                          controller: collegePlaceC,
                          cursorColor: Colors.black54,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                            fillColor: Colors.white,
                            hintText: 'College Place',
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: colors.black12, width: 2)),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return " College Place is required";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.13),
                          child: ComenBtn(
                            title: widget.isFromDrawerMenu ?? false
                                ? 'Submit'
                                : 'Next',
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, save the input.
                                _formKey.currentState!.save();
                                // Now, you can use the validated input, which is stored in _inputText.
                                // print('Input Text: $_inputText');
                                if ((widget.isFromDrawerMenu ?? false)) {
                                  if(selectedStated == null) {
                                    Fluttertoast.showToast(msg: 'please select state');
                                  }else if(selectedDistrict == null) {
                                    Fluttertoast.showToast(msg: 'please select district');
                                  }else{
                                  updateProfileMethod();
                                  }
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  AcademicDetails(
                                          collegeState: selectedStated?.id.toString(),
                                          collegeName: collegeNameC.text,
                                          collegePlace: collegePlaceC.text,
                                          collegeDistrict: selectedDistrict?.id.toString()
                                          ,
                                        )),
                                  );
                                }
                              }

                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ])))),
    );
  }


  Future<void> updateProfileMethod() async {

    var parms = {
      'college_name': collegeNameC.text,
      'college_state': selectedStated?.id.toString() ?? '',
      'college_dictrict': selectedDistrict?.id.toString() ?? '',
      'college_place': collegePlaceC.text
    };

    var response = await updateProfile(parms);

    if ((response?.status ?? false)) {
      Navigator.pop(context, true);
    }
  }

  getProfileData () async{
    profileData = await getProfile();
    collegeNameC.text = profileData?.collegeName ?? '';
    collegeSateC.text = profileData?.collegeState ?? '';
    collegeDistrictC.text = profileData?.collegeDictrict ?? '';
    collegePlaceC.text = profileData?.collegePlace ?? '';

    selectedStated = stateList.firstWhere((element) {
      if(element.id.toString() == profileData?.collegeState) {
        return true ;
      }
      return false ;
    });

    selectedDistrict = cityList.firstWhere((element) {
      if(element.id.toString() == profileData?.collegeDictrict) {
        return true ;
      }
      return false ;
    });

    setState(() {

    });
  }

  List <StateData> stateList = [];
  List<StateData> cityList = [];

  Future<void> getState() async {

    const String coursesURL = "${APIData.getState}${APIData.secretKey}";
    print("All Courses API Status Code : ${coursesURL}");

    Response res = await get(Uri.parse(coursesURL), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });
    if (res.statusCode == 200) {

      var result = jsonDecode(res.body);
      print(res.body);
      stateList = GetStatesResponse.fromJson(result).data ?? [] ;


      setState(() {
      });
    } else {
      setState(() {
      });
      throw "Can't get courses.";
    }
  }

  Future<void> getCity(String stateId) async {
    String coursesURL = "${APIData.getCity}$stateId";
    print("All Courses API Status Code : ${coursesURL}");

    Response res = await get(Uri.parse(coursesURL), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $authToken",
    });
    if (res.statusCode == 200) {
      var result = jsonDecode(res.body);
      print(res.body);
      cityList = GetStatesResponse.fromJson(result).data ?? [];

      setState(() {});
    } else {
      setState(() {});
      throw "Can't get courses.";
    }
  }





}
