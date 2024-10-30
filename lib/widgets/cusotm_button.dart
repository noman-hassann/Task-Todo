import 'package:scanguard/utils/imports.dart';

// ignore: must_be_immutable
class BtnPrimeryBackground extends StatelessWidget {
  BtnPrimeryBackground({
    super.key,
    required this.onPressed,
    required this.title,
    required this.borderRadiusCircular,
    required this.borderSideWidth,
    required this.textStyle,
    required this.width,
    required this.height,
    required this.backgroundColor,
    this.isIcon = false,
    required this.borderColor,
    this.isLoading = false, // Default value is set to false, i.e., not loading.
  });

  double width;
  double height, borderRadiusCircular, borderSideWidth;
  Color backgroundColor;
  Color borderColor;
  bool isIcon;
  String title;
  TextStyle textStyle;
  final VoidCallback onPressed;
  bool isLoading; // New parameter to indicate loading status

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:
            isLoading ? null : onPressed, // Disable button if loading is true
        style: ElevatedButton.styleFrom(
          minimumSize: Size(width, height),
          side: BorderSide(
            color: borderColor,
            width: borderSideWidth,
            style: BorderStyle.solid,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusCircular),
          ),
          backgroundColor: backgroundColor,
        ),
        child: isLoading
            ? showLoader()
            : Text(
                title,
                style: textStyle,
              ));
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
