import 'package:flutter/material.dart';
import 'package:rest_api_crud_app/view_model/bottom_nav/main_bottom_nav_view_model.dart';

class MainBottomNav extends StatelessWidget {
  const MainBottomNav({
    super.key,
    required this.provider,
  });

  final MainBottomNavViewModel provider;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: provider.currentIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.grey[600],
      selectedLabelStyle: TextStyle(
        color: Colors.indigo,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: Colors.grey[600],
      ),
      type: BottomNavigationBarType.fixed,
      onTap: provider.changeIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_sharp),
          label: "Crud",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: "Expense\nTracker",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.how_to_vote),
          label: "Vote\nApp",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.track_changes),
          label: "Habit\nTracker",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: "Search\nItem",
        ),
      ],
    );
  }
}
