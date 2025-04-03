import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:warshati/src/core/utils/constants/constants.dart';
import 'package:warshati/src/core/utils/constants/messages/app_messages.dart';
import 'package:warshati/src/core/utils/constants/messages/general_messages.dart';
import 'package:warshati/src/infrastructure/api/endpoint/base_urls.dart';
import 'package:warshati/src/infrastructure/api/response/api_response.dart';
import 'package:warshati/src/infrastructure/storage/local_storage.dart';
import 'package:warshati/src/logger/log_services/dev_logger.dart';

class RemoteInterceptor extends Interceptor {
  RemoteInterceptor(this.storageProvider);
  final LocalStorage storageProvider;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // super.onRequest(options, handler);
    final dioOption = options.copyWith(
      baseUrl: BaseUrls.baseUrl,
    );
    final headers = <String, String>{
      'Accept': 'application/json',
      // 'Content-Type':
      //     'application/json', // Ensure this is set to 'application/json'
    };
    final customOptions = dioOption;
    customOptions.headers = headers;
    final token =
        await storageProvider.getSecuredString(StorageKeys.securedToken);
    // interceptorLog(
    //     'REQUEST STARTED WITH BASE URL : ${customOptions.baseUrl}');
    Dev.logLine('REQUEST STARTED WITH TOKEN : $token');
    // customOptions.headers['Authorization'] = 'Bearer $token';
    customOptions.headers['Authorization'] = 'Bearer $token';
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    // interceptorLog(
    //     'REQUEST CONNECTIVITY : ${connectivityResult.first.name}');
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return handler.resolve(
        Response(
          requestOptions: customOptions,
          data: _handleErrorResponse(null).toJson(),
        ),
      );
    } else {
      return handler.next(customOptions);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      // Handle Map<String, dynamic> responses
      if (response.data is Map<String, dynamic>) {
        // Resolve the response with the wrapped ApiResponse
        return handler.resolve(
          Response(
            data: response.data,
            requestOptions: response.requestOptions,
          ),
        );
      }
      // If the response data is not a Map, pass it as is
      return handler.next(response);
    } catch (e) {
      // Enhanced error logging
      // Dev.logError('Dio Error: $e');
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          error: 'Failed to process response: $e',
          type: DioExceptionType.badResponse,
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return handler.resolve(
      Response(
        requestOptions: err.requestOptions,
        data: _handleErrorResponse(err.response, path: err.requestOptions.path)
            .toJson(),
      ),
    );
  }

  static ApiResponse _handleErrorResponse(Response? response, {String? path}) {
    if (response == null) {
      return ApiResponse.error(
        message: GeneralMessages().noInternetMessage,
        error: null,
      );
    }
    switch (response.statusCode) {
      case 401:
        return ApiResponse.error(
          message: GeneralMessages().unauthorizedMessage,
        );
      case 500:
        ApiResponse res = ApiResponse.error(
          message: GeneralMessages().internalServerErrorMessage,
          error: response.data,
        );
        AppMessages.showError(message: res.message!);
        return res;
      default:
        Dev.logLineWithTagError(
          tag: '[DIO EXCEPTION]',
          message: 'Converting wrong',
          error: response.data,
        );
        return ApiResponse.error(
          error: response.data,
          message: 'Convertting error',
        );
    }
  }
}
