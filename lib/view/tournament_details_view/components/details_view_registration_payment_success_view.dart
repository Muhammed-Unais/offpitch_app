import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/registration_view_model.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/tournament_detils_view_model.dart';
import 'package:provider/provider.dart';

class PaymentStatusScreen extends StatelessWidget {
  const PaymentStatusScreen({super.key, this.isSuccess = true});
  final bool isSuccess;
  @override
  Widget build(BuildContext context) {
    String statusText = isSuccess ? 'Payment Successful!' : 'Payment Failed';
    Color statusColor = isSuccess ? Colors.green : Colors.red;
    final tournamentId =
        Provider.of<RegistorationViewModel>(context).tournamentIdforSavePay;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSuccess ? Icons.check_circle_outline : Icons.cancel_outlined,
              color: AppColors.primary,
              size: 100,
            ),
            const SizedBox(height: 16),
            Text(
              statusText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isSuccess ? 'Thank you.' : 'Payment was not successful.',
              style: TextStyle(fontSize: 16, color: statusColor),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Provider.of<DetailsTouramentViewModel>(context, listen: false)
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
                  fontSize: 18,
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
