import '../utils/imports.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final bool isLoading;
  final double borderRadiusCircular;
  final double borderSideWidth;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? borderColor;

  const GradientButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isLoading = false,
    required this.borderRadiusCircular,
    required this.borderSideWidth,
    required this.textStyle,
    required this.width,
    required this.height,
    this.gradient,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          color: gradient == null ? backgroundColor : null,
          borderRadius: BorderRadius.circular(borderRadiusCircular),
          border: Border.all(
            width: borderSideWidth,
            color: borderColor ?? Colors.transparent,
          ),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                title,
                style: textStyle,
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomButonIcon extends StatelessWidget {
  CustomButonIcon({
    super.key,
    required this.onPressed,
    required this.title,
    required this.borderRadiusCircular,
    required this.borderSideWidth,
    required this.textStyle,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.iconImage,
    required this.borderColor,
    this.isLoading = false, // Default value is set to false, i.e., not loading.
  });

  double width;
  double height, borderRadiusCircular, borderSideWidth;
  Color backgroundColor;
  Color borderColor;
  String title;
  bool isLoading;
  TextStyle textStyle;
  final VoidCallback onPressed;
  String iconImage;

  @override
  Widget build(BuildContext context) {
    return context
        .customContainer(
            borderColor: borderColor,
            containerColor: backgroundColor,
            boderWidth: borderSideWidth,
            borderRadius: borderRadiusCircular,
            height: height,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconImage != '' ? Image.asset(iconImage) : Container(),
                SizedBox(
                  width: 10.w,
                ),
                isLoading
                    ? showLoader()
                    : Text(
                        title,
                        style: textStyle,
                      ),
              ],
            ))
        .onPress(onPressed);
  }
}
