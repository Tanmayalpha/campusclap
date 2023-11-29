
import 'package:campusclap/utils/app_bar.dart';
import 'package:campusclap/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
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

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors.bgColor,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: commonAppBar(context, text: "Notification")),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(physics: const BouncingScrollPhysics(), children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  alignment: Alignment.centerRight, child: const Text('Clear All')),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: listDetails.length,
                itemBuilder: (context, index) {
                  return listTileWidget(index: index);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
              const SizedBox(
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/notification image.png'),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listDetails[index],
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: const Text(
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Text(
                  'Just Now',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}