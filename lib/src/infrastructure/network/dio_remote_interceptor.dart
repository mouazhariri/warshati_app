import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:sham/src/core/utils/constants/constants.dart';
import 'package:sham/src/core/utils/constants/messages/app_messages.dart';
import 'package:sham/src/core/utils/constants/messages/general_messages.dart';
import 'package:sham/src/infrastructure/api/endpoint/base_urls.dart';
import 'package:sham/src/infrastructure/api/response/api_response.dart';
import 'package:sham/src/infrastructure/storage/local_storage.dart';
import 'package:sham/src/logger/log_services/dev_logger.dart';

class RemoteInterceptor extends Interceptor {
  RemoteInterceptor(this.storageProvider);
  final LocalStorage storageProvider;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final locale = storageProvider.userSettings.locale;
    // super.onRequest(options, handler);
    final dioOption = options.copyWith(
      baseUrl: BaseUrls.baseUrl,
    );
    final headers = <String, String>{
      'Accept': 'application/json',
      'Accept-Language': locale,
      // 'Content-Type':
      //     'application/json', // Ensure this is set to 'application/json'
    };
    final customOptions = dioOption;
    // customOptions.headers = headers;
    // final token =
    //     await storageProvider.getSecuredString(StorageKeys.securedToken);
    // interceptorLog(
    //     'REQUEST STARTED WITH BASE URL : ${customOptions.baseUrl}');
    // Dev.logLine('REQUEST STARTED WITH TOKEN : $token');
    // customOptions.headers['Authorization'] = 'Bearer $token';
    // customOptions.headers['Authorization'] = token;
    final token =
        await storageProvider.getSecuredString(StorageKeys.securedToken);
    if ( token.isNotEmpty) {
      Dev.logLine('REQUEST STARTED WITH TOKEN : $token');

      headers['Authorization'] = "Token $token"; // usually prefixed with Bearer
    }

    customOptions.headers.addAll(headers);
    List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    // interceptorLog(
    //     'REQUEST CONNECTIVITY : ${connectivityResult.first.name}');
    // if (connectivityResult.contains(ConnectivityResult.none)) {
    //   return handler.resolve(
    //     Response(
    //       requestOptions: customOptions,
    //       data: _handleErrorResponse(null).toJson(),
    //     ),
    //   );
    // } else {
      return handler.next(customOptions);
    // }
  }
@override
void onResponse(Response response, ResponseInterceptorHandler handler) {
  // if (response.data is Map<String, dynamic>) {
  //   final wrapped = Response(
  //     data: response.data,
  //     requestOptions: response.requestOptions,
  //     statusCode: response.statusCode,
  //     statusMessage: response.statusMessage,
  //     headers: response.headers,
  //     isRedirect: response.isRedirect,
  //     redirects: response.redirects,
  //     extra: response.extra,
  //   );
  //   handler.next(wrapped); // ← allow logger to run
  //   return;
  // }
  handler.next(response);
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
// class RemoteInterceptor extends Interceptor {
//   RemoteInterceptor(this.storageProvider);
//   final LocalStorage storageProvider;

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     final locale = storageProvider.userSettings.locale;
//     final req = options.copyWith(baseUrl: BaseUrls.baseUrl);

//     final headers = <String, dynamic>{
//       'Accept': 'application/json',
//       'Accept-Language': locale,
//     };

//     final token = await storageProvider.getSecuredString(StorageKeys.securedToken);
//     if (token != null && token.isNotEmpty) {
//       // Adjust based on backend: "Bearer" or "Token"
//       headers['Authorization'] = 'Bearer $token';
//     }

//     req.headers.addAll(headers);

//     Dev.logLine('➡️ REQUEST [${req.method}] ${req.uri}');
//     Dev.logLine('Headers: ${req.headers}');
//     if (req.data != null) Dev.logLine('Body: ${req.data}');

//     final connectivity = await Connectivity().checkConnectivity();
//     if (connectivity == ConnectivityResult.none) {
//       return handler.resolve(Response(
//         requestOptions: req,
//         data: _handleErrorResponse(null).toJson(),
//         statusCode: 0,
//         statusMessage: 'Offline',
//         headers: Headers(),
//       ));
//     }

//     handler.next(req);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) {
//     Dev.logLine('✅ RESPONSE [${response.statusCode}] ${response.requestOptions.uri}');
//     Dev.logLine('Data: ${response.data}');
//     handler.next(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     Dev.logLineWithTagError(
//       tag: '❌ ERROR [${err.response?.statusCode}]',
//       message: err.requestOptions.uri.toString(),
//       error: err.response?.data ?? err.message,
//     );

//     handler.resolve(Response(
//       requestOptions: err.requestOptions,
//       data: _handleErrorResponse(err.response, path: err.requestOptions.path).toJson(),
//       statusCode: err.response?.statusCode ?? 520,
//       statusMessage: err.response?.statusMessage ?? 'Error',
//       headers: err.response?.headers ?? Headers(),
//     ));
//   }

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
