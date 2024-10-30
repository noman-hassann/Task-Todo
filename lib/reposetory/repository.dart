import 'package:scanguard/models/auth_model.dart';
import 'package:scanguard/utils/imports.dart';

class ApiRepository {
  final NetworkApiService _apiService = NetworkApiService();
  final ConnectivityService _connectivityService = ConnectivityService();

//Auth Api implementation
  Future<AuthModel> authApi(
      {dynamic data, url, token, required context}) async {
    try {
      if (!(await _connectivityService.checkConnectivity(context))) {
        return Future.error('No Internet Connection');
      }

      dynamic response = await _apiService.postApiResponse(
        url,
        data,
      );
      if (kDebugMode) {
        print(response);
      }
      return AuthModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  ///Todos Api Implementation
  Future<TodoModel> createTodoApi({dynamic data, url, required context}) async {
    try {
      if (!(await _connectivityService.checkConnectivity(context))) {
        return Future.error('No Internet Connection');
      }

      dynamic response = await _apiService.postApiResponse(
        url,
        data,
      );
      if (kDebugMode) {
        print(response);
      }
      return TodoModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AllTodoModel> readTodoApi(
      {dynamic data, url, required context}) async {
    try {
      if (!(await _connectivityService.checkConnectivity(context))) {
        return Future.error('No Internet Connection');
      }

      dynamic response = await _apiService.getApiResponse(
        url,
      );
      if (kDebugMode) {
        print(response);
      }
      return AllTodoModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<TodoModel> updateTodoApi({dynamic data, url, required context}) async {
    try {
      if (!(await _connectivityService.checkConnectivity(context))) {
        return Future.error('No Internet Connection');
      }

      dynamic response = await _apiService.putApiResponse(
        url,
        data,
      );
      if (kDebugMode) {
        print(response);
      }
      return TodoModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<TodoModel> deleteTodoApi({url, required context}) async {
    try {
      if (!(await _connectivityService.checkConnectivity(context))) {
        return Future.error('No Internet Connection');
      }

      dynamic response = await _apiService.deleteApiResponse(
        url,
      );
      if (kDebugMode) {
        print(response);
      }
      return TodoModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
