import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/constants/assets.dart';
import 'package:mybook_flutter/src/models/user_model.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';

import '../../../resources/responsitory/user_repo.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  var user = UserRepository();
  var userModel = UserModel.createUndefined();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      userModel = await user.getUserData();
      await userModel.getAvatarUrl();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.8)),
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: userModel.avatarURL == ""
                            ? Image.asset(
                                AppImages.img_avatar,
                              )
                            : Image.network(userModel.avatarURL),
                      )),
                  Text(userModel.name)
                ],
              ),
            ),
            _buildDrawItems("Home", Icons.home, () {}),
            const SizedBox(
              height: 10,
            ),
            _buildDrawItems("Setting", Icons.settings, () {}),
            const SizedBox(
              height: 10,
            ),
            _buildDrawItems("About", Icons.info_outline, () {}),
            const SizedBox(
              height: 10,
            ),
            _buildDrawItems("Help", Icons.help_outline, () {}),
          ],
        ),
      ),
    );
  }

  _buildDrawItems(String name, IconData icon, VoidCallback func) {
    return ListTile(
        onTap: () {},
        iconColor: Colors.white,
        leading: Icon(icon),
        title: Text(
          name,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
        ));
  }
}
