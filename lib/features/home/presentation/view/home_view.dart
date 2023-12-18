import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/utils/color_manager.dart';
import 'package:todo/features/calendar/presentation/view/calendar_view.dart';
import 'package:todo/features/focus/presentation/view/focus_view.dart';
import 'package:todo/features/home/presentation/view/widgets/custom_bottom_navigation_bar_item.dart';
import 'package:todo/features/home/presentation/view/widgets/custom_floating_action_button.dart';
import 'package:todo/features/index/presentation/view/index_view.dart';
import 'package:todo/features/profile/presentation/view/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int activeIndex = 0;
  final List<Widget> _children = [
    const IndexView(),
    const CalendarView(),
    const FocusView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[activeIndex],
      floatingActionButton: const CustomFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  AnimatedBottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      itemCount: 4,
      activeIndex: activeIndex,
      gapLocation: GapLocation.center,
      onTap: (index) {
        setState(() {
          activeIndex = index;
        });
      },
      height: 65.h,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? ColorManager.greyColor
          : ColorManager.primaryColor,
      tabBuilder: (int index, bool isActive) {
        final color = isActive
            ? Theme.of(context).brightness == Brightness.dark
                ? ColorManager.primaryColor
                : Colors.white
            : Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black54;
        return CustomBottomNavigationBarItem(
          color: color,
          index: index,
        );
      },
    );
  }
}
