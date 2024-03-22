import 'dart:io';

import 'package:campusclap/Models/get_profile_response.dart';
import 'package:campusclap/screens/registrationSuccess.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/extentions.dart';
import 'package:campusclap/utils/globle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadProfileDocScreen extends StatefulWidget {
  const UploadProfileDocScreen(
      {super.key,
      this.collegeName,
      this.collegeState,
      this.collegeDistrict,
      this.collegePlace,
      this.isFromDrawerMenu,
        this.tenthPercentage,
        this.twelfthPercentage,
        this.ugStatus,
        this.ugSpecialization,
        this.ugCourse,
        this.ugCgpa,
        this.pgStatus,
        this.pgCourse,
        this.pgSpecialization,
        this.mark_format12,
        this.mark_format10,
        this.mark_format_UG,
        this.mark_format_PG,this.ugPassingYear,this.pgPassingYear,
        this.pgCgpa});

  final String? collegeName,
      collegeState,
      collegeDistrict,
      collegePlace,
      tenthPercentage,
      mark_format12,
      mark_format10,
      mark_format_UG,
      mark_format_PG,
      twelfthPercentage,
      ugStatus,
      ugSpecialization,
      ugCourse,
      ugCgpa,
      pgStatus,
      pgCourse,
      pgSpecialization,
      pgCgpa, ugPassingYear, pgPassingYear;
  final bool? isFromDrawerMenu;

  @override
  State<UploadProfileDocScreen> createState() => _UploadProfileDocScreenState();
}

class _UploadProfileDocScreenState extends State<UploadProfileDocScreen> {
  TextEditingController aadhaarC = TextEditingController();
  TextEditingController resumeC = TextEditingController();
  TextEditingController selfieC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  TextEditingController mobileController = TextEditingController();

  File? aadhaarFile ;
  File? selfieFile ;
  File? resumeFile ;

  ProfileData? profileData ;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isFromDrawerMenu ?? false) {
      getProfileData ();
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
                  "Uploads",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colors.primary),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Uploads",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Aadhaar Card(Image/PDF)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: aadhaarC,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  onTap: () async{
                    await pickFileFromStorage('aadhaar');
                  },
                  decoration: CustomInputDecoration.myCustomInputDecoration(hintText: 'Upload'),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Selfie Image(Image)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: selfieC,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  onTap: () async{
                    await pickFileFromStorage('selfie');
                  },
                  decoration: CustomInputDecoration.myCustomInputDecoration(hintText: 'Upload'),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Updated Resume(PDF/Word)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: const TextStyle(color: colors.black54),
                  controller: resumeC,
                  cursorColor: Colors.black54,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                  onTap: () async{
                   await pickFileFromStorage('resume');
                  },
                  decoration: CustomInputDecoration.myCustomInputDecoration(hintText: 'Upload'),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "";
                    }
                  },
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.13),
                  child: isButtonLoading ?  const Center(child: CircularProgressIndicator(color: colors.primary,),) : ComenBtn(
                    title: 'Submit',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, save the input.
                        _formKey.currentState!.save();
                        // Now, you can use the validated input, which is stored in _inputText.
                        // print('Input Text: $_inputText');
                          updateProfileMethod();


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
bool isButtonLoading = false ;


 Future<void> pickFileFromStorage(String type) async{
   FilePickerResult? result;
   if (type != 'aadhaar' && type !='resume')
     {
       result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions:  ['jpg']);


     }else {
     result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions:  ['jpg', 'pdf', 'doc']);
   }


    if (result != null) {

      if(type == 'aadhaar') {
        aadhaarFile = File(result.files.single.path!);
        aadhaarC.text = aadhaarFile?.path ?? '';
      }else if(type=='resume'){
        resumeFile = File(result.files.single.path!);
        resumeC.text = resumeFile?.path ?? '';
      }else{
        selfieFile = File(result.files.single.path!) ;
        selfieC.text = selfieFile?.path ?? '';
      }
    } else {
      // User canceled the picker
    }
    setState(() {

    });
  }

  Future<void> updateProfileMethod() async {

   setState(() {
     isButtonLoading  = true ;
   });

    var parms = {};
    if (widget.isFromDrawerMenu ?? false){

    }else {
      parms = {
        'tenth_percent':widget.tenthPercentage ?? '0.0',
        'mark_format10':widget.mark_format10 ?? '',
        'mark_format12':widget.mark_format12 ?? '',
        'mark_format_UG':widget.mark_format_UG ?? '',
        'mark_format_PG':widget.mark_format_PG ?? '',
        'twelth_percent':widget.twelfthPercentage ?? '0.0',
        'ug_status':widget.ugStatus ?? '',
        'pg_status':widget.pgStatus ?? '',
        'ug_course':widget.ugCourse ?? '',
        'ug_specialisations':widget.ugSpecialization ?? '',
        'ug_year_of_passing':widget.ugPassingYear ?? '',
        'ug_aggregate':widget.ugCgpa ?? '',
        'pg_course':widget.pgCourse ?? '',
        'pg_specialisations':widget.pgSpecialization ?? '',
        'pg_year_of_passing':widget.pgPassingYear ?? '',
        'pg_aggregate':widget.pgCgpa ?? '',

        'college_name': widget.collegeName,
        'college_state': widget.collegeState,
          'college_dictrict': widget.collegeDistrict,
        'college_place': widget.collegePlace
      };
    }

print('${parms}');

    var response = await updateProfile(parms,resume: resumeFile, selfie: selfieFile,aadhaar: aadhaarFile);

    if ((response?.status ?? false)) {
      if (widget.isFromDrawerMenu ?? false){
        setState(() {
          isButtonLoading  = false ;
        });
        Fluttertoast.showToast(msg: 'Files updated successfully!');
        Navigator.pop(context, true);
      }else {
        setState(() {
          isButtonLoading  = false ;
        });
        Fluttertoast.showToast(msg: 'Profile Completed!');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
              const RegistrationSuccessScreen())
        );
      }


    }


  }

  getProfileData () async{
    profileData = await getProfile();
    resumeC.text = profileData?.resume ?? '';
    aadhaarC.text = profileData?.aadharImage.toString() ?? '';
    selfieC.text = profileData?.selfieImage ?? '';

    setState(() {

    });
  }
}
