import 'imports.dart';

showLoader({double? size, Color? color}) {
  return Center(
    child: LoadingAnimationWidget.beat(
        color: color ?? AppColors.primaryColor, size: size ?? 30),
  );
}

// showAnimationLoader({double? size, Color? color}) {
//   return Center(
//     child: Lottie.asset(AppImages.splashAnimation),
//   );
// }
