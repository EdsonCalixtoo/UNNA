import 'package:flutter/material.dart';
import 'package:unna/screens/filter.dart';
import 'package:unna/screens/home.dart';
import 'package:unna/screens/user_profile.dart';
import '../common/customNavBar.dart';
import 'post_add_edit.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [Home(), FilterScreen(), PostAddEditScreen(), UserProfileScreen()],
      ),
      bottomNavigationBar: CustomNavBar(pageController: _pageController),
    );
  }
}
