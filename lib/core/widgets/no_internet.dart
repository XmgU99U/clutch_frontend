import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 50,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Text("No internet access"), Icon(Icons.wifi_off)],
      ),
    );
    
  }
}
