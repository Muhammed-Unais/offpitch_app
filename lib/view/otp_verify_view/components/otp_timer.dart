import 'package:flutter/material.dart';

class OtpTimer extends StatelessWidget {
  const OtpTimer({super.key});


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "This code will expired in ",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 1.30, end: 0.0),
          duration: const Duration(minutes: 1, seconds: 30),
          builder: (context, value, child) {
            int seconds = (value * 90).ceil();

            // Calculate the minutes and seconds
            int minutes = seconds ~/ 60;
            seconds = seconds % 60;
            // Format the time as "mm.ss"
            String formattedTime =
                "${minutes.toString().padLeft(2, '0')}.${seconds.toString().padLeft(2, '0')}";

            return Text(
              formattedTime,
              style: Theme.of(context).textTheme.labelLarge,
            );
          },
        ),
      ],
    );
  }
}
