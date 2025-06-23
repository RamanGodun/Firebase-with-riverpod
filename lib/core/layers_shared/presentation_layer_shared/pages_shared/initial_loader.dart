import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;

///
Future<ThemeMode> resolveThemeMode() async {
  ///

  ///
  await GetStorage.init();
  final storage = GetStorage();

  final isDark = storage.read('isDarkTheme') as bool?;

  final ThemeMode themeMode = switch (isDark) {
    true => ThemeMode.dark,
    false => ThemeMode.light,
    null =>
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
              Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
  };
  return themeMode;
}

////

////

final class InitialLoader extends StatelessWidget {
  final ThemeMode themeMode;

  const InitialLoader({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
