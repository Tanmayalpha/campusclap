import 'dart:ui';
import 'package:flutter/material.dart';

import 'color.dart';

class Btn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  Btn(
      {Key? key,
        this.title,
        this.onPress,
        this.height,
        this.width,
        this.fSize,
        this.icon,
        this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colors.lightgray,
                offset: Offset(
                  0.0,
                  3.0,
                ),
                blurRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            color: colors.whiteTemp,
            border: Border.all(color: colors.primary, width: 2)),
        width: width ?? MediaQuery.of(context).size.width * 0.6,
        height: 50,
        child: Center(
            child: Text(
              "$title",
              style: TextStyle(
                  color: colors.primary, fontSize: 18, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}

class ComenBtn extends StatelessWidget {
  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  ComenBtn(
      {Key? key,
        this.title,
        this.onPress,
        this.height,
        this.width,
        this.fSize,
        this.icon,
        this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
      return InkWell(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: colors.lightgray,
                offset: Offset(
                  0.0,
                  3.0,
                ),
                blurRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [colors.secondary,colors.primary]),
            //  color: colors.primary,
          ),
          width: MediaQuery.of(context).size.width * 0.6,
          height: 50,
          child: Center(
              child: Text(
                "$title",
                style: const TextStyle(
                    color: colors.whiteTemp,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              )),
        ),
      );
  }
}


class BuyBtn extends StatelessWidget {

  final String? title;
  final VoidCallback? onPress;
  double? height;
  double? width;
  double? fSize;
  IconData? icon;
  Color? color;
  bool? isLoading;
   BuyBtn({super.key,this.title,
    this.onPress,
    this.height,
    this.width,
    this.fSize,
    this.icon,
    this.color, this.isLoading});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        height: 55.0,
        width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: colors.lightgray,
                offset: Offset(
                  0.0,
                  3.0,
                ),
                blurRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [colors.secondary,colors.primary]),
            //  color: colors.primary,
          ),
        child: Stack(
          children: [
            Center(
              child: isLoading ?? false
                  ? const CircularProgressIndicator(
                valueColor:
                 AlwaysStoppedAnimation<Color>(Colors.white),
              )
                  : Text( title ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 4,
              child: Container(
                margin: const EdgeInsets.all(3.0),
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.00),
                ),
                child: Image.asset(
                  'assets/icons/buynow.png'/* "assets/icons/addtocart.png"*/,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}