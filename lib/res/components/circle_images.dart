import 'package:flutter/material.dart';

class CircleImages extends StatelessWidget {
  const CircleImages(
      {super.key,
      required this.image,
      required this.radius});

  
  final String image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(
        image,
      ),
    );
  }
}
