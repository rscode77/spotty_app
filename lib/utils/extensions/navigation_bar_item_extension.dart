import 'package:spotty_app/presentation/pages/home/widgets/bottom_navigation_bar_widget.dart';

extension NavigationBarItemExtension on NavigationBarItem? {
  NavigationBarItem get orDefault => this ?? NavigationBarItem.notifications;
}
