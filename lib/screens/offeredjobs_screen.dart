import 'package:campusclap/utils/color.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class OfferJobWidget extends StatefulWidget {
  const OfferJobWidget({super.key});

  @override
  State<OfferJobWidget> createState() => _OfferJobWidgetState();
}

class _OfferJobWidgetState extends State<OfferJobWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.bgColor,
      // appBar: PreferredSize(
      //     preferredSize: Size.fromHeight(80),
      //     child: commonAppBar(context, text: "Jobs")),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(physics: BouncingScrollPhysics(), children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {},
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 1)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return applyJobContainer(index: index);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
            ),
            SizedBox(
              height: 20,
            )
          ])),
    );
  }

  Widget applyJobContainer({required int index}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/Logo Icon.png"))),
                          )),
                      Expanded(
                          flex: 4,
                          child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Aglowid IT Solutions PVT. LTD.",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Mumbai",
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ))),
                    ]),
              )),
          SizedBox(
            height: 5,
          ),
          Expanded(
              flex: 1,
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ui/Ux designer",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    index == 0
                        ? "Interview In Progress"
                        : index == 1 || index == 3
                            ? 'Job Offered'
                            : 'Rejected',
                    style: TextStyle(
                      fontSize: 14,
                      color: index == 0
                          ? Colors.amber
                          : index == 1 || index == 3
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
                ],
              ))),
          // SizedBox(
          //   height: 5,
          // ),
          Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    applyJobHelper(value: 'Full Time'),
                    SizedBox(
                      width: 10,
                    ),
                    applyJobHelper(value: 'Onsite'),
                    SizedBox(
                      width: 10,
                    ),
                    applyJobHelper(value: '0-2 year'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "15 days left",
                      style: TextStyle(color: colors.primary, fontSize: 10),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget applyJobHelper({required String value}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.grey),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        value,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}