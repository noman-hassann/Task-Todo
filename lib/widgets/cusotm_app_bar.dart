import 'package:scanguard/utils/imports.dart';

class FilterAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FilterAppBar({
    super.key,
    required this.height,
    required this.title,
    this.subTitle,
    this.isTralingIcon = false,
    this.alignment,
    this.onTapLeading,
    this.onTapTrailing,
    this.appBarColor,
    this.style,
    this.isLeading = false,
    this.trailingCheck = false,
    this.autoImplementing,
    this.leadingIcon,
  });

  final double height;
  final String title;
  final String? subTitle;
  final bool? autoImplementing;
  final Icon? leadingIcon;
  final Alignment? alignment;
  final TextStyle? style;
  final bool isLeading;
  final Color? appBarColor;

  final bool trailingCheck;
  final bool isTralingIcon;
  final VoidCallback? onTapTrailing;
  final VoidCallback? onTapLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black, // Set the icon color to black
      ),
      backgroundColor: appBarColor ?? AppColors.whiteColor,
      automaticallyImplyLeading: autoImplementing ?? true,
      scrolledUnderElevation: 0.0,
      leading: isLeading // Show drawer icon if enabled
          ? IconButton(
              icon: leadingIcon ??
                  const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.blackColor,
                  ), // Use any icon you want
              onPressed: onTapLeading, // Callback for drawer icon tap
            )
          : null,
      title: Align(
          alignment: alignment ?? Alignment.center,
          child: Text(title,
              style: style ??
                  MyTextStyles.semiBold(
                      fontSize: 24.sp, color: AppColors.primaryColor))),
      actions: [
        if (trailingCheck)
          GestureDetector(
            onTap: onTapTrailing,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: isTralingIcon
                    ? const Icon(
                        Icons.logout,
                        color: AppColors.whiteColor,
                        size: 29,
                      )
                    : Text(
                        '$subTitle',
                        style: MyTextStyles.regular(fontSize: 14.sp),
                      ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
