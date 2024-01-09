import 'dart:convert';

import 'package:campusclap/Models/get_city_response.dart';
import 'package:campusclap/Models/get_languages_response.dart';
import 'package:campusclap/Models/get_profile_response.dart';
import 'package:campusclap/Models/verify_otp_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/local_repository/user_data_model.dart';
import 'package:campusclap/screens/bottom_navBar.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/extentions.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import 'Auth/subscription_plan.dart';
import 'College_details.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key, this.isPromDrawerMenu, this.mobile});

  final bool? isPromDrawerMenu;
  final String? mobile;

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  TextEditingController studentNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController alternateMobileNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController aadhaarController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController stateC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  TextEditingController mobileController = TextEditingController();

  List<Languages> languages = [];
  List<String> langIdList = [];

  List gender = ["Male", "Female", "Other"];

  String? selectGender;

  ProfileData? profileData;
  var items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.mobile != null) {
      mobileController.text = widget.mobile ?? '';
    }
    getState();
    getLanguages();
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
                  colors: [colors.primary, colors.secondary, colors.secondary]),
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
                  "Personal Information",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colors.primary),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Fill up the following details to Personal Information and enjoy our services ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Student Full Name',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: studentNameController,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: 'Enter Your Full Name'),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Name is required";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Father's Full Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: fatherNameController,
                  autovalidateMode: AutovalidateMode.always,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.text,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: "Father's Full Name"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Fathers Name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Mother's Full Name",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: motherNameController,
                  cursorColor: Colors.black54,
                  autovalidateMode: AutovalidateMode.always,
                  keyboardType: TextInputType.text,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: "Mother's Full Name"),
                  validator: (v) {
                    if (v?.isEmpty ?? true) {
                      return " Mothers Name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Mobile Number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: mobileController,
                  cursorColor: Colors.black54,
                  maxLength: 10,
                  readOnly: widget.mobile != null,
                  keyboardType: TextInputType.number,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: "Mobile Number"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter mobile number';
                    } else if (v.length < 10) {
                      return 'Enter valid mobile number';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Alternate Mobile Number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: alternateMobileNameController,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.number,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: "Alternate Mobile Number"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " Alternate Mobile Number is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Email Id',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: emailController,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: "Email Id"),
                  validator: (v) {
                    if (v?.isEmpty ?? true) {
                      return 'Email is required';
                    } else if (!RegExp(
                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)"
                            r"*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+"
                            r"[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                        .hasMatch(v!)) {
                      return 'Enter valid email!';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Date Of Birth',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: dobController,
                  cursorColor: Colors.black54,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: "Date of Birth"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " Date Of Birth is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Gender',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: genderController,
                  cursorColor: Colors.black54,
                  readOnly: true,
                  keyboardType: TextInputType.emailAddress,
                  onTap: () {
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: StatefulBuilder(
                              builder: (BuildContext context,
                                  StateSetter setGenderState) {
                                return Row(
                                    children: List<Widget>.generate(
                                        gender.length, (int index) {
                                  return addRadioButton(
                                      index, gender[index], setGenderState);
                                }));

                                /*Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List<Widget>.generate(2, (int index) {
                                return Radio<int>(
                                  value: index,
                                  groupValue: selectedRadio,
                                  onChanged: (int? value) {
                                    setState(() => selectedRadio = value);

                                    print('${selectedRadio}____________');
                                  },
                                );
                              }),
                            );*/
                              },
                            ),
                          );
                        });
                  },
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: "Gender"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " Gender is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Permanent Residential Address',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: addressController,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.text,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: 'Permanent Residential Address'),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " Permanent Residential Address is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'State',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                /*TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: stateC,
                  readOnly: true,
                  onTap: (){
                    void _showMultiSelect(BuildContext context) async {
                      await showModalBottomSheet(
                        isScrollControlled: true, // required for min/max child size
                        context: context,
                        builder: (ctx) {
                          return  MultiSelectBottomSheet(
                            items: items,
                            initialValue: [stateList[4], stateList[7], stateList[9]],
                            onConfirm: (values) {},
                            maxChildSize: 0.8,
                          );
                        },
                      );
                    }
                  },
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.number,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: 'Pin Code'),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " State is required";
                    }
                    return null;
                  },
                ),*/
                Container(
                  decoration: BoxDecoration(
                      // color: MyColorName.colorBg2,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: colors.black12, width: 2)),
                  child: DropdownButton<StateData>(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    menuMaxHeight: 600,
                    hint: const Text(
                      "Select State",
                      style: TextStyle(color: Colors.black54),
                    ),
                    value: selectedStated,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      // color: MyColorName.primaryDark,
                    ),
                    items: stateList.map((StateData value) {
                      return DropdownMenuItem<StateData>(
                        value: value,
                        child: Text(value.statenName ?? ''),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox(),
                    onChanged: (StateData? value) {
                      setState(() {
                        selectedStated = value;
                       // selectedCity = null;
                       // cityList.clear();
                      });
                      //getCity(selectedStated?.id.toString() ?? '');
                    },
                  ),
                ),
                /*const SizedBox(
                  height: 20,
                ),
                const Text(
                  'City',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      // color: MyColorName.colorBg2,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: colors.black12, width: 2)),
                  child: DropdownButton<StateData>(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    menuMaxHeight: 600,
                    hint: const Text(
                      "Select City",
                      style: TextStyle(color: Colors.black54),
                    ),
                    value: selectedCity,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      // color: MyColorName.primaryDark,
                    ),
                    items: cityList.map((StateData value) {
                      return DropdownMenuItem<StateData>(
                        value: value,
                        child: Text(value.cityName ?? ''),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: const SizedBox(),
                    onChanged: (StateData? value) {
                      setState(() {
                        selectedCity = value;
                      });
                    },
                  ),
                ),*/
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Pin Code',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: pinCodeController,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.number,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: 'Pin Code'),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " Pin Code is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Aadhaar Number',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: aadhaarController,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.number,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: 'Aadhaar Number'),
                  validator: (v) {
                    if (v!.length != 12) {
                      return " Not valid Aadhaar Number";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Languages Known(Can Select Multiple)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: languageController,
                  readOnly: true,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  onTap: () async {
                    final List<Languages>? results = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MultiSelect(items: languages);
                      },
                    );
                    if (results != null) {
                      List<String> tempList = [];
                      langIdList.clear();

                      for (var element in results) {
                        tempList.add(element.name ?? '');
                        langIdList.add(element.id.toString() ?? '');
                      }

                      languageController.text = tempList.join(',');
                    }
                  },
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: 'Languages Known(Can Select Multiple)'),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return " Languages field is required";
                    }
                    return null;
                  },
                ),
                widget.isPromDrawerMenu ?? false ?  const SizedBox() : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Referral Code',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      style: const TextStyle(color: colors.black54),
                      controller: referralController,
                      cursorColor: Colors.black54,
                      keyboardType: TextInputType.text,
                      decoration: CustomInputDecoration.myCustomInputDecoration(
                          hintText: 'Do you have any Referral Code ?'),
                      /*validator: (v) {
                    if (v!.isEmpty) {
                      return " Aadhaar Number is required";
                    }
                    return null;
                  },*/
                    )
                  ],),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.13),
                  child: ComenBtn(
                    title: widget.isPromDrawerMenu ?? false ? 'Submit' : 'Next',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, save the input.
                        // _formKey.currentState!.save();
                        // Now, you can use the validated input, which is stored in _inputText.
                        // print('Input Text: $_inputText');
                        if (widget.isPromDrawerMenu ?? false) {
                          if (selectedStated == null) {
                            Fluttertoast.showToast(msg: 'please select state');
                          } else {
                            updateProfileMethod();
                          }
                        } else {
                          if (selectedStated == null) {
                            Fluttertoast.showToast(msg: 'please select state');
                          } else {
                            registerUser();
                          }
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ]),
        ),
      ),
    ));
  }

  Future<void> registerUser() async {
    var param = {
      'full_name': studentNameController.text,
      'fathers_name': fatherNameController.text,
      'mothers_name': mobileController.text,
      'dob': dobController.text,
      'gender': genderController.text,
      'permanent_address': addressController.text,
      'pincode': pinCodeController.text,
      'email': emailController.text,
      'aadhar_no': aadhaarController.text,
      'languages': langIdList.join(','),
      'mobile': mobileController.text,
      'state_id': selectedStated?.id.toString() ?? '17',
      //'city_id': selectedCity?.id.toString() ?? ''
    };

    apiBaseHelper.postAPICall(userRegisterAPI, param).then((getData) async {
      bool error = getData['status'];

      if (error) {
        String msg = getData['message'];
        Fluttertoast.showToast(msg: msg);
        var finalResponse = VerifyOtpData.fromJson(getData['data']);
        var userdata = UserData.fromJson(getData['data']['user']);
        token = finalResponse.token ?? '';
        await storage.write(key: "token", value: "$token");
        authToken = await storage.read(key: "token");
        LocalRepository.setPrefrence(
            LocalRepository.userName, getData['data']['user']['full_name']);
        LocalRepository.setPrefrence(
            LocalRepository.userEmail, getData['data']['user']['email']);;
        LocalRepository.setPrefrence(LocalRepository.token, token);
        LocalRepository.setPrefrence(
            LocalRepository.userData, userdata.toJson().toString());
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const SubscriptionPlanScreen()));
      } else {
        if (getData['message']['email'] != null) {
          Fluttertoast.showToast(msg: getData['message']['email'][0]);
        }
        if (getData['message']['mobile'] != null) {
          Fluttertoast.showToast(msg: getData['message']['mobile'][0]);
        }
      }
    });
  }

  Row addRadioButton(int btnValue, String title, StateSetter setGenderState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 35,
          child: Radio(
            activeColor: Theme.of(context).primaryColor,
            value: gender[btnValue],
            groupValue: selectGender,
            onChanged: (value) {
              setGenderState(() {
                selectGender = value;
                genderController.text = selectGender ?? '';
              });
            },
          ),
        ),
        Text(title)
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> getLanguages() async {
    apiBaseHelper.getAPICall(getLanguageAPI).then((getData) async {
      bool error = getData['status'];
      String msg = getData['message'];

      if (error) {
        var finalResponse = LanguagesData.fromJson(getData['data']);
        languages = finalResponse.languages ?? [];
        if (widget.isPromDrawerMenu ?? false) {
          getProfileData();
        }
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

  getProfileData() async {
    profileData = await getProfile();

    studentNameController.text = profileData?.fname ?? '';
    fatherNameController.text = profileData?.fatherName ?? '';
    motherNameController.text = profileData?.motherName ?? '';
    mobileController.text = profileData?.mobile ?? '';
    alternateMobileNameController.text = profileData?.alternateMobile ?? '';
    emailController.text = profileData?.email ?? '';
    dobController.text = profileData?.dob.toString() ?? '';
    genderController.text = profileData?.gender.toString() ?? '';
    addressController.text = profileData?.address.toString() ?? '';
    pinCodeController.text = profileData?.pinCode.toString() ?? '';
    aadhaarController.text = profileData?.aadhaarNumber.toString() ?? '';



    List<String> list = [];
    for (var element in languages) {
      if (profileData!.languageId.toString().contains(element.id.toString())) {
        list.add(element.name.toString());
      }
      profileData?.languageId.toString();
    }

    languageController.text = list.join(',') ?? '';

    selectedCity = stateList.firstWhere((element) {
      print(element.id.toString());
      if(element.id.toString() == profileData?.stateId) {
        return true ;
      }
      return false ;
    });
    setState(() {});
  }

  Future<void> updateProfileMethod() async {
    var parms = {
      'full_name': studentNameController.text,
      'fathers_name': fatherNameController.text,
      'mothers_name': motherNameController.text,
      'dob': dobController.text,
      'gender': genderController.text,
      'permanent_address': addressController.text,
      'pincode': pinCodeController.text,
      'email': emailController.text,
      'aadhar_no': aadhaarController.text,
      'languages': langIdList.join(','),
      'mobile': mobileController.text,
      'state_id': selectedStated?.id.toString() ?? '17',
    };
    print('${parms}');

    var response = await updateProfile(parms);

    if ((response?.status ?? false)) {
      Navigator.pop(context, true);
    }
  }

  List<StateData> stateList = [];
  List<StateData> cityList = [];
  StateData? selectedStated;

  StateData? selectedCity;

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
      stateList = GetStatesResponse.fromJson(result).data ?? [];
      items = stateList
          .map((state) => MultiSelectItem<StateData>(state, state.statenName ?? ''))
          .toList();

      setState(() {});
    } else {
      setState(() {});
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

class MultiSelect extends StatefulWidget {
  final List<Languages> items;

  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<Languages> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(Languages itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
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
