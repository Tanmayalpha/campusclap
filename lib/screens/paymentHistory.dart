
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class PaymentHistoryPage extends StatefulWidget {
  const PaymentHistoryPage({super.key});

  @override
  State<PaymentHistoryPage> createState() => _PaymentHistoryPageState();
}

List<String> listDetails = [
  "Johan Deo",
  "Johan Deo",
  "Johan Deo",
  "Johan Deo",
  "Johan Deo",
  "Johan Deo",
  "Johan Deo",
  "Johan Deo",
  "Johan Deo"
];

class _PaymentHistoryPageState extends State<PaymentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: commonAppBar(context,
                text: "Payment History", isActionButton: false)),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView(physics: BouncingScrollPhysics(), children: [
              SizedBox(
                height: 10,
              ),
              Container(
                  child: Text(
                    'Transaction',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return listTileWidget(index: index);
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
      ),
    );
  }

  Widget listTileWidget({required int index}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/paymnet history.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Transaction Id",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Container(
                  child: Text(
                    'Shivansh Shukla',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '04 feb 2022',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "123xxxx",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    'Rs 620',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Paid',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
                SizedBox(
                  height: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}