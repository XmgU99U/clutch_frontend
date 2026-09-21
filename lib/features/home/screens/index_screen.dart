import 'package:clutch/core/constants/app_fonts.dart';
import 'package:clutch/core/constants/app_images.dart';
import 'package:clutch/core/theme/app_colors.dart';
import 'package:clutch/features/home/screens/tabs/feed.dart';
import 'package:clutch/features/home/screens/tabs/messages.dart';
import 'package:clutch/features/home/screens/tabs/profile.dart';
import 'package:clutch/features/home/widgets/tab_icon.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({super.key});

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final List<Widget> tabs = [const Feed() , const Messages() , const Profile()];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[index],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        unselectedItemColor: AppColors.greyTexy,
        selectedItemColor: AppColors.primary,
        unselectedLabelStyle:  const TextStyle(
          fontSize: 9,
          fontFamily: AppFonts.jetBrainsMono,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 9,
          fontFamily: AppFonts.jetBrainsMono,
        ),
        currentIndex: index,
        onTap: (value) => setState(() {
          index = value;
        }),
        backgroundColor: const Color(0xff161615),
        items: [
          const BottomNavigationBarItem(
            icon: TabIcon(icon: AppImages.home, isActive: false),
            activeIcon: TabIcon(icon: AppImages.home , activeIcon: AppImages.homeFilled, isActive: true),
            label: 'FEED',
          ),
          const BottomNavigationBarItem(
            icon: TabIcon(icon: AppImages.msg, isActive: false),
            activeIcon: TabIcon(icon: AppImages.msg, isActive: true), 
            label: 'MESSAGES',
          ),
          const BottomNavigationBarItem(
            icon: TabIcon(icon: AppImages.user, isActive: false),
            activeIcon: TabIcon(icon: AppImages.user, isActive: true),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}
