import '../utils/imports.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.obscureText,
    this.textInputType,
    this.textInputAction,
    this.isBorder = true,
    this.height,
    this.width,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.borderColor = AppColors.greyColor,
    this.hintColor = AppColors.blackColor,
    this.isPassword = false,
    this.onSuffixIconTap,
    this.radius = 15,
    this.fillColor = AppColors.whiteColor,
    this.isVisible = false,
    this.inputFormatter = 50,
    this.iconColor = AppColors.greyColor,
    this.isReadOnly = false,
    this.prefixIcon, // Add the prefixIcon parameter here
    this.sufixIcon, // Add the prefixIcon parameter here
    this.textCapitalization =
        TextCapitalization.none, // Add textCapitalization property
    this.onTap,
  });
  TextEditingController controller;
  String? hintText;
  bool? obscureText;
  TextInputType? textInputType;
  TextInputAction? textInputAction;
  bool isBorder;
  double? height;
  double? width;
  bool isVisible;
  Color iconColor;
  bool isReadOnly;
  Color borderColor;
  Color hintColor;
  bool isPassword;
  double radius;
  Color fillColor;
  int inputFormatter;
  IconData? prefixIcon; // Declare the prefixIcon variable
  IconData? sufixIcon; // Declare the prefixIcon variable
  TextCapitalization textCapitalization;
  VoidCallback? onSuffixIconTap;
  VoidCallback? onTap;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
          readOnly: isReadOnly,
          autofocus: false,
          cursorColor: AppColors.primaryColor,
          controller: controller,
          autovalidateMode: controller.text.isNotEmpty
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          style:
              MyTextStyles.medium(fontSize: 14.sp, color: AppColors.blackColor),
          obscureText: obscureText ?? false,
          keyboardType: textInputType,
          validator: validator,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          textInputAction: textInputAction,
          onTap: onTap,
          inputFormatters: [LengthLimitingTextInputFormatter(inputFormatter)],
          decoration: InputDecoration(
            errorStyle: MyTextStyles.regular(
                fontSize: 14.sp, color: AppColors.redColor),
            errorMaxLines: 2,
            fillColor: fillColor,
            filled: isBorder == true ? true : false,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            hintStyle: MyTextStyles.regular(fontSize: 14.sp, color: hintColor),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon,
                    color: iconColor, size: 20.w) // Use the prefixIcon here
                : null,
            suffixIcon: isPassword
                ? InkWell(
                    onTap: onSuffixIconTap,
                    child: Icon(
                      isVisible ? Icons.visibility : Icons.visibility_off,
                      color: iconColor,
                      size: 20.w,
                    ),
                  )
                : sufixIcon != null
                    ? InkWell(
                        onTap:
                            onSuffixIconTap, // Assuming you want the tap feature for other icons as well
                        child: Icon(
                          sufixIcon,
                          color: iconColor,
                          size: 20.w,
                        ),
                      )
                    : null,

            // Content padding is the inside padding of the text field
            contentPadding: isBorder == true
                ? EdgeInsets.symmetric(vertical: 10.h, horizontal: 20)
                : null,

            border: isBorder == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(color: borderColor, width: 1),
                  )
                : InputBorder.none,

            errorBorder: isBorder == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide:
                        const BorderSide(color: AppColors.greyColor, width: 1),
                  )
                : InputBorder.none,

            focusedErrorBorder: isBorder == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide:
                        const BorderSide(color: AppColors.redColor, width: 1.2),
                  )
                : InputBorder.none,

            enabledBorder: isBorder == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide: BorderSide(color: borderColor, width: 1),
                  )
                : InputBorder.none,

            focusedBorder: isBorder == true
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(radius),
                    borderSide:
                        const BorderSide(color: AppColors.greyColor, width: 1),
                  )
                : InputBorder.none,
          )),
    );
  }
}
