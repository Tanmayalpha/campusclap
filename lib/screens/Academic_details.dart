import 'dart:developer';
import 'dart:io';

import 'package:campusclap/Models/get_graduation_response.dart';
import 'package:campusclap/Models/get_profile_response.dart';
import 'package:campusclap/Models/get_specialization_response.dart';
import 'package:campusclap/screens/custom_select_field.dart';
import 'package:campusclap/screens/personal_information.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/extentions.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Services/api_services/apiConstants.dart';
import '../Services/api_services/apiStrings.dart';
import '../utils/color.dart';
import 'upload_image.dart';

class AcademicDetails extends StatefulWidget {
  final String? collegeName;

  final String? collegeState;

  final String? collegeDistrict;

  final String? collegePlace;

  final bool? isFromDrawerMenu;

  const AcademicDetails(
      {super.key,
      this.collegeName,
      this.collegeState,
      this.collegeDistrict,
      this.collegePlace,
      this.isFromDrawerMenu});

  @override
  State<AcademicDetails> createState() => _AcademicDetailsState();
}

class _AcademicDetailsState extends State<AcademicDetails> {
  TextEditingController tenthPercentageC = TextEditingController();
  TextEditingController twelfthPercentageC = TextEditingController();
  TextEditingController ugStatusC = TextEditingController();
  TextEditingController ugSpecializationC = TextEditingController();
  TextEditingController ugCourseC = TextEditingController();

  TextEditingController ugCgpaC = TextEditingController();
  TextEditingController ugPassingYearC = TextEditingController();
  TextEditingController pgStatusC = TextEditingController();
  TextEditingController pgCourseC = TextEditingController();
  TextEditingController pgSpecializationC = TextEditingController();
  TextEditingController pgCgpaC = TextEditingController();
  TextEditingController pgPassingYearC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  String? pgCourseId;

  String? ugCourseId;

  TextEditingController mobileController = TextEditingController();
  ProfileData? profileData;

  List<String> persueStatus = ['Completed', 'Presently in FinalYear'];

  String? selectedUgStatus;

  String? selectedPgStatus;

  int? selectedUgPassingYear;

  int? selectedPgPassingYear;
  List<String> ugSpIdList = [];
  List<String> pgSpIdList = [];

