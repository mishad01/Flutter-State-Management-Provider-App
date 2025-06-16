import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api_crud_app/view/main_layout/widget/main_bottom_nav.dart';
import 'package:rest_api_crud_app/view_model/bottom_nav/main_bottom_nav_view_model.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MainBottomNavViewModel>(context);
    return Scaffold(
      body: provider.views[provider.currentIndex],
      bottomNavigationBar: MainBottomNav(
        provider: provider,
      ),
    );
  }
}
