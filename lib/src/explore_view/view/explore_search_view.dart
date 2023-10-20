import 'package:flutter/material.dart';
import 'package:offpitch_app/res/components/search_component.dart';
import 'package:offpitch_app/src/explore_view/components/explore_search_results.dart';

class ExploreSearchView extends StatefulWidget {
  const ExploreSearchView({super.key});

  @override
  State<ExploreSearchView> createState() => _ExploreSearchViewState();
}

class _ExploreSearchViewState extends State<ExploreSearchView> {
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  void dispose() {
    searchTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          searchTextEditingController.clear();
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            "TOURNAMENTS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            SearchWidget(
              textEditingController: searchTextEditingController,
            ),
            const SizedBox(
              height: 10,
            ),
            const Expanded(
              child: ExploreSearchResults(),
            )
          ],
        ),
      ),
    );
  }
}
