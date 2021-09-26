import 'package:flutter/material.dart';
import 'package:algarve_wedding/logic/theme-mode/toggle_theme.dart';
import 'package:algarve_wedding/widgets/appbar.dart';
import 'package:algarve_wedding/logic/bottom-navigation/bottom-navigation_items.dart';
import 'logic/theme-mode/dark_theme.dart';
import 'logic/theme-mode/light_theme.dart';
import 'logic/theme-mode/controller.dart';
import 'logic/theme-mode/get_theme.dart';

class MyBottomNav extends StatefulWidget {
  @override
  _MyBottomNavState createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _selectedIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getThemeMode(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: true,
      stream: isLightTheme.stream,
      builder: (context, snapshot) {
        return MaterialApp(
          themeMode: snapshot.data
              ? toggleThemeMode('Brightness.light', context)
              : toggleThemeMode('Brightness.dark', context),
          theme: lightThemeData(),
          darkTheme: darkThemeData(),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox.expand(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _selectedIndex = index);
                },
                children: bottomNavigationChildren,
              ),
            ),
            appBar: returnAppBar(false, context),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              items: bottomNavigationItems,
            ),
          ),
        );
      },
    );
  }
}
