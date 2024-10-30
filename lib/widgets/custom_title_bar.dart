import 'package:flutter/cupertino.dart';
import 'package:scanguard/utils/imports.dart';

// ignore: must_be_immutable
class CustomTitleAppbar extends StatelessWidget implements PreferredSizeWidget {
  CustomTitleAppbar({
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
    this.trailingIcon,
    this.isDrawer = false,
    this.leadingAssetIconPath,
    this.trailingAssetIconPath,
  });

  final double height;
  final Widget title;
  final String? subTitle;
  bool? autoImplementing;
  final Icon? leadingIcon;
  final Icon? trailingIcon;
  final String? leadingAssetIconPath;
  final String? trailingAssetIconPath;
  Alignment? alignment;
  TextStyle? style;
  bool isLeading;
  bool isDrawer;
  Color? appBarColor;

  bool trailingCheck;
  bool isTralingIcon;
  final VoidCallback? onTapTrailing;
  final VoidCallback? onTapLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white, // Set the icon color to black
      ),
      backgroundColor: appBarColor ?? AppColors.whiteColor,
      automaticallyImplyLeading: autoImplementing ?? true,
      scrolledUnderElevation: 0.0,
      leading: isLeading // Show drawer icon if enabled
          ? IconButton(
              icon: isDrawer
                  ? leadingAssetIconPath != null
                      ? Image.asset(leadingAssetIconPath!)
                      : const Icon(
                          Icons.menu,
                          color: AppColors.whiteColor,
                        )
                  : leadingIcon ??
                      const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteColor,
                      ), // Use any icon you want
              onPressed: isDrawer
                  ? () => Scaffold.of(context).openDrawer()
                  : onTapLeading, // Callback for drawer icon tap
            )
          : null,
      title: title,
      actions: [
        if (trailingCheck)
          GestureDetector(
            onTap: onTapTrailing,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: isTralingIcon
                    ? trailingAssetIconPath != null
                        ? Image.asset(trailingAssetIconPath!)
                        : trailingIcon ??
                            const Icon(
                              CupertinoIcons.bell,
                              color: AppColors.blackColor,
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
