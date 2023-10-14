import 'package:flutter/material.dart';
import 'package:offpitch_app/src/details_view_schedule_view.dart/view_model/schedule_tournament_view_model.dart';
import 'package:offpitch_app/src/tournament_details_view/model/single_tournament_model.dart';
import 'package:offpitch_app/res/styles/app_theme.dart';
import 'package:offpitch_app/res/constats.dart';

class LeagueTeamsTabViewTwo extends StatefulWidget {
  const LeagueTeamsTabViewTwo({super.key, required this.singleTournamentModel});

  final SingleTournamentModel singleTournamentModel;

  @override
  State<LeagueTeamsTabViewTwo> createState() => _LeagueTeamsTabViewTwoState();
}

class _LeagueTeamsTabViewTwoState extends State<LeagueTeamsTabViewTwo> {
  var groupTeamsTable = ["TEAM", "MP", "W", "D", "L", "GF", "GA", "GD", "PTS"];

  List<List<List<String>>> groupteamsPonits = [];

  late List<List<String>> teamPoints;

  late List<Group> groups;

  @override
  void initState() {
    groupsPoints();
    super.initState();
  }

  void groupsPoints() {
    if (widget.singleTournamentModel.data?.groups != null) {
      groups = widget.singleTournamentModel.data!.groups!;
    }
    for (var group in groups) {
      addGroupTeamPoints(group.teams!);
    }
  }

  void addGroupTeamPoints(List<GroupTeam> groupTeams) {
    teamPoints = groupTeams
        .map((team) => groupTeamsTable.map((header) {
              if (header == "TEAM") return "team";
              var json = team.toJson();
              return json[header.toLowerCase()].toString();
            }).toList())
        .toList();
    groupteamsPonits.add(teamPoints);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: groups.length,
      itemBuilder: (context, groupsIndex) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  groups[groupsIndex].name ?? "Group -",
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              DataTable(
                horizontalMargin: 20,
                columnSpacing: 28,
                columns: List.generate(
                  groupTeamsTable.length,
                  (tableColumnIndex) => DataColumn(
                    label: Text(
                      groupTeamsTable[tableColumnIndex],
                      style: const TextStyle(
                        color: AppColors.black,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                rows: List.generate(
                  groups[groupsIndex].teams?.length ?? 0,
                  (groupTeamsIndex) {
                    final data = groups[groupsIndex].teams?[groupTeamsIndex];
                    var scheduleviewModel = ScheduleTournametViewModel();
                    var teamName =
                        scheduleviewModel.setFirstLetterofClubTeamA(data?.name);
                    return DataRow(
                      cells: List.generate(
                        groupTeamsTable.length,
                        (teamPointCellIndex) {
                          if (teamPointCellIndex == 0) {
                            return DataCell(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.white,
                                      backgroundImage: NetworkImage(
                                        data?.profile == null ||
                                                data!.profile!.isEmpty
                                            ? AppProfilesCover.clubCover
                                            : data.profile!,
                                      ),
                                      radius: 16.0,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      teamName?.toUpperCase() ?? "NFC",
                                      style: const TextStyle(
                                        color: AppColors.black,
                                        fontFamily: "Lato",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return DataCell(
                            Text(
                              groupteamsPonits[groupsIndex][groupTeamsIndex]
                                  [teamPointCellIndex],
                              style: const TextStyle(
                                color: AppColors.black,
                                fontFamily: "SFUIDisplay",
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }
}
