import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final Color color; 
  const Line({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 30, child: Divider(color: color));
  }
}
