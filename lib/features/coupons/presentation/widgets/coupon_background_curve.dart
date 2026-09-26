// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';


//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*0.873141814865481).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )


final class RPSCustomPainter extends CustomPainter {
  final Color _fillColor;

  RPSCustomPainter(this._fillColor);

  @override
  void paint(Canvas canvas, Size size) {
          
    final Path path_0 = Path();
    path_0.moveTo(size.width*0.9861377,size.height*0.9012952);
    path_0.cubicTo(size.width*0.9642499,size.height*0.8796741,size.width*0.9632923,size.height*0.8445268,size.width*0.9839489,size.height*0.8195634);
    path_0.cubicTo(size.width*0.9987232,size.height*0.8016503,size.width*0.9980392,size.height*0.7768435,size.width*0.9822617,size.height*0.7595571);
    path_0.cubicTo(size.width*0.9652075,size.height*0.7408084,size.width*0.9653899,size.height*0.7128160,size.width*0.9826721,size.height*0.6950073);
    path_0.cubicTo(size.width*1.000593,size.height*0.6765720,size.width*1.000410,size.height*0.6509296,size.width*0.9822161,size.height*0.6320242);
    path_0.cubicTo(size.width*0.9651619,size.height*0.6143200,size.width*0.9649339,size.height*0.5765615,size.width*0.9818057,size.height*0.5594840);
    path_0.cubicTo(size.width*1.002508,size.height*0.5385941,size.width*1.002690,size.height*0.5090349,size.width*0.9822617,size.height*0.4872049);
    path_0.cubicTo(size.width*0.9658459,size.height*0.4696052,size.width*0.9647059,size.height*0.4361291,size.width*0.9798450,size.height*0.4158659);
    path_0.cubicTo(size.width*1.002508,size.height*0.3854711,size.width*1.002143,size.height*0.3521517,size.width*0.9787962,size.height*0.3227491);
    path_0.cubicTo(size.width*0.9661651,size.height*0.3068728,size.width*0.9672139,size.height*0.2745979,size.width*0.9808482,size.height*0.2598705);
    path_0.cubicTo(size.width*1.002964,size.height*0.2360038,size.width*1.002508,size.height*0.2124504,size.width*0.9794802,size.height*0.1895759);
    path_0.cubicTo(size.width*0.9664387,size.height*0.1766242,size.width*0.9653899,size.height*0.1214226,size.width*0.9779298,size.height*0.1086275);
    path_0.cubicTo(size.width*0.9978568,size.height*0.08836432,size.width*1.003967,size.height*0.06423647,size.width*0.9954400,size.height*0.03995195);
    path_0.cubicTo(size.width*0.9884633,size.height*0.02026321,size.width*0.9618787,0,size.width*0.9424989,0);
    path_0.cubicTo(size.width*0.6569083,0,size.width*0.3712722,0,size.width*0.08563611,size.height*0.0001044496);
    path_0.cubicTo(size.width*0.02544460,size.height*0.0001566743,size.width*0.001003192,size.height*0.02804470,size.width*0.001003192,size.height*0.09619804);
    path_0.cubicTo(size.width*0.001003192,size.height*0.3624399,size.width*0.002781578,size.height*0.6286818,0,size.height*0.8948193);
    path_0.cubicTo(size.width*-0.001094391,size.height*0.9983810,size.width*0.02576379,size.height*0.9987466,size.width*0.09224806,size.height*0.9990600);
    path_0.cubicTo(size.width*0.2290014,size.height*0.9996867,size.width*0.3657091,size.height*0.9992166,size.width*0.5024624,size.height*0.9992166);
    path_0.lineTo(size.width*0.5024624,size.height*0.9995300);
    path_0.cubicTo(size.width*0.6482900,size.height*0.9995300,size.width*0.7941632,size.height*0.9990600,size.width*0.9399909,size.height*0.9999478);
    path_0.cubicTo(size.width*0.9676699,size.height*1.000104,size.width*0.9821249,size.height*0.9791101,size.width*0.9937073,size.height*0.9582724);
    path_0.cubicTo(size.width*1.003192,size.height*0.9412471,size.width*1.002782,size.height*0.9177982,size.width*0.9860921,size.height*0.9012429);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = _fillColor;
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}