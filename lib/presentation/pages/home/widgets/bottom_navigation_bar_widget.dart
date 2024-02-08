import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:spotty_app/utils/enums/navigation_bar_items_enum.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final Function(NavigationBarItem) onTabChanged;
  final bool isLocationEnabled;
  final NavigationBarItem currentTab;
  final int eventsCount;
  final int chatsCount;
  final int usersCount;

  const BottomNavigationBarWidget({
    Key? key,
    required this.onTabChanged,
    required this.isLocationEnabled,
    required this.currentTab,
    required this.eventsCount,
    required this.chatsCount,
    required this.usersCount,
  }) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  bool get isThemeDark => Theme.of(context).brightness == Brightness.dark;

  IconData getIcon(NavigationBarItem item) {
    switch (item) {
      case NavigationBarItem.map:
        return LucideIcons.mapPin;
      case NavigationBarItem.events:
        return LucideIcons.calendarDays;
      case NavigationBarItem.users:
        return LucideIcons.users;
      case NavigationBarItem.chats:
        return LucideIcons.messageCircle;
      case NavigationBarItem.settings:
        return LucideIcons.settings;
      case NavigationBarItem.mapSearch:
        return LucideIcons.search;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.height.navigationBar,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: NavigationBarItem.values
          .where((item) => item != NavigationBarItem.mapSearch)
          .map(_buildNavigationBarItem)
          .toList(),
    );
  }

  Widget _buildNavigationBarItem(NavigationBarItem item) {
    return _navigationBarItem(item);
  }

  Widget _navigationBarItem(NavigationBarItem navigationBarItem) {
    int count = _getCount(navigationBarItem);
    return InkWell(
      onTap: () => widget.onTabChanged(navigationBarItem),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                size: 23,
                getIcon(navigationBarItem),
                color: navigationBarItem == widget.currentTab
                    ? AppColors.blue
                    : isThemeDark
                        ? DarkAppColors.gray
                        : LightAppColors.gray,
              ),
              if (count != 0)
                Transform.translate(
                  offset: const Offset(10, 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: navigationBarItem == NavigationBarItem.users ? AppColors.green : AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    height: 18,
                    width: 18,
                    child: Center(
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  int _getCount(NavigationBarItem navigationBarItem) {
    switch (navigationBarItem) {
      case NavigationBarItem.events:
        return widget.eventsCount;
      case NavigationBarItem.chats:
        return widget.chatsCount;
      case NavigationBarItem.users:
        return widget.usersCount;
      default:
        return 0;
    }
  }
}
