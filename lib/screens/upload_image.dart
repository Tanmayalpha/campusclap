import 'package:campusclap/screens/registrationSuccess.dart';
import 'package:campusclap/utils/btn.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';


class Upload_image extends StatefulWidget {
  const Upload_image({super.key});

  @override
  State<Upload_image> createState() => _Upload_imageState();
}

class _Upload_imageState extends State<Upload_image> {
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _inputText = '';
  int selectedIndex = 99;
  TextEditingController mobileController = TextEditingController();
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
                    child: ListView(physics: const BouncingScrollPhysics(),
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                            const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: address1Controller,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'Upload',
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
                                return "";
                              }
                            },
                          ),
                           const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Selfie Image(Image)',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                            const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: address1Controller,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'Upload',
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
                                return "";
                              }
                            },
                          ),
                           const SizedBox(
                            height: 20,
                          ),
                            const Text(
                            'Updated Resume(PDF/Word)',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                            const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            style: const TextStyle(color: colors.black54),
                            controller: address1Controller,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 18),
                              fillColor: Colors.white,
                              hintText: 'Upload',
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
                  child: FilledBtn( 
                    title: 'Submit',
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, save the input.
                        _formKey.currentState!.save();
                        // Now, you can use the validated input, which is stored in _inputText.
                        // print('Input Text: $_inputText');
                      }
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const RegistrationSuccessWidget ()),
                       );
                       
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
}



