import 'package:scanguard/utils/imports.dart';

class CreateTodoScreen extends StatelessWidget {
  final Items? todoItem; // Add this to receive the item for editing

  CreateTodoScreen({super.key, this.todoItem}); // Add todoItem to constructor

  final GlobalKey<FormState> validateFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: FilterAppBar(
        onTapLeading: () {
          Navigator.pop(context);
        },
        height: 40.h,
        title: todoItem == null
            ? "Create Task"
            : "Edit Task", // Change title based on mode
        subTitle: "",
        appBarColor: AppColors.blackColor,
        style:
            MyTextStyles.regular(color: AppColors.whiteColor, fontSize: 20.sp),
        isLeading: true,
        leadingIcon: const Icon(
          Icons.arrow_back,
          color: AppColors.whiteColor,
        ),
        trailingCheck: true,
      ),
      body: Consumer<TodoController>(builder: (context, controller, _) {
        // Populate fields with data if editing
        if (todoItem != null) {
          controller.titleEditingController.text = todoItem!.title ?? '';
          controller.descriptionTextEditingController.text =
              todoItem!.description ?? '';
        } else {
          controller.clear();
        }

        return Form(
          key: validateFormKey,
          child: Column(
            children: [
              CustomTextField(
                controller: controller.titleEditingController,
                fillColor: AppColors.cardLight,
                borderColor: AppColors.primaryColor,
                isBorder: true,
                hintText: 'Enter Task',
                radius: 10,
                validator: (value) => Validation.emptuValidation(value),
              ),
              20.heightBox,
              CustomTextField(
                controller: controller.descriptionTextEditingController,
                fillColor: AppColors.cardLight,
                borderColor: AppColors.primaryColor,
                isBorder: true,
                hintText: 'Enter Detail',
                radius: 10,
                validator: (value) => Validation.emptuValidation(value),
              ),
              40.heightBox,
              BtnPrimeryBackground(
                onPressed: () {
                  if (validateFormKey.currentState!.validate()) {
                    if (todoItem == null) {
                      // Create new task if no item is provided
                      controller.createTodoTask(context);
                    } else {
                      // Update the existing task
                      controller.updateTodoTask(
                          context: context, id: todoItem!.sId.toString());
                    }
                  }
                },
                title: todoItem == null
                    ? "Create Task"
                    : "Update Task", // Change button text
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
            ],
          ).paddingSymmetric(horizontal: 20.w, vertical: 40.h),
        );
      }),
    );
  }
}
