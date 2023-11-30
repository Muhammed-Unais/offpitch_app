import 'package:flutter/material.dart';
import 'package:offpitch_app/src/tournament_details/components/appbar.dart';
import 'package:offpitch_app/src/tournament_details/components/details_view_body.dart';
import 'package:offpitch_app/src/tournament_details/view_model/registration_view_model.dart';
import 'package:provider/provider.dart';

class TouranmentDetailsView extends StatelessWidget {
  const TouranmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.00),
        child: DetaislViewAppBar(),
      ),
      body: ChangeNotifierProvider(
        create: (context) => RegistorationViewModel(),
        child: const DetailsViewBody(),
      ),
    );
  }
}
