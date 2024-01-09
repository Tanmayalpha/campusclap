import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedImage extends StatelessWidget {
  final String? image;
  const AppCachedImage({Key? key,  this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    CachedNetworkImage(imageUrl: image ?? '', placeholder: (context, url) =>  Container(
        padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
              image:
              AssetImage("assets/placeholder/avatar.png"),fit: BoxFit.cover)
      )),
      imageBuilder: (context, imageProvider) => Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      errorWidget: (context, url, error) =>  Container(
         // padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                  image:
                  NetworkImage("https://picsum.photos/800/600/?random"),fit: BoxFit.cover)
          ))
    );
  }
}
