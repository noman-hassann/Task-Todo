import 'package:scanguard/utils/imports.dart';

class AppTextField extends StatelessWidget {
  final TextAlign textAlign;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Color? cursorColor;
  final Brightness keyboardAppearance;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final bool autocorrect;
  final String? hintText;
  final Widget? prefixButton;
  final Widget? suffixButton;
  final bool? fadePrefixOnCondition;
  final bool? prefixShowFirstCondition;
  final bool? fadeSuffixOnCondition;
  final bool? suffixShowFirstCondition;
  final EdgeInsetsGeometry padding;
  final Widget? overrideTextFieldWidget;
  final int buttonFadeDurationMs;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final double topMargin;
  final double? leftMargin;
  final double? rightMargin;
  final TextStyle? style;
  final bool obscureText;
  final bool autofocus;
  final bool enableInteractiveSelection;

  const AppTextField({
    super.key,
    this.textAlign = TextAlign.center,
    this.focusNode,
    this.controller,
    this.cursorColor,
    this.keyboardAppearance = Brightness.dark,
    this.inputFormatters,
    this.textInputAction,
    this.textCapitalization,
    this.maxLines = 1,
    this.autocorrect = true,
    this.hintText,
    this.prefixButton,
    this.suffixButton,
    this.fadePrefixOnCondition,
    this.prefixShowFirstCondition,
    this.fadeSuffixOnCondition,
    this.suffixShowFirstCondition,
    this.padding = EdgeInsets.zero,
    this.overrideTextFieldWidget,
    this.buttonFadeDurationMs = 100,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
    this.topMargin = 0,
    this.leftMargin,
    this.rightMargin,
    this.style,
    this.obscureText = false,
    this.autofocus = false,
    this.enableInteractiveSelection = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: leftMargin ?? MediaQuery.of(context).size.width * 0.105,
        right: rightMargin ?? MediaQuery.of(context).size.width * 0.105,
        top: topMargin,
      ),
      padding: padding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: overrideTextFieldWidget ??
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              TextField(
                enableInteractiveSelection: enableInteractiveSelection,
                textAlign: textAlign,
                keyboardAppearance: keyboardAppearance,
                autocorrect: autocorrect,
                maxLines: maxLines,
                focusNode: focusNode,
                controller: controller,
                cursorColor: cursorColor ?? AppColors.primaryColor,
                inputFormatters: inputFormatters,
                textInputAction: textInputAction,
                textCapitalization:
                    textCapitalization ?? TextCapitalization.none,
                keyboardType: keyboardType,
                obscureText: obscureText,
                autofocus: autofocus,
                onSubmitted: onSubmitted ??
                    (text) {
                      if (textInputAction == TextInputAction.done) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                onChanged: onChanged,
                style: style,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: MyTextStyles.medium(color: AppColors.blackColor),
                  prefixIcon: prefixButton == null
                      ? const SizedBox()
                      : const SizedBox(width: 48),
                  suffixIcon: suffixButton == null
                      ? const SizedBox()
                      : const SizedBox(width: 48),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  fadePrefixOnCondition != null && prefixButton != null
                      ? AnimatedCrossFade(
                          duration: Duration(
                            milliseconds: buttonFadeDurationMs,
                          ),
                          firstChild: prefixButton!,
                          secondChild: const SizedBox(width: 48),
                          crossFadeState: prefixShowFirstCondition!
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        )
                      : prefixButton ?? const SizedBox(),
                  fadeSuffixOnCondition != null && suffixButton != null
                      ? AnimatedCrossFade(
                          duration:
                              Duration(milliseconds: buttonFadeDurationMs),
                          firstChild: suffixButton!,
                          secondChild: const SizedBox(width: 48),
                          crossFadeState: suffixShowFirstCondition!
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                        )
                      : suffixButton ?? const SizedBox(),
                ],
              ),
            ],
          ),
    );
  }
}
