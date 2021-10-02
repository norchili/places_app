import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/widgets/floating_action_button_green.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardImageWithFabIcon extends StatelessWidget {
  final String pathImage;
  final double height;
  final double width;
  final double marginLeft;
  final double marginRight;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;
  final bool? internet;

  CardImageWithFabIcon(
      {Key? key,
      required this.pathImage,
      required this.height,
      required this.width,
      required this.onPressedFabIcon,
      required this.iconData,
      this.marginLeft = 20.0,
      this.marginRight = 20.0,
      this.internet});

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> image;
    //Selleciona que tipo de imagen se va a mostrar. local, de camara, de internet
    if (pathImage.contains("assets")) {
      image = AssetImage(pathImage);
    } else if (pathImage.contains("https:")) {
      image = new CachedNetworkImageProvider(pathImage);
    } else
      image = FileImage(File(pathImage));

    final card = Container(
        alignment: Alignment.center,
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(left: marginLeft, right: marginRight),
          decoration: BoxDecoration(
              image: DecorationImage(fit: BoxFit.cover, image: image),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              shape: BoxShape.rectangle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black38,
                    blurRadius: 15.0,
                    offset: Offset(0.0, 7.0))
              ]),
        ));

    return Stack(
      alignment: Alignment(0.7, 0.8),
      children: <Widget>[
        card,
        FloatingActionButtonGreen(
            onPressed: onPressedFabIcon, iconData: iconData)
      ],
    );
  }
}
