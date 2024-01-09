
import 'package:campusclap/utils/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

import '../../Utils/Color.dart';


class ReferAndEranScreen extends StatefulWidget {


 final String? referCode ;
  const ReferAndEranScreen({Key? key, this.referCode}) : super(key: key);

  @override
  State<ReferAndEranScreen> createState() => _ReferAndEranScreenState();
}

class _ReferAndEranScreenState extends State<ReferAndEranScreen> {


    @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: commonAppBar(context, text: "Refer & Earn")),
          //backgroundColor: colors.primary,
          body: Column(
            children: [
              const SizedBox(height: 10,),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/OBJECTS.png"),
                        Padding(
                          padding: const EdgeInsets.only(top: 28.0),
                          child: Text( "Refer and earn",
                            style: Theme.of(context).textTheme.headline5!.copyWith(
                                color: colors.textColor),
                          ),
                        ),
                         const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                           "Invite your friends to join and get the reward",
                            textAlign: TextAlign.center,
                          ),
                        ),
                         const Padding(
                          padding: EdgeInsets.only(top: 28.0),
                          child: Text(
                            "Your Referral Code",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration:  BoxDecoration(
                              border: Border.all(
                                width: 1,
                                style: BorderStyle.solid,
                                color: colors.secondary,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child:   Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "${widget.referCode}",
                                style: TextStyle(color: colors.textColor),
                              ),
                            ),
                          ),
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: const BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                 BorderRadius.all(Radius.circular(4.0))),
                            child: const Text("Tap to copy",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: colors.whiteTemp),
                            ),),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: "hfkjsdhfkds"));
                            // setSnackbar('Refercode Copied to clipboard');
                            Fluttertoast.showToast(msg:  "Refer code Copied to clipboard",
                                backgroundColor: colors.primary
                            );
                          },
                        ),
                        const SizedBox(height: 10),

                        InkWell(
                            onTap: () {
                              share(referCode: "sjdskdhs");
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 1.1,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: colors.primary
                              ),
                              child:  const Text( "Share", style: TextStyle(
                                color: colors.whiteTemp,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,),),
                            )),

                        // SimBtn(
                        //   size: 0.8,
                        //   title: "Share",
                        //   onBtnSelected: () {
                        //     var str =
                        //         "$appName\nRefer Code:$"REFER_CODE"\n${getTranslated(context, 'APPFIND')}$androidLink$packageName\n\n${getTranslated(context, 'IOSLBL')}\n$iosLink$iosPackage";
                        //     Share.share(str);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              )

            ],
          ),



        ));
  }

  GlobalKey keyList = GlobalKey() ;
  bool iconVisible = true;
  Future<void> share({String? referCode})  async {
     Share.share(
         'Refer and Earn!\nUse my referral code: $referCode to join.\nJoin now and enjoy the benefits!',
         subject: 'Referral Code'

    );
  }
}
