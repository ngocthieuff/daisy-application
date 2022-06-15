import 'package:daisy_application/core_services/google/google_sign_in.dart';
import 'package:daisy_application/core_services/grpc/healthcheck/health_check_grpc_client.dart';
import 'package:daisy_application/core_services/http/authentication/authentication_rest_api.dart';
import 'package:daisy_application/core_services/http/health_check/health_check_rest_api.dart';
import 'package:daisy_application/core_services/http/user/user_rest_api.dart';
import 'package:daisy_application/core_services/http_interceptor/authentication_interceptor.dart';
import 'package:daisy_application/core_services/models/authentication/authentication_model.dart';
import 'package:daisy_application/core_services/models/user/user_model.dart';
import 'package:daisy_application/core_services/persistent/authentication_persistent.dart';
import 'package:daisy_application/core_services/persistent/user_persistent.dart';
import 'package:daisy_application/core_services/socket/file_upload/file_upload_socket_client.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../common/config.dart';
import 'locator.dart';
import 'native_locator.dart' if (dart.library.html) 'web_locator.dart'
    as universal_locator;

class CoreServiceLocator {
  static init() {
    _initGrpcService();
    _initSocketService();
    _initHttpService();
    _initPersistentService();
    _initGoogleService();
  }

  static void _initGrpcService() {
    universal_locator.UniversalLocator.init();
    locator
        .registerFactory<HealthCheckGrpcClient>(() => HealthCheckGrpcClient());
  }

  static void _initSocketService() {
    locator.registerFactoryParam<IO.Socket, String, String>(
        (param1, param2) => IO.io(
            param1,
            IO.OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .disableAutoConnect() // disable auto-connection
                .setPath(param2)
                .build()));

    locator.registerFactory(() => FileUploadSocketClient());
  }

  static void _initHttpService() {
    locator.registerFactory<Dio>(
        () => Dio()..interceptors.add(AuthenticationInterceptor()));

    locator.registerFactory<HealthCheckRestApi>(() => HealthCheckRestApi(
        locator.get(),
        baseUrl: '${Config.API_URL}/v1/healthcheck'));

    locator.registerFactory<AuthenticationRestApi>(() => AuthenticationRestApi(
        locator.get(),
        baseUrl: '${Config.API_URL}/v1/auth'));

    locator.registerFactory<UserRestApi>(
        () => UserRestApi(locator.get(), baseUrl: '${Config.API_URL}/v1/user'));
  }

  static void _initPersistentService() {
    Hive.registerAdapter<AuthenticationModel>(AuthenticationAdapter());
    locator.registerFactory(() => AuthenticationPersistent());
    Hive.openBox(AuthenticationPersistent.BOX_NAME);

    Hive.registerAdapter<UserModel>(UserAdapter());
    locator.registerFactory(() => UserPersistent());
    Hive.openBox(UserPersistent.BOX_NAME);
  }

  static void _initGoogleService() {
    locator.registerFactory<GoogleSignIn>(() => GoogleSignIn());
  }
}
