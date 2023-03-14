import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Canvas',
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                width: 800,
                height: 800,
                color: Colors.black,
                child: CustomPaint(painter: FractalTreePainter()),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Slider(
                    value: branchAngle,
                    onChanged: (change) => setState(
                      () => branchAngle = change,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Slider(
                    value: branchShrinkage,
                    onChanged: (change) => setState(
                      () => branchShrinkage = change,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Slider(
                    min: 0,
                    max: 1000,
                    value: branchLength,
                    onChanged: (change) => setState(
                      () => branchLength = change,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: Slider(
                    min: 0,
                    max: 15,
                    value: maxLevel.toDouble(),
                    onChanged: (change) => setState(
                      () => maxLevel = change.floor(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

double branchAngle = .67;
double branchShrinkage = .67;
double branchLength = 200;
int maxLevel = 10;

class FractalTreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.white;

    // initial variables
    // double branchAngle = .67;
    // double branchShrinkage = .67;
    // double branchLength  = 200;
    // int maxLevel = 10;
    double initialAngle = 3.14159 * .5;
    int branchLevel = 0;
    double y = size.width;
    double x = size.width * .5;

    // start branching
    void branch(double x, double y, double angle, double length, int level) {
      if (level >= maxLevel) return;

      // calculate next point
      double dx = length * cos(angle);
      double dy = length * sin(angle);
      double nx = x + dx;
      double ny = y - dy;

      // draw branch
      canvas.drawLine(Offset(x, y), Offset(nx, ny), paint);

      // calculate next level variables
      double nextAngle1 = angle + branchAngle;
      double nextLength1 = length * branchShrinkage;
      double nextX1 = nx;
      double nextY1 = ny;

      double nextAngle2 = angle - branchAngle;
      double nextLength2 = length * branchShrinkage;
      double nextX2 = nx;
      double nextY2 = ny;

      // branch out to the left
      branch(nextX1, nextY1, nextAngle1, nextLength1, level + 1);

      // pop back to the current state
      canvas.drawLine(Offset(nx, ny), Offset(x, y), paint);

      // branch out to the right
      branch(nextX2, nextY2, nextAngle2, nextLength2, level + 1);
    }

    // start the tree
    branch(x, y, initialAngle, branchLength, branchLevel);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
