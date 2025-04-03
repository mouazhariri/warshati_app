import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:warshati/src/infrastructure/api/endpoint/dotenv_keys.dart';
import 'package:warshati/src/logger/log_services/dev_logger.dart';

class BaseUrls {
  static String baseUrl = '';
  static String networkImagebaseUrl = '';
  static init() {
    baseUrl = dotenv.get(DotenvKeys.baseUrl);
    Dev.logLine('mnor $baseUrl');
    networkImagebaseUrl = dotenv.get(DotenvKeys.imageBaseUrl);
  }
}
