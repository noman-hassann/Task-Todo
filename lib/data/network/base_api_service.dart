import 'package:scanguard/utils/imports.dart';

class NetworkApiService extends BaseApiService {
  final Dio dio = Dio();

  // Get API Response
  @override
  Future<dynamic> getApiResponse(
    String url,
  ) async {
    try {
      logger.f("API GET Request: $url");
      final response = await dio
          .get(
            url,
            options: Options(headers: _getHeaders()),
          )
          .timeout(const Duration(seconds: 20));
      logger.e("API GET Responce: $response");

      return _returnResponse(response);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      logger.e("API GET Error: $e");
      _handleDioError(e);
    }
  }

  // Post API Response
  @override
  Future<dynamic> postApiResponse(
    String url,
    dynamic data,
  ) async {
    try {
      logger.e("API POST Request: $url and data :$data");
      final response = await dio
          .post(
            url,
            data: data,
            options: Options(headers: _getHeaders()),
          )
          .timeout(const Duration(seconds: 20));
      logger.e("API POST Responce: $response");

      return _returnResponse(response);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      logger.e("API POST Error: $e");
      _handleDioError(e);
    }
  }

  // Put API Response
  @override
  Future<dynamic> putApiResponse(
    String url,
    dynamic data,
  ) async {
    try {
      logger.e("API Put Request: $url and data :$data");

      final response = await dio
          .put(
            url,
            data: data,
            options: Options(headers: _getHeaders()),
          )
          .timeout(const Duration(seconds: 20));
      logger.e("API Put Responce: $response");
      return _returnResponse(response);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      logger.e("API Put Error: $e");
      _handleDioError(e);
    }
  }

  @override
  Future<dynamic> deleteApiResponse(
    String url,
  ) async {
    try {
      logger.e("API DELETE Request: $url");
      final response = await dio
          .delete(
            url,
            options: Options(headers: _getHeaders()),
          )
          .timeout(const Duration(seconds: 20));
      logger.e("API DELETE Responce: $response");
      return _returnResponse(response);
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      logger.e("API DELETE Error: $e");
      _handleDioError(e);
    }
  }

  // Delete API Response

  // Get headers based on token requirement
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  dynamic _returnResponse(Response response) {
    if (kDebugMode) {
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');
    }

    final Map<String, dynamic> responseData = jsonDecode(response.toString());
    final String? serverMessage = responseData['message'] as String?;

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseData; // Successfully processed response
      case 400:
        showToast(message: serverMessage ?? 'Bad request');
        throw BadRequestException(serverMessage ?? response.toString());
      case 401:
        showToast(message: serverMessage ?? 'Unauthorized');
        throw UnauthorizedException(serverMessage ?? response.toString());
      case 403:
        showToast(message: serverMessage ?? 'Forbidden');
        throw UnauthorizedException(serverMessage ?? response.toString());
      case 404:
        showToast(message: serverMessage ?? 'Resource not found');
        throw UnauthorizedException(serverMessage ?? response.toString());
      case 500:
        showToast(message: serverMessage ?? 'Internal Server Error');
        throw UnauthorizedException(serverMessage ?? response.toString());
      default:
        showToast(message: serverMessage ?? 'Unexpected error');
        throw FetchDataException(serverMessage ??
            'Error occurred with status code: ${response.statusCode}');
    }
  }

  // Handle Dio errors centrally
  void _handleDioError(DioError e) {
    if (e.response != null) {
      final responseData = e.response!.data;
      final String? serverMessage = responseData['message'] as String?;

      showToast(message: serverMessage ?? 'An unexpected error occurred');
      throw FetchDataException(serverMessage ??
          'Unexpected Error. Status Code: ${e.response!.statusCode}.');
    } else {
      // Handle cases where the error is not related to a server response, such as no internet connection
      showToast(
          message:
              'No Internet connection or the server is unreachable. Please check your network.');
      throw FetchDataException('No Internet connection or server is down.');
    }
  }
}
