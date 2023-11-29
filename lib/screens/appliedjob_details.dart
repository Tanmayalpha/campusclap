
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppliedJobDetailsWidget extends StatefulWidget {
  const AppliedJobDetailsWidget({super.key});

  @override
  State<AppliedJobDetailsWidget> createState() =>
      _AppliedJobDetailsWidgetState();
}

List<String> listDetails = [
  "Applied Successfully",
  "Application sent",
  "Application Viewed",
  "Application Approved",
  "Cleared all the interview round"
];

class _AppliedJobDetailsWidgetState extends State<AppliedJobDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: commonAppBar(context, text: "Applied Job Details")),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(physics: BouncingScrollPhysics(), children: [
              const SizedBox(
                height: 20,
              ),
              jobOfferContainer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                    boxShadow: const [BoxShadow(color: Colors.grey)],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Application Status',
                      style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold, color: colors.primary),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listDetails.length,
                      itemBuilder: (context, index) {
                        return stapperWidget(index: index);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ])),
      ),
    );
  }

  Widget stapperWidget({required int index}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffEEEEEE),
                radius: 22,
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
              index == listDetails.length - 1
                  ? Container()
                  : Container(
                height: 25,
                width: 1,
                color: Colors.grey,
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listDetails[index],
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '20 Nov',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          )
        ],
      ),
    );
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 22,
        child: Icon(
          Icons.check,
          color: Colors.green,
        ),
      ),
      title: Text(
        'Applied Successfuly',
        style: TextStyle(fontSize: 12),
      ),
      subtitle: Text(
        '20 Nov',
        style: TextStyle(fontSize: 10),
      ),
    );
  }

  Widget jobOfferContainer() {
    return Container(
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.only(top: 60),
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.grey)],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ui/Ux designer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Aglowid IT Solutions PVT. LTD.',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Mumbai , Maharashtra',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    applyJobHelper(value: 'Full Time'),
                    applyJobHelper(value: 'Onsite'),
                    applyJobHelper(value: '0-2 year'),
                  ],
                ),
              ],
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              //set border radius more than 50% of height and width to make circle
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("assets/images/Logo Icon.png"))),
              ),
            ),
          ),
        ],
      ),
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