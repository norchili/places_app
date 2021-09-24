import 'package:flutter/material.dart';

class TextInputLocation extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final TextEditingController? controller;
  final IconData iconData;

  TextInputLocation(
      {Key? key,
      required this.fontSize,
      required this.hintText,
      this.controller,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 20.0, left: 20.0),
        child: TextField(
          controller: controller,
          style: TextStyle(
              fontSize: fontSize,
              fontFamily: "Lato",
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold),
          // Decoracion de la entrada de texto
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(iconData),
            fillColor: Color(0xFFFFFFFF),
            filled: true,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFFFFFF)),
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
          ),
        ),
        //Decoracion del Container, se agrega la sombra de fondo
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12, blurRadius: 15.0, offset: Offset(0.0, 5.0))
        ]));
  }
}
