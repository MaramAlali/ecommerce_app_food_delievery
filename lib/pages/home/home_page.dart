import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../pages/accounts/account_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../cart/cart_history.dart';
import '../order/order_page.dart';
import 'main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PersistentTabController?_controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  //late PersistentTabController _controller;
  List pages = [
    const MainFoodpage(),
    const Center(child: Text("Next page")),
    const Center(child: Text("2nd page")),
    const Center(child: Text("3rd page")),
    const Center(child: Text("4th page")),
  ];
  onTapNav(int index) {
    setState(() {
    });
  }
  List<Widget> _buildScreens() {
    return [
      const MainFoodpage(),
      const OrderPage(),
      const CartHistory(),
      const AccountPage(),

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        title: ("الرَئِيسِيّةَ"),

        activeColorPrimary:const Color.fromARGB(255, 197, 148, 81),
        inactiveColorPrimary: const Color.fromARGB(255, 206, 143, 48),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox_fill),
        title: ("السَجِل"),
        activeColorPrimary:const Color.fromARGB(255, 197, 148, 81),
        inactiveColorPrimary: const Color.fromARGB(255, 206, 143, 48),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.car),
        title: ("السَلَةَ"),
        activeColorPrimary: const Color.fromARGB(255, 197, 148, 81),
        inactiveColorPrimary: const Color.fromARGB(255, 206, 143, 48),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person_fill),
        title: ("حِسَابِي"),
        activeColorPrimary:const Color.fromARGB(255, 197, 148, 81),
        inactiveColorPrimary:const Color.fromARGB(255, 206, 143, 48),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
      true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
      true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(7.0),
        colorBehindNavBar: Colors.black26,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.bounceInOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.bounceInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
      NavBarStyle.style11, // Choose the nav bar style with this property.
    );
  }
}
