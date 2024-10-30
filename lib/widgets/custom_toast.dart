import '../utils/imports.dart';

showToast({@required String? message}) {
  Fluttertoast.showToast(
      msg: message!,
      timeInSecForIosWeb: 3,
      fontSize: 16,
      textColor: AppColors.whiteColor,
      backgroundColor: AppColors.primaryColor);
}
