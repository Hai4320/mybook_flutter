import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mybook_flutter/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:mybook_flutter/src/blocs/book_bloc/book_bloc.dart';
import 'package:mybook_flutter/src/constants/app_localization.dart';
import 'package:mybook_flutter/src/providers/theme_provider.dart';
import 'package:mybook_flutter/src/resources/responsitory/book_repo.dart';
import 'package:mybook_flutter/src/resources/responsitory/user_repo.dart';
import 'package:mybook_flutter/src/ui/pages/login_signup_page.dart';
import 'package:mybook_flutter/src/ui/pages/main_page.dart';
import 'package:mybook_flutter/src/ui/pages/start_page.dart';
import 'package:mybook_flutter/src/ui/themes/themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAuth.instance.signInAnonymously();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(userRepository: UserRepository())..add(AppStarted()),
           ),
          BlocProvider(
              create: (context) => BookBloc(bookRepository: BookRepository()),
          ),
        ],
        child: ChangeNotifierProvider<ThemeProvider>(
            create: (_) => ThemeProvider(),
            builder: (context, _) {
              final themeMode = Provider.of<ThemeProvider>(context);
              return MaterialApp(
                title: 'Flutter Demo',
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightMode,
                darkTheme: AppThemes.darkMode,
                themeMode: themeMode.getThemeMode,
                routes: {
                  '/': (context) => const StartPage(),
                  '/login': (context) => const LoginSignupPage(),
                  "/main": (context) => const MainPage()
                },
                initialRoute:  "/" ,
                supportedLocales: const [
                  Locale("en", "US"),
                  Locale("vi", "VN")
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) {
                  // Check supported languages in device
                  for (var supportedLocale in supportedLocales) {
                    if ((supportedLocale.languageCode ==
                            locale?.languageCode) &&
                        (supportedLocale.countryCode == locale?.countryCode)) {
                      return supportedLocale;
                    }
                    return supportedLocales.first;
                  }
                  // If the locale of the device is not supported, use the first one
                  // from the list (English, in this case).
                  return supportedLocales.first;
                },
              );
            }),
      );
}
