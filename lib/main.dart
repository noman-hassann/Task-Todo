import 'package:scanguard/utils/imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiProvider(
          providers: AppProviders.providers,
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            //   home: GifScreen(),
            initialRoute: ScreenRoutes.splashScreen,
            onGenerateRoute: ScreenRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
