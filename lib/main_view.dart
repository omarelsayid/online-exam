import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:online_exam/core/utils/app_colors.dart';
import 'package:online_exam/core/utils/app_images.dart';
import 'package:online_exam/core/utils/text_styles.dart';
import 'package:online_exam/core/widgets/active_icon_widget.dart';
import 'package:online_exam/features/user_profile/presentation/views/user_profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});
  static const routeName = 'mainView';
  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _screens = [
    Center(child: Text('Explore')),
    Center(child: Text('Results')),
    UserProfileView(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primayColor,
        backgroundColor: Color(0xffedeff3),
        selectedLabelStyle: AppTextStyles.roboto600_14,
        unselectedLabelStyle: AppTextStyles.roboto400_12,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.imagesInActiveExploreIcon),
              activeIcon: ActiveIconWidget(
                  child: SvgPicture.asset(Assets.imagesActiveExploreIcon)),
              label: 'Explore'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.imagesInActiveResultIcon),
              activeIcon: ActiveIconWidget(
                  child: SvgPicture.asset(Assets.imagesActiveIconResults)),
              label: 'Results'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(Assets.imagesInActiveProfileIcon),
              activeIcon: ActiveIconWidget(
                  child: SvgPicture.asset(Assets.imagesActiveProfileIcon)),
              label: 'Results'),
        ],
      ),
    );
  }
}
