import 'package:scanguard/utils/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController = AuthController();

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      navigateToNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.appLogo,
              height: 200.0,
            ),
            40.heightBox,
            showLoader(),
          ],
        ),
      ),
    );
  }

  void navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      authController.checkVerificationStatus(context);
    });
  }
}
