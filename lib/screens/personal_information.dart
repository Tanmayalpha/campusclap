import 'package:campusclap/Models/get_languages_response.dart';
import 'package:campusclap/Models/verify_otp_response.dart';
import 'package:campusclap/Services/api_services/apiConstants.dart';
import 'package:campusclap/Services/api_services/apiStrings.dart';
import 'package:campusclap/local_repository/preferences.dart';
import 'package:campusclap/local_repository/user_data_model.dart';
import 'package:campusclap/screens/bottom_navBar.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'Auth/subscription_plan.dart';
import 'College_details.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

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
  TextEditingController languageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  TextEditingController mobileController = TextEditingController();

  List <Languages> languages = [];
  List<String> langIdList  = [];


  List gender=["Male","Female","Other"];

  String? selectGender;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    }else{

                      return null;

                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Fathers Full Name',
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
                  'Mothers Full Name',
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
                  keyboardType: TextInputType.number,
                  decoration: CustomInputDecoration.myCustomInputDecoration(
                      hintText: "Mobile Number"),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return 'Enter mobile number';
                    }else if (v.length < 10) {
                      return 'Enter valid mobile number';
                    }else {
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
                  onTap: (){
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
                  onTap: (){
                    showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                      return AlertDialog(

                        content: StatefulBuilder(
                          builder: (BuildContext context, StateSetter setGenderState) {
                            return Row(
                              children: List<Widget>.generate(gender.length, (int index) {
                               return addRadioButton(index, gender[index], setGenderState);
                              } )


                            );




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
                    if (v!.isEmpty) {
                      return " Aadhaar Number is required";
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
                  onTap: () async{
                    final List<Languages>? results = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MultiSelect(items: languages);
                      },
                    );
                    if(results != null) {
                      List<String> tempList  = [];
                      langIdList.clear() ;



                      for (var element in results) {
                        tempList.add(element.name ?? '');
                        langIdList.add(element.id.toString() ?? '');
                      }

                      languageController.text =  tempList.join(',');
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
                const SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.13),
                  child: FilledBtn(
                    title: 'Next',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, save the input.
                       // _formKey.currentState!.save();
                        // Now, you can use the validated input, which is stored in _inputText.
                        // print('Input Text: $_inputText');
                        registerUser();
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SubPlanWidget()),
                        );*/
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
      'mobile': mobileController.text
    };

    apiBaseHelper.postAPICall(userRegisterAPI, param).then((getData) async {
      bool error = getData['status'];


      if (error) {
        String msg = getData['message'];
        Fluttertoast.showToast(msg: msg);
        var finalResponse = VerifyOtpData.fromJson(getData['data']);
        var userdata = UserData.fromJson(getData['data']['user']);
        token = finalResponse.token ?? '' ;
        LocalRepository.setPrefrence(LocalRepository.token, token);
        LocalRepository.setPrefrence(LocalRepository.userData, userdata.toJson().toString());
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const SubscriptionPlanScreen()));
      } else {
        if(getData['message']['email'] !=null){
          Fluttertoast.showToast(msg: getData['message']['email'][0]);

        }
        if(getData['message']['mobile'] !=null){
          Fluttertoast.showToast(msg: getData['message']['mobile'][0]);
        }

      }
    });
  }

  Row addRadioButton(int btnValue, String title, StateSetter setGenderState ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 35,
          child: Radio(
            activeColor: Theme.of(context).primaryColor,
            value: gender[btnValue],
            groupValue: selectGender,
            onChanged: (value){
              setGenderState(() {
                selectGender = value;
                genderController.text = selectGender ?? '' ;
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
        lastDate:  DateTime.now());
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
        languages = finalResponse.languages ?? [] ;

      } else {
        Fluttertoast.showToast(msg: msg);
      }

    });
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


