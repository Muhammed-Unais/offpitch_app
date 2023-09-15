import 'package:flutter/material.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class UserProfileWalletCard extends StatelessWidget {
  const UserProfileWalletCard({super.key, this.walletAmount});

  final int? walletAmount;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: AppMargin.large,
        top: AppPadding.extraSmall,
      ),
      surfaceTintColor: AppColors.white,
      color: AppColors.primary,
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              Colors.orange.shade900,
            ],
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(AppPadding.small),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.account_balance_wallet_outlined),
              const SizedBox(
                width: AppMargin.small,
              ),
              Text(
                "Wallet",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Balance",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "₹${walletAmount ?? 0}",
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
