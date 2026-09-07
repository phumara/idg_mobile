import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'apI_settings_screen.dart';
import 'platzi_product_screen.dart';
import 'dummy_product_screen.dart';
import 'dummy_search_product_screen.dart';
import 'platzi_search_product_screen.dart';

class ApiMainScreen extends StatelessWidget {
  const ApiMainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final selectColor = Theme.of(context).colorScheme.onPrimary;
    final unSelectColor = Theme.of(context).colorScheme.onSurface;

    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: PlatziProductScreen(),
          item: ItemConfig(
            icon: Icon(Icons.home),
            title: "Home",
            activeForegroundColor: selectColor,
            inactiveForegroundColor: unSelectColor,
          ),
        ),
        PersistentTabConfig(
          screen: PlatziSearchProductScreen(),
          item: ItemConfig(
            icon: Icon(Icons.search),
            title: "Search",
            activeForegroundColor: selectColor,
            inactiveForegroundColor: unSelectColor,
          ),
        ),
        PersistentTabConfig(
          screen: DummyProductScreen(),
          item: ItemConfig(
            icon: Icon(Icons.book),
            title: "Dummy",
            activeForegroundColor: selectColor,
            inactiveForegroundColor: unSelectColor,
          ),
        ),
       PersistentTabConfig(
          screen: DummySearchProductScreen(),
          item: ItemConfig(
            icon: Icon(Icons.search),
            title: "Dummy Search",
            activeForegroundColor: selectColor,
            inactiveForegroundColor: unSelectColor,
          ),
        ),
        PersistentTabConfig(
          screen: ApiSettingsScreen(),
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
