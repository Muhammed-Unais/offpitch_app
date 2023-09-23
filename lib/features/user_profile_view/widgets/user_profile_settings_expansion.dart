import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/utils/utils.dart';
import 'package:offpitch_app/features/user_profile_view/widgets/user_profile_logout_alert_dia.dart';
import 'package:share_plus/share_plus.dart';

class UserProfileSettingsExpansion extends StatelessWidget {
  const UserProfileSettingsExpansion({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(IconlyBold.setting),
      shape: const Border(
        bottom: BorderSide(color: AppColors.grey, width: 0.4),
      ),
      iconColor: AppColors.primary,
      textColor: AppColors.primary,
      expandedAlignment: Alignment.topLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      tilePadding: const EdgeInsets.all(0),
      childrenPadding: const EdgeInsets.all(0),
      title: const Text(
        "Settings",
        style: TextStyle(
          fontFamily: "Lato",
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 6),
              child: CirclePainterWidget(radius: 3.5, color: AppColors.black),
            ),
            GestureDetector(
              onTap: () async {
                await Share.share(
                    "https://play.google.com/store/apps/details?id=in.dartz.offpitch");
              },
              child: const Text(
                "ShareApp",
                style: TextStyle(
                  fontFamily: "SFUIDisplay",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 10, left: 10, top: 6),
              child: CirclePainterWidget(radius: 3.5, color: AppColors.black),
            ),
            GestureDetector(
              onTap: () {
                Utils.showDialogue(context, child: const LogoutAlertDialog());
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontFamily: "SFUIDisplay",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class CirclePainterWidget extends StatelessWidget {
  final double radius;
  final Color color;

  const CirclePainterWidget(
      {super.key, required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CirclePainter(radius: radius, color: color),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final double radius;
  final Color color;

  _CirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(size.width / 2, size.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
