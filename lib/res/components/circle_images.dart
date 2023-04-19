import 'package:flutter/material.dart';

class CircleImages extends StatelessWidget {
  const CircleImages(
      {super.key,
      required this.hight,
      required this.width,
      required this.image, required this.radius});

  final double hight;
  final double width;
  final String image;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            radius,
          ),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            image,
          ),
        ),
      ),
    );
  }
}
