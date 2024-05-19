import 'package:irone/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:irone/app/shared/shared_theme.dart';
import 'package:irone/app/utils/local_db.dart';

import '../app/modules/init/bindings/init_binding.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await LocalDb.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBinding(),
      title: 'PKK Bitung Digital',
      theme: SharedTheme.lightTheme,
      darkTheme: SharedTheme.darkTheme,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'), // I ndonesia
      ],
      debugShowCheckedModeBanner: false,
      enableLog: true,
    );
  }
}
