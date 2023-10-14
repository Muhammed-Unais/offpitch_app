import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/src/tournament_details_view/view_model/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class PaymentStatusScreen extends StatelessWidget {
  const PaymentStatusScreen(
      {super.key, this.isSuccess = true, required this.tournamentId});
  final bool isSuccess;
  final String tournamentId;
  @override
  Widget build(BuildContext context) {
    String statusText = isSuccess ? 'Payment Successful!' : 'Payment Failed';
    Color statusColor = isSuccess ? Colors.green : Colors.red;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSuccess ? Icons.check_circle_outline : Icons.cancel_outlined,
              color: isSuccess ? AppColors.black : Colors.red,
              size: 80,
            ),
            const SizedBox(height: 20),
            Text(
              statusText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isSuccess ? 'Thank you.' : 'Payment was not successful.',
              style: TextStyle(
                fontSize: 12,
                color: statusColor,
                fontWeight: FontWeight.bold,
                fontFamily: "Lato",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context
                    .read<DetailsTouramentViewModel>()
                    .getSingleTournament(tournamentId);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text(
                'Back to Your Tournament',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
