import 'package:flutter/material.dart';
import 'package:places_app/widgets/gradient_back.dart';
import '../widgets/card_image_list.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GradientBack(title: "Bienvenido", height: 250.0),
        CardImageList()
      ],
    );
  }
}
