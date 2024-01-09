import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/color.dart';
import 'package:campusclap/utils/globle.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/notify.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Widget showDate(String? date, Color clr) {
    var dt = DateFormat.yMMMd().format(DateTime.parse(date!));
    return Text(
      dt,
      style: TextStyle(fontSize: 14, color: clr),
    );
  }

  Future<List<Noti>> getNotification() async {
    String url = "${APIData.notifications}${APIData.secretKey}";
    Response res = await get(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $authToken",
      },
    );
    List<Noti> ans = [];
    if (res.statusCode != 200) return ans;
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body)["notifications"];

      for (int i = 0; i < body.length; i++) {
        ans.add(Noti.fromJson(body[i]));
      }
    }
    return ans;
  }

  var noties;

  void initState() {
    noties = getNotification();
    super.initState();
  }

  Future<bool> clearnotify() async {
    String url = APIData.readAllNotification + "${APIData.secretKey}";
    Response res = await post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $authToken",
      },
    );
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool noticlear = false;

  Widget appBar(BuildContext context,
      {required String text, bool? isActionButton}) {
    return Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        //padding: EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [colors.primary, colors.secondary]),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                // margin: EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.arrow_back,
                  color: colors.secondary,
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            isActionButton == false
                ? Container(
                    width: 40,
                  )
                : Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: noticlear
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xffF44A4A)),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                icon: const Icon(Icons.delete_outline_outlined),
                                color: colors.textColor,
                                onPressed: () async {
                                  setState(() {
                                    noticlear = true;
                                  });
                                  bool x = await clearnotify();

                                  if (x) {
                                    Navigator.of(context).pop();
                                  }
                                  setState(() {
                                    noticlear = false;
                                  });
                                }),
                          ),
                  ),
          ],
        ));
  }

  Widget notificationTile(Data? data, Color txtColor, String? date) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context)
              .pushNamed('/notificationDetail', arguments: data);
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: data!.image == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          "assets/placeholder/trusted.png",
                          height: 90,
                          width: 90,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: "${APIData.courseImages}${data.image}",
                        imageBuilder: (context, imageProvider) => Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        placeholder: (context, url) => ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                "assets/placeholder/trusted.png",
                                height: 90,
                                width: 90,
                              ),
                            ),
                        errorWidget: (context, url, error) => ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                "assets/placeholder/trusted.png",
                                height: 90,
                                width: 90,
                              ),
                            )),
              ),
              SizedBox(
                width: 10.0,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      data.id,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: txtColor,
                          fontSize: 17),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      data.data.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: txtColor, fontSize: 15),
                    ),
                    showDate(date, txtColor)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget whenEmpty() {
    return Center(
      child: Container(
        height: 280,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(),
                child: Container(
                  child: Icon(
                    Icons.notifications,
                    size: 180,
                    color: colors.textColor.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "No_Notifications",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3F4654)),
                  ),
                  Container(
                    width: 250,
                    child: Text(
                      "You_are_all_caught_up_Check_back_later_for_new_notifications",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF3F4654).withOpacity(0.8)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationList(List<Noti>? data, Color? tileColor, Color? txtColor) {
    return Container(
      margin: EdgeInsets.all(12.0),
      height: MediaQuery.of(context).size.height - 60,
      child: ListView.builder(
        itemCount: data!.length,
        itemBuilder: (context, idx) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
                color: tileColor, borderRadius: BorderRadius.circular(15.0)),
            child: notificationTile(
                data[idx].data, txtColor!, data[idx].createdAt),
          );
        },
      ),
    );
  }

  Widget scaffoldBody() {
    return FutureBuilder<List<Noti>>(
      future: noties,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0)
            return notificationList(snapshot.data as List<Noti>,
                colors.whiteTemp, colors.textColor);
          else
            return Center(child: whenEmpty());
        } else
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffF44A4A)),
            ),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight( 80),
            child: appBar(context, text: 'Notifications_')),
        backgroundColor: colors.whiteTemp,
        body: scaffoldBody(),
      ),
    );
  }
}
