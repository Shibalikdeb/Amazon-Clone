import 'package:amazonclone/constants/Themes.dart';
import 'package:amazonclone/pages/homepage.dart';
import 'package:amazonclone/providers/market_provider.dart';
import 'package:amazonclone/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/Themes.dart';
import 'models/localStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String currentTheme = await LocalStorage.getTheme() ?? "light";
  runApp(MyApp(
    theme: currentTheme,
  ));
}

class MyApp extends StatelessWidget {
  final String theme;

  MyApp({required this.theme});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MarketProvider>(
          create: (context) => MarketProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(theme),
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeProvider.themeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
