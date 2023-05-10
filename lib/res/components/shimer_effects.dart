import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimerWidget extends StatelessWidget {
  // const ShimerWidget({super.key, required this.width, required this.hight, required this.border});

  final double width;
  final double hight;
  final ShapeBorder border;
  final double verticalMargin;
  final double? borderRadius;

  ShimerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    required this.hight,
    required this.verticalMargin, this.borderRadius,
  }) : border = RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 0));

  const ShimerWidget.circuler(
      {super.key,
      this.width = double.infinity,
      required this.hight,
      this.border = const CircleBorder(),
      required this.verticalMargin, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade300,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: verticalMargin),
        width: width,
        height: hight,
        decoration: ShapeDecoration(
          shape: border,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
