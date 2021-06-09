import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sebarin/utils/routes.dart';
import 'package:sebarin/utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackCupertinoLocalisationsDelegate(),
      ],
      supportedLocales: [Locale('id', 'ID')],
      debugShowCheckedModeBanner: false,
      themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: darkTheme,
      theme: lightTheme,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: 200.milliseconds,
      initialRoute: '/',
      getPages: routes,
    );
  }
}

class FallbackCupertinoLocalisationsDelegate extends LocalizationsDelegate {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => true;

  @override
  Future load(Locale locale) => DefaultCupertinoLocalizations.load(locale);

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}
