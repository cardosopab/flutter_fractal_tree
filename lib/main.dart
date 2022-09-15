import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canvas',
      home: Scaffold(
        body: Center(
          child: Container(
            width: 800,
            height: 800,
            color: Colors.black,
            child: CustomPaint(painter: FaceOutlinePainter()),
          ),
        ),
      ),
    );
  }
}

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.white;
// initial variables
    double DA = .67;
    double SHRINK = .67;
    double A = 3.14159 * .5;
    double L = 200;
    int LEVEL = 0;
    int MAXLEV = 3;
    double y = size.width;
    double x = size.width * .5;
// level arrays
    List xList = [];
    List yList = [];
    final point = Path();

// start branching
    void branch() {
      if (LEVEL < MAXLEV) {
        // calculate next point
        double dx = L * cos(A);
        double dy = L * sin(A);
        double nx = x + dx;
        double ny = y - dy;

        //print("$LEVEL Branch x: $x, y: $y, nx: $nx, ny: $ny");
        //draw branch
        print("Drawing x:$x,y:$y, nx:$nx,ny:$ny, LEVEL: $LEVEL");
        canvas.drawLine(Offset(x, y), Offset(nx, ny), paint);

        // save position
        xList.add(x);
        yList.add(y);

        // next branch
        x = nx;
        y = ny;
        //print("list coor: ${xList[LEVEL]}, ${yList[LEVEL]}, new x: $x, new y: $y");
        LEVEL++;
        A = A + DA;
        L = L * SHRINK;
        //print("A: $A, L: $L,Level: $LEVEL");
        if (LEVEL < MAXLEV) {
          branch();
        }

        //another branch
        //print("another branch");
        A = A - DA * 2;

        if (LEVEL < MAXLEV) {
          branch();
        }

        // pop back
        //print("pop back");
        A = A + DA;
        L = L / SHRINK;
        print("Level: $LEVEL");
        LEVEL--;
        x = xList[LEVEL];
        y = yList[LEVEL];
        // print("pop x: $x, y: $y, A: $A, L: $L, Level--: $LEVEL");
        // for (int i = 0; i < xList.length; i++) {
        //   print("xList: ${xList[i]}, yList: ${yList[i]}, $i");
        // }
        print("xList: ${xList[LEVEL]}, yList: ${yList[LEVEL]}");
        return;
      }
    }

    branch();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
