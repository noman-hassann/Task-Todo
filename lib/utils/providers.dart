import 'imports.dart';

class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => TodoController()),
    ChangeNotifierProvider(create: (_) => AuthController()),
  ];
}
