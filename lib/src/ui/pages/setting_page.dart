import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';
import 'package:mybook_flutter/src/ui/widgets/stateless/transparent_appbar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({ Key? key }) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: TransparentAppBar("Setting",AppColors.primary),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Text("Setting"),
      )
    );
  }
}