  SpecializationData? selectedPgSpecialization, selectedUgSpecialization;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getGraduationData();
    getPostGraduationData();
    getSpecialization();
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            "Academic Details",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colors.primary),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Fill up the following details to Academic Details and enjoy our services ",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '10th Percentage/CGPA',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(children: [
                            addRadioButton(0, 'Percent', tenth, isfrom10: true),
                            addRadioButton(1, 'CGPA', tenth, isfrom10: true)
                          ]),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: tenthPercentageC,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.number,
                            decoration:
                                CustomInputDecoration.myCustomInputDecoration(
                                    hintText: select10th == 'Percentage'
                                        ? '10th Percentage'
                                        : '10ht CGPA'),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " 10th Percentage/CGPA is required";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            '12th or Diploma Percentage/CGPA',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(children: [
                            addRadioButton(0, 'Percent', tenth, isfrom12: true),
                            addRadioButton(1, 'CGPA', tenth, isfrom12: true)
                          ]),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: twelfthPercentageC,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                CustomInputDecoration.myCustomInputDecoration(
                                    hintText: '12th Diploma Percentage/CGPA'),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " 12th Diploma Percentage/CGPA is required";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Under Graduation Details",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: colors.primary),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'UG Status:Completed/Presently in FinalYear',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          /*TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: ugStatusC,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                CustomInputDecoration.myCustomInputDecoration(
                                    hintText:
                                        'UG Status:Completed/Presently in FinalYear'),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " UG Status:Completed/Presently in Final Year is required";
                              }
                            },
                          )*/
                          Container(
                            decoration: BoxDecoration(
                                // color: MyColorName.colorBg2,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: colors.black12, width: 2)),
                            child: DropdownButton<String>(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              menuMaxHeight: 600,
                              hint: const Text(
                                "Select ug status",
                                style: TextStyle(color: Colors.black54),
                              ),
                              value: selectedUgStatus,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                // color: MyColorName.primaryDark,
                              ),
                              items: persueStatus.map((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (value) {
                                setState(() {
                                  selectedUgStatus = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Select UG Course',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          /*TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: ugCourseC,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                CustomInputDecoration.myCustomInputDecoration(
                                    hintText: 'Select UG Course'),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Select UG Course";
                              }
                            },
                          ),*/
                          Container(
                            decoration: BoxDecoration(
                                // color: MyColorName.colorBg2,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: colors.black12, width: 2)),
                            child: DropdownButton<GraduationData>(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              menuMaxHeight: 600,
                              hint: const Text(
                                "Select ug Course",
                                style: TextStyle(color: Colors.black54),
                              ),
                              value: selectedUgCourrse,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                // color: MyColorName.primaryDark,
                              ),
                              items: _graduationDataList.map((value) {
                                return DropdownMenuItem<GraduationData>(
                                  value: value,
                                  child: Text(value.name ?? ''),
                                );
                              }).toList(),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (value) {
                                setState(() {
                                  selectedUgCourrse = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Select Specializations-Up to Four Specializations',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          /*Container(
                            decoration: BoxDecoration(
                                // color: MyColorName.colorBg2,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: colors.black12, width: 2)),
                            child: DropdownButton<SpecializationData>(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              menuMaxHeight: 600,
                              hint: const Text(
                                "Select ug specialization",
                                style: TextStyle(color: Colors.black54),
                              ),
                              value: selectedUgSpecialization,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                // color: MyColorName.primaryDark,
                              ),
                              items: _specializationDataList.map((value) {
                                return DropdownMenuItem<SpecializationData>(
                                  value: value,
                                  child: Text(value.name ?? ''),
                                );
                              }).toList(),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (value) {
                                setState(() {
                                  selectedUgSpecialization = value;
                                });
                              },
                            ),
                          )*/
                          TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: ugSpecializationC,
                            readOnly: true,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            onTap: () async {
                              final List<SpecializationData>? results =
                                  await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SpecializationMultiSelect(
                                      items: _specializationDataList);
                                },
                              );
                              if (results != null) {
                                List<String> tempList = [];
                                ugSpIdList.clear();

                                for (var element in results) {
                                  tempList.add(element.name ?? '');
                                  ugSpIdList.add(element.id.toString() ?? '');
                                }

                                ugSpecializationC.text = tempList.join(',');
                              }
                            },
                            decoration:
                                CustomInputDecoration.myCustomInputDecoration(
                                    hintText: 'Specialization'),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Specialization field is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'UG Aggregate/CGPA',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(children: [
                            addRadioButton(0, 'Aggregate', ugpg,
                                isfromug: true),
                            addRadioButton(1, 'CGPA', ugpg, isfromug: true)
                          ]),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: ugCgpaC,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.number,
                            decoration:
                                CustomInputDecoration.myCustomInputDecoration(
                                    hintText: 'UG Aggregate/CGPA'),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " UG Aggregate/CGPA is required";
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'UG PASSING YEAR',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),

                          /*TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: ugPassingYearC,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                CustomInputDecoration.myCustomInputDecoration(
                                    hintText: 'UG PASSING YEAR'),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " UG Passing Year required";
                              }
                            },
                          )*/
                          Container(
                            decoration: BoxDecoration(
                                // color: MyColorName.colorBg2,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: colors.black12, width: 2)),
                            child: DropdownButton<int>(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                              menuMaxHeight: 600,
                              hint: const Text(
                                "UG passing year",
                                style: TextStyle(color: Colors.black54),
                              ),
                              value: selectedUgPassingYear,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_outlined,
                                // color: MyColorName.primaryDark,
                              ),
                              items: getYears(2000).map((value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                              isExpanded: true,
                              underline: SizedBox(),
                              onChanged: (value) {
                                setState(() {
                                  selectedUgPassingYear = value;
                                });
                              },
                            ),
                          ),
                          selectedUgStatus == 'Completed'
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      "Post Graduation Details",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: colors.primary),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'PG Status:Completed/Presently in FinalYear',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          // color: MyColorName.colorBg2,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: colors.black12, width: 2)),
                                      child: DropdownButton<String>(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 10),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                        menuMaxHeight: 600,
                                        hint: const Text(
                                          "Select pg status",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        value: selectedPgStatus,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          // color: MyColorName.primaryDark,
                                        ),
                                        items: persueStatus.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedPgStatus = value;
                                          });
                                        },
                                      ),
                                    ),
                                    /*TextFormField(
                              style: const TextStyle(color: colors.black54),
                              controller: pgStatusC,
                              cursorColor: Colors.black54,
                              keyboardType: TextInputType.emailAddress,
                              decoration:
                              CustomInputDecoration.myCustomInputDecoration(
                                  hintText:
                                  'PG Status:Completed/Presently in FinalYear'),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return " UG Status:Completed/Presently in Final Year is required";
                                }
                              },
                            )*/
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Select PG Course',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    /*TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: pgCourseC,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            decoration:
                                CustomInputDecoration.myCustomInputDecoration(
                                    hintText: 'Select PG Course'),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Select PG Course";
                              }
                            },
                          ),*/
                                    /*CustomSingleSelectField<String>(
                                      items: pgCoursesName,
                                      controller: pgCourseC,
                                      title: "Select PG Course",
                                      onSelectionDone: (value) {
                                        // pgCourseC.text = value ;
                                        print('${value}');
                                        //setState(() {});
                                      },
                                      decoration: CustomInputDecoration
                                          .myCustomInputDecoration(
                                              hintText: 'Select PG Course'),
                                      itemAsString: (item) => item,
                                    )*/
                                    Container(
                                      decoration: BoxDecoration(
                                          // color: MyColorName.colorBg2,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: colors.black12, width: 2)),
                                      child: DropdownButton<GraduationData>(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 10),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                        menuMaxHeight: 600,
                                        hint: const Text(
                                          "Select pg Course",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        value: selectedPGCourrse,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          // color: MyColorName.primaryDark,
                                        ),
                                        items: _postGraduationDataList
                                            .map((value) {
                                          return DropdownMenuItem<
                                              GraduationData>(
                                            value: value,
                                            child: Text(value.name ?? ''),
                                          );
                                        }).toList(),
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedPGCourrse = value;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'Select Specializations-Up to Four Specializations',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      style: const TextStyle(color: colors.black54),
                                      controller: pgSpecializationC,
                                      readOnly: true,
                                      cursorColor: Colors.black54,
                                      keyboardType: TextInputType.emailAddress,
                                      onTap: () async {
                                        final List<SpecializationData>? results =
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return SpecializationMultiSelect(
                                                items: _specializationDataList);
                                          },
                                        );
                                        if (results != null) {
                                          List<String> tempList = [];
                                          pgSpIdList.clear();

                                          for (var element in results) {
                                            tempList.add(element.name ?? '');
                                            pgSpIdList.add(element.id.toString() ?? '');
                                          }

                                          pgSpecializationC.text = tempList.join(',');
                                        }
                                      },
                                      decoration:
                                      CustomInputDecoration.myCustomInputDecoration(
                                          hintText: 'Specialization'),
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return " Specialization field is required";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'PG Aggregate/CGPA',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(children: [
                                      addRadioButton(0, 'Aggregate', ugpg,
                                          isfrompg: true),
                                      addRadioButton(1, 'CGPA', ugpg,
                                          isfrompg: true)
                                    ]),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      style: const TextStyle(
                                          color: colors.black54),
                                      controller: pgCgpaC,
                                      cursorColor: Colors.black54,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: CustomInputDecoration
                                          .myCustomInputDecoration(
                                              hintText: 'PG Aggregate/CGPA'),
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return " PG Aggregate/CGPA is required";
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'PG PASSING YEAR',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          // color: MyColorName.colorBg2,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: colors.black12, width: 2)),
                                      child: DropdownButton<int>(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 10),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                        menuMaxHeight: 600,
                                        hint: const Text(
                                          "PG passing year",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        value: selectedPgPassingYear,
                                        icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          // color: MyColorName.primaryDark,
                                        ),
                                        items: getYears(2000).map((value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(value.toString()),
                                          );
                                        }).toList(),
                                        isExpanded: true,
                                        underline: SizedBox(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedPgPassingYear = value;
                                          });
                                        },
                                      ),
                                    ),
                                    /*TextFormField(
                style: const TextStyle(color: colors.black54),
                controller: pgPassingYearC,
                cursorColor: Colors.black54,
                keyboardType: TextInputType.emailAddress,
                decoration:
                CustomInputDecoration.myCustomInputDecoration(
                    hintText: 'PG PASSING YEAR'),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "PG Passing Year required";
                  }
                },
              )*/
                                  ],
                                )
                              : SizedBox(),
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
                              onPress: () {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, save the input.
                                  _formKey.currentState!.save();
                                  // Now, you can use the validated input, which is stored in _inputText.
                                  // print('Input Text: $_inputText');
                                  _postGraduationDataList.forEach((element) {
                                    if (element.name == pgCourseC.text) {
                                      pgCourseId = element.id.toString();
                                    }
                                  });

                                  _graduationDataList.forEach((element) {
                                    if (element.name == ugCourseC?.text) {
                                      ugCourseId = element.id.toString();
                                    }
                                  });

                                  if (selectedUgCourrse == null) {
                                    Fluttertoast.showToast(
                                        msg: 'please select ug course');
                                  } else {
                                    if (widget.isFromDrawerMenu ?? false) {
                                      updateProfileMethod();
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UploadProfileDocScreen(
                                                  collegeState:
                                                      widget.collegeState,
                                                  collegeName:
                                                      widget.collegeName,
                                                  collegePlace:
                                                      widget.collegePlace,
                                                  collegeDistrict:
                                                      widget.collegeDistrict,
                                                  ugStatus: selectedUgStatus,
                                                  ugCourse: selectedUgCourrse?.id.toString(),
                                                  ugCgpa: ugCgpaC.text,
                                                  ugSpecialization:
                                                      ugSpIdList.join(','),
                                                  pgStatus: selectedPgStatus,
                                                  pgCourse: selectedPGCourrse?.id.toString(),
                                                  pgCgpa: pgCgpaC.text,
                                                  pgSpecialization: pgSpIdList.join(','),
                                                  tenthPercentage:
                                                      tenthPercentageC.text,
                                                  twelfthPercentage:
                                                      twelfthPercentageC.text,
                                                  mark_format10:
                                                      select10th.toLowerCase(),
                                                  mark_format12:
                                                      select12th.toLowerCase(),
                                                  mark_format_PG:
                                                      selectpg,
                                                  mark_format_UG:
                                                      selectug,
                                                  pgPassingYear: selectedPgPassingYear == null ? '': selectedPgPassingYear.toString(),
                                                  ugPassingYear: selectedUgPassingYear.toString(),
                                                )),
                                      );
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ])))));
  }

  List<String> tenth = ["Percent", "CGPA"];
  List<String> ugpg = ["Aggregate", "CGPA"];
  String select10th = 'Percent';
  String select12th = 'Percent';
  String selectug = 'Aggregate';
  String selectpg = 'Aggregate';

  Row addRadioButton(int btnValue, String title, List<String> list,
      {bool? isfrom10, bool? isfrom12, bool? isfromug, bool? isfrompg}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor:
              MaterialStateColor.resolveWith((states) => colors.primary),
          value: list[btnValue],
          groupValue: isfrom10 ?? false
              ? select10th
              : isfrom12 ?? false
                  ? select12th
                  : isfromug ?? false
                      ? selectug
                      : selectpg,
          onChanged: (value) {
            setState(() {
              print(value);
              if (isfrom10 ?? false) {
                select10th = value ?? '';
              } else if (isfrom12 ?? false) {
                print(isfrom12);
                select12th = value ?? '';
              } else if (isfromug ?? false) {
                selectug = value ?? '';
              } else {
                selectpg = value ?? '';
              }
            });
          },
        ),
        Text(title)
      ],
    );
  }

  Future<void> updateProfileMethod() async {
    var parms = {
      'tenth_percent': tenthPercentageC.text,
      'mark_format10': select10th.toLowerCase() ?? '',
      'twelth_percent': twelfthPercentageC.text,
      'mark_format12': select12th.toLowerCase() ?? '',
      'ug_status': selectedUgStatus ?? '',
      'ug_course': selectedUgCourrse?.id.toString(),
      'pg_status': selectedPgStatus ?? '',
      'ug_specialisations': ugSpIdList.join(',') ?? '',
      'ug_year_of_passing':
          selectedUgPassingYear == null ? '' : selectedUgPassingYear.toString(),
      'ug_aggregate': ugCgpaC.text,
      'mark_format_UG': selectug ?? '',
      'pg_course': selectedPGCourrse?.id.toString() ?? '',
      'pg_specialisations': pgSpIdList.join(',') ?? '',
      'pg_year_of_passing': selectedPgPassingYear == null
          ? ''
          : selectedPgPassingYear.toString() ?? '',
      'pg_aggregate': pgCgpaC.text,
      'mark_format_PG': selectpg ?? '',
    };
    print('${parms}');
    var response = await updateProfile(parms);

    if ((response?.status ?? false)) {
      Navigator.pop(context, true);
    }
  }

  GraduationData? selectedUgCourrse;

  GraduationData? selectedPGCourrse;

  getProfileData() async {
    // log('${authToken}');
    profileData = await getProfile();

    print('${profileData?.markFormat10}     sdhsakhk');

    //  profileData = await getProfile();

    ///10th and 12th
    /// ---------------------------------------------------------------------------
    if(profileData?.markFormat10 == 'cgpa'){
      tenthPercentageC.text = (double.parse(profileData?.tenthPercent ?? '0.0')/9.5).toStringAsFixed(1);
    }else {
      tenthPercentageC.text = profileData?.tenthPercent ?? '';
    }

    select10th = profileData?.markFormat10 == 'cgpa'
        ? profileData?.markFormat10?.toString().toUpperCase() ?? 'CGPA'
        : profileData?.markFormat10.toString().capitalize() ?? 'Percent';
    select12th = profileData?.markFormat12 == 'cgpa'
        ? profileData?.markFormat12?.toString().toUpperCase() ?? 'CGPA'
        : profileData?.markFormat12.toString().capitalize() ?? 'Percent';
    selectug = profileData?.markFormatUG == 'cgpa'
        ? profileData?.markFormatUG?.toString().toUpperCase() ?? 'CGPA'
        : profileData?.markFormatUG.toString() ?? 'Aggregate';
    selectpg = profileData?.markFormatPG == 'cgpa'
        ? profileData?.markFormatPG?.toString().toUpperCase() ?? 'CGPA'
        : profileData?.markFormatPG.toString() ?? 'Aggregate';

    if(profileData?.twelthPercent == 'cgpa'){
      twelfthPercentageC.text = (double.parse(profileData?.twelthPercent ?? '0.0')/9.5).toStringAsFixed(1);
    }else {
      twelfthPercentageC.text = profileData?.twelthPercent ?? '';
    }

    ///forUG
    /// ---------------------------------------------------------------------------
    setState(() {
      selectedUgStatus =
          profileData?.ugStatus == null || profileData?.ugStatus == ''
              ? selectedUgStatus
              : profileData?.ugStatus;
      selectedPgStatus =
          profileData?.pgStatus == null || profileData?.pgStatus == ''
              ? selectedPgStatus
              : profileData?.pgStatus;
    });

    ///UGPG year of passing
    selectedUgPassingYear = profileData?.ugYearOfPassing == '' ||
            profileData?.ugYearOfPassing == 'null' ||
            profileData?.ugYearOfPassing == null
        ? selectedUgPassingYear
        : int.parse(profileData!.ugYearOfPassing!);

    selectedPgPassingYear = profileData?.pgYearOfPassing == '' ||
            profileData?.pgYearOfPassing == 'null'
        ? selectedPgPassingYear
        : int.parse(profileData!.pgYearOfPassing!);

    ///UGPG Aggregate
    ugCgpaC.text = profileData?.ugAggregate ?? '';
    pgCgpaC.text = profileData?.pgAggregate ?? '';

    ///UGPG Specification
    List<String> list1 = [];
    List<String> list2 = [];
    for (var element in _specializationDataList) {
      if (profileData!.ugSpecialisations.toString().contains(element.id.toString())) {
        list1.add(element.name.toString());
      }
      if(profileData!.pgSpecialisations.toString().contains(element.id.toString())) {
        list2.add(element.name.toString());
      }

    }

    ugSpecializationC.text = list1.join(',') ?? '';
    pgSpecializationC.text = list2.join(',') ?? '';



    ///forPG
    /// ---------------------------------------------------------------------------
    selectpg = profileData?.markFormatPG ?? 'Aggregate';


    //pgStatusC.text = profileData?.pgStatus ?? '';
    //pgCourseC.text = profileData?.pgCourse ?? '';


    selectedUgCourrse = _graduationDataList.firstWhere((element) {
      if (element.id.toString() == profileData?.ugCourse) {
        return true;
      }
      return false;
    });
    selectedPGCourrse = _postGraduationDataList.firstWhere((element) {
      if (element.id.toString() == profileData?.pgCourse) {
        return true;
      }
      return false;
    });

    setState(() {});
  }

  List<GraduationData> _graduationDataList = [];
  List<SpecializationData> _specializationDataList = [];

  List<String> pgCoursesName = [];
  List<String> ugCoursesName = [];
  List<GraduationData> _postGraduationDataList = [];

  Future<ProfileData?> getGraduationData() async {
    await apiBaseHelper
        .getAPICall(Uri.parse('${baseUrl}get_courses_by?type=3'))
        .then((getData) async {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        _graduationDataList =
            GraduationTypeResponse.fromJson(getData).data ?? [];
        for (int i = 0; i < _graduationDataList.length; i++) {
          ugCoursesName.add(_graduationDataList[i].name ?? '');
          if (_graduationDataList[i].id.toString() ==
              profileData?.ugCourse.toString()) {
            print(_graduationDataList[i].name);
            //selectedUgCourrse = _graduationDataList[i].name.toString() ;

            setState(() {});
          }
        }
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
    return profileData;
  }

  Future<ProfileData?> getPostGraduationData() async {
    await apiBaseHelper
        .getAPICall(Uri.parse('${baseUrl}get_courses_by?type=5'))
        .then((getData) async {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        _postGraduationDataList =
            GraduationTypeResponse.fromJson(getData).data ?? [];
        for (int i = 0; i < _postGraduationDataList.length; i++) {
          print(_postGraduationDataList[i].name);
          pgCoursesName.add(_postGraduationDataList[i].name ?? '');
        }
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
    return profileData;
  }

  Future<void> getSpecialization() async {
    await apiBaseHelper
        .getAPICall(Uri.parse('${baseUrl}specailization'))
        .then((getData) async {
      bool error = getData['status'];
      //String msg = getData['message'];

      if (error) {
        _specializationDataList =
            GetSpecializationRsponse.fromJson(getData).data ?? [];

        if (widget.isFromDrawerMenu ?? true) {
          getProfileData();
        }
      } else {
        //Fluttertoast.showToast(msg: msg);
      }
    });
  }
}

class SpecializationMultiSelect extends StatefulWidget {
  final List<SpecializationData> items;

  const SpecializationMultiSelect({Key? key, required this.items})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SpecializationMultiSelectState();
}

class _SpecializationMultiSelectState extends State<SpecializationMultiSelect> {
  // this variable holds the selected items
  final List<SpecializationData> _selectedItems = [];
  int itemcount = 0;

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(SpecializationData itemValue, bool isSelected) {
    if (itemcount < 4) {
      setState(() {
        if (isSelected) {
          itemcount++;
          _selectedItems.add(itemValue);
        } else {
          _selectedItems.remove(itemValue);
        }
      });
    } else {
      itemcount--;
      Fluttertoast.showToast(msg: 'only 4 specification you can select');
    }
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  List<SpecializationData> filteredItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItems = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextFormField(
        style: const TextStyle(color: colors.black54),
        //controller: TextEditingController(),
        cursorColor: Colors.black54,
        keyboardType: TextInputType.text,
        decoration: CustomInputDecoration.myCustomInputDecoration(
            hintText: "search specialization"),
        onChanged: (value) {
          filteredItems = widget.items
              .where((product) => (product.name ?? '')
                  .toLowerCase()
                  .contains(value.toLowerCase()))
              .toList();
          setState(() {});
        },
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: filteredItems
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item.name ?? ''),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
