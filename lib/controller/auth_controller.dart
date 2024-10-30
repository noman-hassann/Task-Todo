import 'package:scanguard/utils/imports.dart';

class AuthController extends ChangeNotifier {
  // AuthController() {
  //   pushyRegister();
  // }
  final ApiRepository repo = ApiRepository();

  TextEditingController emailSignInTextEditingController =
      TextEditingController();
  TextEditingController passwordSignInTextEditingController =
      TextEditingController();

  bool isVisible = false;
  bool isConfirmPasswordSignUpVisible = false;
  bool isConfirmPasswordVisible = false;

  ///Forgot Password Visibility
  bool isForgotPasswordVisible = false;
  bool isConfirmForgotPasswordVisible = false;

  ///Change password visibility

  String? otpValue;
  String latitude = "";
  String longitude = "";
  String? tokenKey;
  File? profileImage;

  //user name and email variables
  String name = '';
  String email = '';
  String uniqueID = '';

  ///Password visibilities
  passwordVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  confirmPasswordVisibility() {
    isConfirmPasswordSignUpVisible = !isConfirmPasswordSignUpVisible;
    notifyListeners();
  }

  forgotPasswordVisibility() {
    isForgotPasswordVisible = !isForgotPasswordVisible;
    notifyListeners();
  }

  confirmForgotPasswordVisibility() {
    isConfirmForgotPasswordVisible = !isConfirmForgotPasswordVisible;
    notifyListeners();
  }

  bool _authloading = false;
  bool get authloading => _authloading;

  setLoading(bool value) {
    _authloading = value;
    notifyListeners();
  }

//clear all the text fields value

  clear() {
    emailSignInTextEditingController.clear();
    passwordSignInTextEditingController.clear();
  }

  //update notifer
  update() {
    notifyListeners();
  }

  Future<void> checkVerificationStatus(context) async {
    String status = await HiveService.checkVerificationStatus();
    if (kDebugMode) {
      print('Checking Status ======== > $status');
    }
    if (status == "verified") {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ScreenRoutes.todoListScreen,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, ScreenRoutes.loginScreen, (route) => false);
    }
  }

  // Sign in User API
  signInUser(context) async {
    FocusManager.instance.primaryFocus!.unfocus();
    setLoading(true);
    notifyListeners();
    dynamic data = {
      'email': emailSignInTextEditingController.text,
      'password': passwordSignInTextEditingController.text,
    };
    // print(data);
    try {
      await repo
          .authApi(data: data, url: AppUrl.authBaseUrl, context: context)
          .then((value) async {
        setLoading(false);
        if (value.status == true) {
          await HiveService.saveUserInfo(value).then((value) {
            checkVerificationStatus(context);
          });
          clear();
        } else {
          showToast(message: value.message);
        }
      });
    } catch (error) {
      setLoading(false);
      // if (kDebugMode) {
      //   showToast(message: 'Server Error ');

      //   print(error.toString());
      // }
    }
  }
}
