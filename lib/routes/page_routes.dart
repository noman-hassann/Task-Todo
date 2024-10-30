import '../utils/imports.dart';

class ScreenRoutes {
  static const String splashScreen = "splashScreen";
  static const String loginScreen = "loginScreen";
  static const String todoListScreen = "todoListScreen";
  static const String createTodoScreen = "createTodoScreen";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return FadeRoute(page: const SplashScreen());

      case loginScreen:
        return FadeRoute(page: const LoginScreen());
      case todoListScreen:
        return FadeRoute(page: const TodoListScreen());
      case createTodoScreen:
        return FadeRoute(page: CreateTodoScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
