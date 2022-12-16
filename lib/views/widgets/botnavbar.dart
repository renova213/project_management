import 'package:final_project/constants/app_font.dart';
import 'package:final_project/view_models/botnavbar_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BotNavBar extends StatefulWidget {
  const BotNavBar({super.key});

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<BotnavbarViewModel>(context, listen: false).changeIndex(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BotnavbarViewModel>(
        builder: (context, navbar, _) => Center(
          child: navbar.pages[navbar.selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(0.0, 1.00),
                blurRadius: 15,
                color: Colors.grey,
                spreadRadius: 1.00),
          ],
        ),
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          child: Consumer<BotnavbarViewModel>(
            builder: (context, navbar, _) => BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset('assets/icons/house.svg',
                      width: 30.w, height: 24.h, color: Colors.blue),
                  icon: SvgPicture.asset('assets/icons/house.svg',
                      width: 30.w, height: 24.h, color: Colors.grey),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  activeIcon: SvgPicture.asset('assets/icons/account.svg',
                      width: 30.w, height: 30.h, color: Colors.blue),
                  icon: SvgPicture.asset('assets/icons/account.svg',
                      width: 30.w, height: 30.h, color: Colors.grey),
                  label: 'Profil',
                ),
              ],
              selectedFontSize: 16.sp,
              iconSize: 30.sp,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: navbar.selectedIndex,
              selectedItemColor: Colors.blue,
              selectedLabelStyle: AppFont.bodyText1,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle:
                  AppFont.bodyText1.copyWith(color: Colors.grey),
              unselectedFontSize: 16.sp,
              onTap: navbar.changeIndex,
            ),
          ),
        ),
      ),
    );
  }
}
