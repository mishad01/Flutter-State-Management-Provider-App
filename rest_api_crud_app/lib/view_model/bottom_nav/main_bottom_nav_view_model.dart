import 'package:flutter/cupertino.dart';
import 'package:rest_api_crud_app/view/expense_tracker/expense_tracker_home_page.dart';
import 'package:rest_api_crud_app/view/habit_tracker/habit_tracker_home.dart';
import 'package:rest_api_crud_app/view/rest_api_crud/rest_api_home_page.dart';
import 'package:rest_api_crud_app/view/search_item_app/search_item_app_home.dart';
import 'package:rest_api_crud_app/view/vote_candidate/vote_candidate_home.dart';

class MainBottomNavViewModel with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<Widget> views = [
    //ThemeAndLocalizationView(),
    RestApiHomePage(),
    ExpenseTrackerHomePage(),
    VoteCandidateHome(),
    HabitTrackerHome(),
    SearchItemAppHome(),
  ];
}
