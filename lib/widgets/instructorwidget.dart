import 'package:cached_network_image/cached_network_image.dart';
import 'package:campusclap/Models/instructor_model.dart';
import 'package:campusclap/commen/apidata.dart';
import 'package:campusclap/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstructorWidget extends StatelessWidget {
  final Instructor? details;

  InstructorWidget(this.details);

  Widget showImage() {
    return Container(
      height: 90,
      width: 90,
      margin: EdgeInsets.only(top: 2.0),
      alignment: Alignment.topLeft,
      child: CachedNetworkImage(
        imageUrl: "${APIData.userImage}${details!.user!.userImg}",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => Image.asset(
          "assets/placeholder/avatar.png",
          width: 120,
          height: 120,
        ),
        errorWidget: (context, url, error) => Image.asset(
          "assets/placeholder/avatar.png",
          width: 120,
          height: 120,
        ),
      ),
    );
  }

  Widget showDetails(BuildContext context) {

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                details!.user!.fname! + " " + details!.user!.lname.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0,
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/InstructorScreen', arguments: details);
                    },
                    child: Text(
                      "View_More",
                      style: TextStyle(
                        color: colors.textColor.withOpacity(0.6),
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.user,
              size: 16.0,
              color: Color(0xff404455),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(details!.enrolledUser.toString() + " ${"Students_"}",
                style: TextStyle(color: Color(0xff8A8C99), fontSize: 16.0))
          ],
        ),
        SizedBox(
          height: 2.0,
        ),
        Row(
          children: [
            Icon(
              FontAwesomeIcons.circlePlay,
              size: 16.0,
              color: Color(0xff404455),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              details!.courseCount.toString() + " ${"Courses_"}",
              style: TextStyle(
                color: Color(0xff8A8C99),
                fontSize: 16.0,
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: EdgeInsets.fromLTRB(18.0, 5.0, 18.0, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: showImage(),
          ),
          SizedBox(
            width: 7.0,
          ),
          Expanded(flex: 5, child: showDetails(context)),
        ],
      ),
    );
  }
}
