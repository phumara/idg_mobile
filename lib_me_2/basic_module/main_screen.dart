import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final selectColor = Theme.of(context).colorScheme.onPrimary;
    final unSelectColor = Theme.of(context).colorScheme.onSurface;

    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomeScreen(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: "Home",
            activeForegroundColor: selectColor,
            inactiveForegroundColor: unSelectColor,
          ),
        ),
        PersistentTabConfig(
          screen: LoginScreen(),
          item: ItemConfig(
            icon: Icon(Icons.search),
            title: "Search",
            activeForegroundColor: selectColor,
            inactiveForegroundColor: unSelectColor,
          ),
        ),
        PersistentTabConfig(
          screen: ProfileScreen(),
          item: ItemConfig(
            icon: Icon(Icons.person),
            title: "Profile",
            activeForegroundColor: selectColor,
            inactiveForegroundColor: unSelectColor,
          ),
        ),
        PersistentTabConfig(
          screen: SettingsScreen(),
          item: ItemConfig(
            icon: Icon(Icons.menu),
            title: "Menu",
            activeForegroundColor: selectColor,
            inactiveForegroundColor: unSelectColor,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
