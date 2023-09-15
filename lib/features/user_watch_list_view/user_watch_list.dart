import 'package:flutter/material.dart';
import 'package:offpitch_app/features/user_watch_list_view/components/user_watch_list_appbar.dart';
import 'package:offpitch_app/features/user_watch_list_view/components/user_watch_list_body.dart';

class UserWatchListView extends StatelessWidget {
  const UserWatchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.00),
        child: UserWatchlistAppbar(),
      ),
      body: UserWatchListBody(),
    );
  }
}
