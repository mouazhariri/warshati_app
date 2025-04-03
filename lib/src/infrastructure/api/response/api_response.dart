// import 'package:json_annotation/json_annotation.dart';
// part 'api_response.g.dart';

// @JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  ApiResponse(this.status, this.message, this.data);

  ApiResponse.success({this.message, this.data}) : status = true;

  ApiResponse.error({this.message, this.error})
      : status = false,
        data = null;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT,
  ) {
    try {
      if (json['status'] == false) {
        return ApiResponse<T>.error(
          message: json['message'],
          error: json['data'],
        );
      } else {
        T? data;
        if (fromJsonT != null && json['data'] != null) {
          data = fromJsonT(json['data']);
        } else if (json['data'] == null) {
          data = null as T;
        } else if (T == bool) {
          // Special case: if T is bool, map the value to a boolean
          data = (json['data'] == true || json['data'] == 'success') as T;
        } else {
          throw Exception("Unexpected data type for ApiResponse");
        }
        return ApiResponse<T>.success(
          message: json['message'],
          data: data,
        );
      }
    } catch (error) {
      return ApiResponse<T>.error(message: error.toString(), error: error);
    }
  }
  final bool? status;
  final String? message;
  final T? data;
  dynamic error;
  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data,
        'error': error,
      };
  @override
  String toString() {
    return 'ApiResponse{status: $status, message: $message, data: $data, error: $error}';
  }

  bool get hasSucceeded => status == true;

  bool get hasFailed => status == false || status == null;
}
