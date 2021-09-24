import 'package:flutter/material.dart';
import 'package:places_app/widgets/floating_action_button_green.dart';

class CardImageWithFabIcon extends StatelessWidget {
  final String pathImage;
  final double height;
  final double width;
  final double marginLeft;
  final double marginRight;
  final VoidCallback onPressedFabIcon;
  final IconData iconData;

  CardImageWithFabIcon(
      {Key? key,
      required this.pathImage,
      required this.height,
      required this.width,
      required this.onPressedFabIcon,
      required this.iconData,
      this.marginLeft = 20.0,
      this.marginRight = 20.0});

  @override
  Widget build(BuildContext context) {
    final card = Container(
        alignment: Alignment.center,
        child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(left: marginLeft, right: marginRight),
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(pathImage)),
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
