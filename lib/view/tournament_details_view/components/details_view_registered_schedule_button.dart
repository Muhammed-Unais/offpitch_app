import 'package:flutter/material.dart';
import 'package:offpitch_app/res/constats.dart';
import 'package:offpitch_app/view_model/tournament_details_view_model.dart/schedule_tournament_view_model.dart';
import 'package:provider/provider.dart';

class DetailsViewRegisteredScheduleBotton extends StatelessWidget {
  const DetailsViewRegisteredScheduleBotton({super.key, this.id});

  final String? id;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          "Schedule tournament",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.red,
            fontSize: 24,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ScheduleTournametViewModel(),
          child: Consumer<ScheduleTournametViewModel>(
            builder: (context, value, _) {
              return Container(
                margin: const EdgeInsets.only(
                  left: AppMargin.large,
                  right: AppMargin.large,
                  top: AppMargin.medium,
                  bottom: AppMargin.medium
                ),
                width: size.width,
                child: OutlinedButton(
                  onPressed: () {
                    value.getGetScheduleTournamet(id, context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    side: const BorderSide(color: Colors.red, width: 0.5),
                  ),
                  child: value.isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.red,
                          strokeWidth: 2,
                        )
                      : const Text(
                          'Schedule',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
