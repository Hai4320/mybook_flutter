import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mybook_flutter/src/data/app_localization.dart';
import 'package:mybook_flutter/src/providers/theme_provider.dart';
import 'package:mybook_flutter/src/ui/pages/home_page.dart';
import 'package:mybook_flutter/src/ui/pages/auth_page.dart';
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
      supportedLocales: const [
        Locale("en","US"),
        Locale("vi","VN")
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
      // Check supported languages in device
      for (var supportedLocale in supportedLocales) {
        if ((supportedLocale.languageCode == locale?.languageCode) && (supportedLocale.countryCode == locale?.countryCode)) { 
          return supportedLocale;
        }
        return supportedLocales.first;
      }
 // If the locale of the device is not supported, use the first one
 // from the list (English, in this case).
  return supportedLocales.first;
},
      home: const AuthPage(),
    );
    }
  );
  
}


