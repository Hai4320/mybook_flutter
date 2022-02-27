import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/providers/theme_provider.dart';
import 'package:mybook_flutter/src/ui/pages/home_page.dart';
import 'package:mybook_flutter/src/ui/pages/login_register_page.dart';
import 'package:mybook_flutter/src/ui/pages/start_page.dart';
import 'package:mybook_flutter/src/ui/themes/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider(),
    builder: (context, _) {
      final themeMode  = Provider.of<ThemeProvider>(context) ;
      return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightMode,
      darkTheme: AppThemes.darkMode,
      themeMode: themeMode.getThemeMode,
      home: const LoginPage(),
    );
    }
  );
  
}

