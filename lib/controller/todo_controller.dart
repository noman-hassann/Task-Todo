import 'package:connectivity/connectivity.dart';
import 'package:scanguard/utils/imports.dart';
import 'package:scanguard/utils/local_db.dart';
import 'package:uuid/uuid.dart';

class TodoController extends ChangeNotifier {
  final ApiRepository repo = ApiRepository();

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  List<Items>? items;
  var uuid = const Uuid(); // Create an instance of Uuid

  bool _authloading = false;
  bool get authloading => _authloading;

  void setLoading(bool value) {
    _authloading = value;
    notifyListeners();
  }

  void clear() {
    titleEditingController.clear();
    descriptionTextEditingController.clear();
  }

  void update() {
    notifyListeners();
  }

  Future<void> saveTodoLocally(Items item) async {
    await LocalDatabase.instance.addTask(item);
  }

  Future<void> createTodoTask(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    Map<String, dynamic> data = {
      "title": titleEditingController.text,
      "description": descriptionTextEditingController.text,
      "is_completed": false,
    };

    // Create an item locally
    Items newItem = Items(
      sId: uuid.v4(), // Generate a unique ID
      title: titleEditingController.text,
      description: descriptionTextEditingController.text,
      isCompleted: false,
      isSynced: false, // Set to false when created locally
    );
    print('Sid s${newItem.sId}');
    // Save locally
    await saveTodoLocally(newItem);

    // Attempt to sync with the server
    if (await isOnline()) {
      setLoading(true);
      try {
        var response = await repo.createTodoApi(
            data: data, url: AppUrl.baseUrl, context: context);
        if (response.success!) {
          newItem.isSynced = true; // Update to true if successful
          await LocalDatabase.instance
              .updateTask(newItem); // Update local status
          showToast(message: "Task Added Successfully");
          await readTodoTask(context);
          Navigator.pop(context);
        }
      } catch (error) {
        // Handle errors
        showToast(message: 'Failed to sync with server');
      } finally {
        setLoading(false);
      }
    } else {
      // If offline, notify the user
      showToast(message: "Task saved locally");
      readTodoTask(context);
      Navigator.pop(context);
    }
  }

  Future<void> readTodoTask(context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    setLoading(true);
    notifyListeners();

    try {
      if (await isOnline()) {
        // Attempt to fetch data from server
        var response = await repo.readTodoApi(
            url: '${AppUrl.baseUrl}?page=1&limit=20', context: context);
        if (response.success == true) {
          items = response.items;
        } else {
          items = await LocalDatabase.instance
              .fetchTasks(); // Fetch from local DB if API fails
        }
      } else {
        // Load local tasks if offline
        items = await LocalDatabase.instance.fetchTasks();
        showToast(message: 'Loading local tasks.');
      }
    } catch (error) {
      items = await LocalDatabase.instance.fetchTasks(); // Fallback to local
      showToast(message: 'Server Error, loading local tasks.');
    } finally {
      setLoading(false);
    }
  }

  Future<void> updateTodoTask({context, required String id}) async {
    // Dismiss the keyboard
    FocusManager.instance.primaryFocus?.unfocus();

    // Prepare data for the update
    Map<String, dynamic> data = {
      "title": titleEditingController.text,
      "description": descriptionTextEditingController.text,
      "is_completed": false,
    };

    // Retrieve the item locally to update its status
    Items updatedItem = items!.firstWhere((item) => item.sId == id);

    // Update the local item before sending the request
    updatedItem.title = data['title'];
    updatedItem.description = data['description'];
    updatedItem.isCompleted = data['is_completed'];
    updatedItem.isSynced = false; // Mark as not synced initially

    if (await isOnline()) {
      setLoading(true);
      try {
        // Attempt to update the server
        var response = await repo.updateTodoApi(
            data: data, url: '${AppUrl.baseUrl}/$id', context: context);

        if (response.success!) {
          // If the server update was successful, mark as synced locally
          updatedItem.isSynced = true; // Set to true if update was successful
        } else {
          showToast(message: 'Failed to update task on server.');
        }

        // Update the local database with the potentially new synced status
        await LocalDatabase.instance.updateTask(updatedItem); // Update local DB

        // Refresh the task list
        await readTodoTask(context);
        Navigator.pop(context);
      } catch (error) {
        showToast(message: 'Failed to update task on server.');
      } finally {
        setLoading(false);
      }
    } else {
      // If offline, update the local database only
      await LocalDatabase.instance.updateTask(updatedItem); // Update local DB
      await readTodoTask(context);
      showToast(message: 'Task updated locally ');
      Navigator.pop(context);
    }
  }

