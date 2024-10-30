import 'package:scanguard/utils/imports.dart';
import 'package:scanguard/widgets/primary_buttton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> authInForm = GlobalKey<FormState>();
  bool isChecked = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FilterAppBar(
        onTapLeading: () {
          Navigator.pop(context);
        },
        height: 30.h,
        title: "Login",
        subTitle: '\t\t\t\t\t\t\t',
        appBarColor: AppColors.blackColor,
        style:
            MyTextStyles.medium(color: AppColors.whiteColor, fontSize: 20.sp),
        isLeading: false,
        isTralingIcon: false,
        autoImplementing: false,
        trailingCheck: false,
      ),
      backgroundColor: AppColors.blackColor,
      body: Consumer<AuthController>(builder: (context, controller, child) {
        return SingleChildScrollView(
          child: Form(
              key: authInForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.heightBox,
                      Image.asset(
                        AppImages.appLogo,
                        height: 100,
                        width: 100,
                      ).center,
                      30.heightBox,
                      "Email".toText(
                          textStyle: MyTextStyles.medium(
                              fontSize: 14.sp, color: AppColors.whiteColor)),
                      8.heightBox,
                      CustomTextField(
                        controller: controller.emailSignInTextEditingController,
                        // height: 50.h,
                        fillColor: AppColors.whiteColor,
                        borderColor: AppColors.blackColor,
                        isBorder: true,
                        hintText: 'john@gmail.com',
                        radius: 10,
                        validator: (value) {
                          return Validation.emailValidation(value);
                        },
                      ),
                      8.heightBox,
                      "Password".toText(
                          textStyle: MyTextStyles.medium(
                              fontSize: 14.sp, color: AppColors.whiteColor)),
                      8.heightBox,
                      CustomTextField(
                        controller:
                            controller.passwordSignInTextEditingController,
                        // height: 50.h,
                        fillColor: AppColors.whiteColor,
                        borderColor: AppColors.blackColor,
                        hintText: '*********',
                        isVisible: controller.isVisible,
                        obscureText: controller.isVisible,
                        radius: 10,
                        isPassword: true,
                        onSuffixIconTap: () {
                          controller.passwordVisibility();
                        },
                        validator: (value) {
                          return Validation.passwordValidation(value);
                        },
                      ),
                      32.heightBox,
                      GradientButton(
                        onPressed: () {
                          if (authInForm.currentState!.validate()) {
                            controller.signInUser(context);
                          }
                        },
                        title: "Login",
                        isLoading: controller.authloading,
                        borderRadiusCircular: 10.sp,
                        borderSideWidth: 0.1,
                        textStyle: MyTextStyles.semiBold(
                            fontSize: 13.sp, color: AppColors.whiteColor),
                        width: double.infinity,
                        height: 40.h,
                        backgroundColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                      ),
                      16.heightBox,
                      GradientButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            ScreenRoutes.todoListScreen,
                            (Route<dynamic> route) =>
                                false, // Predicate to remove all routes
                          );
                        },
                        title: "Skip",
                        isLoading: false,
                        borderRadiusCircular: 10.sp,
                        borderSideWidth: 0.1,
                        textStyle: MyTextStyles.semiBold(
                            fontSize: 13.sp, color: AppColors.whiteColor),
                        width: double.infinity,
                        height: 40.h,
                        backgroundColor: AppColors.primaryColor,
                        borderColor: AppColors.primaryColor,
                      ),
                      32.heightBox,
                      "( Email => hassan@gmail.com)"
                          .toText(
                              textAlign: TextAlign.center,
                              textStyle: MyTextStyles.medium(
                                  fontSize: 15, color: AppColors.whiteColor))
                          .center,
                      5.heightBox,
                      "( Password => 12345678)"
                          .toText(
                              textAlign: TextAlign.center,
                              textStyle: MyTextStyles.medium(
                                  fontSize: 15, color: AppColors.whiteColor))
                          .center
                    ],
                  ).paddingSymmetric(horizontal: 26.w),
                ],
              )),
        );
      }),
    );
  }
}
