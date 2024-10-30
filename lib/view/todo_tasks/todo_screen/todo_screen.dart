import 'package:scanguard/utils/imports.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        TodoController todoController =
            Provider.of<TodoController>(context, listen: false);

        todoController.readTodoTask(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: FilterAppBar(
        onTapLeading: () {
          // Navigator.pop(context);
        },
        isTralingIcon: true,
        onTapTrailing: () {
          logoutAndNavigateToSplash(context);
        },
        height: 30.h,
        title: "Todo List",
        subTitle: "",
        appBarColor: AppColors.blackColor,
        style:
            MyTextStyles.regular(color: AppColors.whiteColor, fontSize: 20.sp),
        isLeading: false,
        trailingCheck: true,
      ),
      body: Consumer<TodoController>(builder: (context, controller, _) {
        return controller.authloading
            ? showLoader()
            : controller.items == null
                ? "No Todo List Added yet"
                    .toText(
                        textStyle:
                            MyTextStyles.medium(color: AppColors.whiteColor))
                    .center
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.items!.length,
                    itemBuilder: (context, index) {
                      final task = controller.items![index];
                      return Card(
                        color: AppColors.whiteColor,
                        child: ListTile(
                          title: Text(task.title.toString(),
                              style: MyTextStyles.bold(fontSize: 16)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.description.toString(),
                                style: MyTextStyles.regular(fontSize: 15),
                              ),
                              Text(
                                task.isCompleted == true
                                    ? 'Status: Completed'
                                    : 'Status: Incomplete',
                                style: TextStyle(
                                  color: task.isCompleted == true
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Visibility(
                                visible: task.isCompleted == false,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: AppColors.blackColor,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreateTodoScreen(
                                          todoItem: controller.items![index],
                                        ),
                                      ),
                                    );
                                    // Edit todo functionality
                                  },
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.primaryColor,
                                ),
                                onPressed: () {
                                  controller.deleteTodoTask(
                                      context: context,
                                      id: task.sId.toString());
                                },
                              ),
                              if (task.isCompleted ==
                                  false) // Only show the button if the task is incomplete
                                IconButton(
                                  icon: const Icon(Icons.check,
                                      color: Colors.green),
                                  onPressed: () {
                                    controller.markAsCompletedTask(
                                        context: context, todoItem: task);
                                    // Mark as complete
                                    // controller.markTaskAsCompleted(
                                    //     context, task.sId);
                                  },
                                ),
                            ],
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 20.w, vertical: 3.h);
                    },
                  ).paddingOnly(top: 20.h);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScreenRoutes.createTodoScreen);
        },
        backgroundColor: AppColors.primaryColor,
        child: const Icon(Icons.add, color: AppColors.whiteColor),
      ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
    );
  }

  Future<void> logoutAndNavigateToSplash(BuildContext context) async {
    // Check if the user is logged in
    var user = await HiveService.getUserProfile();
    if (user == null) {
      // User is not logged in, navigate to the splash screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        ScreenRoutes.splashScreen,
        (Route<dynamic> route) => false, // Removes all previous routes
      );
      return;
    }

    // Proceed to sign out
    await HiveService.signOut().then((value) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        ScreenRoutes.splashScreen,
        (Route<dynamic> route) => false, // Removes all previous routes
      );
    });
    // Navigate to the splash screen
  }
}
