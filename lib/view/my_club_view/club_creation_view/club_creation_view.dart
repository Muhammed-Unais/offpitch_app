import 'package:flutter/material.dart';
import 'package:offpitch_app/view/my_club_view/club_creation_view/components/club_creation_appbar.dart';
import 'package:offpitch_app/view/my_club_view/club_creation_view/components/club_creation_body.dart';

class ClubCreationView extends StatelessWidget {
  const ClubCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.00),
        child: ClubCreationAppBar(),
      ),
      body: ClubCreationBody()
    );
  }
}
