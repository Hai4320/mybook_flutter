import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({ Key? key }) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.8)),
      ),
    );
  }
}