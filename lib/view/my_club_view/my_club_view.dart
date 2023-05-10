import 'package:flutter/material.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_appbar_tabar.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_one.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_three.dart';
import 'package:offpitch_app/view/my_club_view/components/my_club_tab_two.dart';
import 'package:offpitch_app/view_model/my_club_view_model/my_club_over_view_model.dart';
import 'package:provider/provider.dart';

class MyClubView extends StatelessWidget {
  const MyClubView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyClubViewModel(),
      child: const DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(120.00),
            child: MyclubAppbarTabbar(),
          ),
          body: TabBarView(
            children: [
              MyClubTabOne(),
              MyClubTabTwo(),
              MyClubTabThree(),
            ],
          ),
        ),
      ),
    );
  }
}
