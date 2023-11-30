import 'package:flutter/material.dart';
import 'package:offpitch_app/src/club_creation/components/club_creation_appbar.dart';
import 'package:offpitch_app/src/club_creation/components/club_creation_body.dart';
import 'package:offpitch_app/src/club_creation/view_model/create_new_club_view_model.dart';
import 'package:provider/provider.dart';

class ClubCreationView extends StatelessWidget {
  const ClubCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.00),
        child: Consumer<CreateNewClubViewModel>(
          builder: (context,createNewClubViewModelProvider,_) {
            return ClubCreationAppBar(
              appBarText: createNewClubViewModelProvider.isCreate
                  ? "Create New Club"
                  : "Update Your Club",
            );
          }
        ),
      ),
      body: const ClubCreationBody(),
    );
  }
}
