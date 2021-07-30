import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vidflix/functions/change_language.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/splashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(
      MyApp(
        appLanguage: appLanguage,
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          title: 'VidFlix',
          theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.black,
            ),
          ),
          home: MyHomePage(),
          debugShowCheckedModeBanner: false,
          locale: model.appLocal,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('hi', ''),
            Locale('ar', ''),
            Locale('zh', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
