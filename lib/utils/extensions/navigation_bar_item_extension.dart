import 'package:spotty_app/utils/enums/navigation_bar_items_enum.dart';

extension NavigationBarItemExtension on NavigationBarItem? {
  NavigationBarItem get orDefault => this ?? NavigationBarItem.map;
}
