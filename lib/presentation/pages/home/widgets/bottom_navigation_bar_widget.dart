import 'package:flutter/material.dart';
import 'package:spotty_app/utils/styles/app_colors.dart';
import 'package:spotty_app/utils/styles/app_dimensions.dart';

enum NavigationBarItem {
  notifications,
  events,
  location,
  chats,
  settings,
}

class BottomNavigationBarWidget extends StatefulWidget {
  final bool isLocationEnabled;
  final Function(NavigationBarItem) onTabChanged;

  const BottomNavigationBarWidget({
    Key? key,
    required this.isLocationEnabled,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  IconData getIcon(NavigationBarItem item) {
    switch (item) {
      case NavigationBarItem.notifications:
        return Icons.notifications;
      case NavigationBarItem.events:
        return Icons.search;
      case NavigationBarItem.location:
        return Icons.location_on;
      case NavigationBarItem.chats:
        return Icons.message;
      case NavigationBarItem.settings:
        return Icons.settings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: AppDimensions.height.navigationBar,
        margin: const EdgeInsets.all(AppDimensions.defaultPadding),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.defaultPadding),
          ),
        ),
        child: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _navigationBarItem(NavigationBarItem navigationBarItem) {
    if (navigationBarItem == NavigationBarItem.location) return _navigationBarLocationItem();
    return InkWell(
      onTap: () => widget.onTabChanged(navigationBarItem),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                getIcon(navigationBarItem),
                color: AppColors.black,
              ),
              Transform.translate(
                offset: const Offset(10, 10),
                child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    height: 18,
                    width: 18,
                    child: const Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navigationBarLocationItem() {
    NavigationBarItem navigationBarItem = NavigationBarItem.location;
    return Transform.translate(
      offset: const Offset(0, -15),
      child: InkWell(
        onTap: () => widget.onTabChanged(navigationBarItem),
        child: Container(
          margin: const EdgeInsets.only(
            left: 4,
            right: 4,
          ),
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: widget.isLocationEnabled ? AppColors.green : AppColors.gray,
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Icon(
            getIcon(navigationBarItem),
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: NavigationBarItem.values.map((item) => _navigationBarItem(item)).toList(),
    );
  }
}
