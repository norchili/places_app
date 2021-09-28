import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {
  final String? title;
  final double? height;

  GradientBack({Key? key, this.title, required this.height});

  @override
  Widget build(BuildContext context) {
    //variable para obtener la altura de cualquier pantalla de un celular
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidht = MediaQuery.of(context).size.width;
    double? _height;

    //Establecemos si la altura del gradiente es fullscreeen o alguna medida en particular
    if (height == null) {
      _height = screenHeight;
    } else
      _height = height;

    return Container(
      width: screenWidht,
      height: _height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF4268D3), Color(0xFF584CD1)],
              begin: FractionalOffset(0.2, 0.0),
              end: FractionalOffset(1.0, 0.6),
              stops: [0.0, 0.6],
              tileMode: TileMode.clamp)),
      child: FittedBox(
        fit: BoxFit.none,
        alignment: Alignment(-1.5, -0.8),
        child: Container(
          width: screenHeight,
          height: screenHeight,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              borderRadius: BorderRadius.circular(screenHeight / 2)),
        ),
      ),
      /*Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontFamily: "Lato",
            fontWeight: FontWeight.bold),
      ),*/
      //alignment: Alignment(-0.9, -0.6),
    );
  }
}
