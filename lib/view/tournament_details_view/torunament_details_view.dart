import 'package:flutter/material.dart';
import 'package:offpitch_app/view/tournament_details_view/components/appbar.dart';
import 'package:offpitch_app/view/tournament_details_view/components/details_view_body.dart';

class TouranmentDetailsView extends StatelessWidget {
  const TouranmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          60.00,
        ),
        child: DetaislViewAppBar(),
      ),
      body: DetailsViewBody()
    );
  }
}