  Future<void> deleteTodoTask({context, required String id}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    // Debugging: Log the ID before deletion
    logger.f("Attempting to delete task with ID: $id");

    if (await isOnline()) {
      setLoading(true);
      notifyListeners(); // Notify listeners that loading has started
      try {
        var response = await repo.deleteTodoApi(
            url: "${AppUrl.baseUrl}/$id", context: context);
        if (response.success == true) {
          // Delete locally
          await LocalDatabase.instance.deleteTask(id);
          // Refresh tasks after deletion
          await readTodoTask(context);
          notifyListeners(); // Notify listeners to update the UI
        }
      } catch (error) {
        print("Error during deletion: $error"); // Debugging
        showToast(message: 'Failed to delete task');
      } finally {
        setLoading(false);
      }
    } else {
      // Handle local deletion without syncing
      await LocalDatabase.instance.deleteTask(id);
      // Refresh tasks after local deletion
      await readTodoTask(context);
      logAllTasks();
      notifyListeners(); // Notify listeners to update the UI
      showToast(message: 'Task deleted locally.');
    }
  }

  Future<void> markAsCompletedTask({context, required Items todoItem}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    // Prepare data for updating
    Map<String, dynamic> data = {
      "title": todoItem.title,
      "description": todoItem.description,
      "is_completed": true,
    };

    if (await isOnline()) {
      setLoading(true);
      try {
        // Update the server with the completed task status
        await repo.updateTodoApi(
          data: data,
          url:
              '${AppUrl.baseUrl}/${todoItem.sId}', // Ensure using the correct ID
          context: context,
        );

        // Update local task status to completed
        todoItem.isCompleted = true;
        await LocalDatabase.instance.updateTask(todoItem); // Update in local DB

        await readTodoTask(context); // Refresh task list
        showToast(message: 'Task marked as completed on the server.');
      } catch (error) {
        showToast(message: 'Failed to mark task as completed on server.');
      } finally {
        setLoading(false);
      }
    } else {
      // Offline handling
      todoItem.isCompleted = true; // Mark as completed locally
      await LocalDatabase.instance.updateTask(todoItem); // Update local DB
      await readTodoTask(context); // Refresh task list
      showToast(message: 'Task marked as completed locally');
    }
  }

  Future<bool> isOnline() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> syncLocalTasks() async {
    if (await isOnline()) {
      List<Items> localTasks = await LocalDatabase.instance.fetchTasks();
      for (var task in localTasks) {
        if (!task.isSynced!) {
          // Send unsynced tasks to server
          try {
            var response = await repo.createTodoApi(
                data: task.toJson(), url: AppUrl.baseUrl, context: null);
            if (response.success == true) {
              // Mark task as synced
              await LocalDatabase.instance
                  .updateTask(task.copyWith(isSynced: true));
            }
          } catch (e) {
            print('Error syncing task: $e');
          }
        }
      }
    }
  }

  Future<void> logAllTasks() async {
    final tasks = await LocalDatabase.instance.fetchTasks();
    for (var task in tasks) {
      print("Task ID: ${task.sId}, Title: ${task.title}");
    }
  }
}
