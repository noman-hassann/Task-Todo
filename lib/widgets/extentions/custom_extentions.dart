import 'package:scanguard/utils/imports.dart';

extension IntExtension on int {
  SizedBox get heightBox => SizedBox(height: toDouble());
  SizedBox get widthBox => SizedBox(width: toDouble());
}

extension StringExtension on String? {
  Widget toText({
    textStyle,
    int maxLine = 2,
    TextAlign textAlign = TextAlign.start,
  }) =>
      Text(this ?? '',
          maxLines: maxLine,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
          style: textStyle);
}

extension WidgetExtension on Widget {
  // OnPress
  Widget onPress(VoidCallback onTap) => InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        child: this,
      );

  // CENTER
  Widget get center => Center(
        child: this,
      );

  // EXPANDED
  Widget get expanded => Expanded(
        child: this,
      );

  //ALIGN
  Widget align(Alignment alignment) => Align(alignment: alignment, child: this);

  // SINGLE PADDING
  Widget paddingOnly(
          {double top = 0,
          double bottom = 0,
          double left = 0,
          double right = 0}) =>
      Padding(
        padding: EdgeInsets.only(
          top: top,
          bottom: bottom,
          left: left,
          right: right,
        ),
        child: this,
      );

  // ALL PADDING
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  // SYMMETRIC PADDING
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  //POSITIONED
  Widget positioned(
          {double top = 0,
          double bottom = 0,
          double left = 0,
          double right = 0}) =>
      Positioned(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        child: this,
      );
}

extension ContainerExtensions on BuildContext {
  Container customContainer({
    double? width,
    double? height,
    Color? borderColor,
    double? borderRadius,
    Color? containerColor,
    double? boderWidth,
    final bool? isSelected = false,
    required Widget child,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: containerColor ?? AppColors.whiteColor,
        border: Border.all(
          color: isSelected == true
              ? AppColors.primaryColor
              : borderColor ?? AppColors.whiteColor,
          width: boderWidth ?? 0.8,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 4),
      ),
      child: child,
    );
  }
}
