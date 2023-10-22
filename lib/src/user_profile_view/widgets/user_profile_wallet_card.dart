import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class UserProfileWalletCard extends StatelessWidget {
  const UserProfileWalletCard({super.key, this.walletAmount});

  final int? walletAmount;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      surfaceTintColor: AppColors.white,
      color: AppColors.primary,
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              Colors.orange.shade900,
            ],
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          title: const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet_outlined),
              SizedBox(
                width: AppMargin.small,
              ),
              Text(
                "WALLET",
                style: TextStyle(
                fontFamily: "Lato",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Balance",
                style: TextStyle(
                  overflow: TextOverflow.clip,
                  fontFamily: "Lato",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
              Text(
                "₹${walletAmount ?? 0}",
                style: const TextStyle(
                  fontFamily: "SFUIDisplay",
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
