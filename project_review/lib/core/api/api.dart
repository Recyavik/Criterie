import 'package:dio/dio.dart' hide Headers;
import 'package:project_review/core/models/response_data.dart';
import 'package:project_review/core/models/user/auth_data.dart';
import 'package:project_review/core/models/user/user_data.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

String serverBaseUrl = "http://127.0.0.1:6001";
String uploadPath = "/v1/upload";

@RestApi()
abstract class ApiClient {
  factory ApiClient() {
    Dio dio = Dio();
    dio.options = BaseOptions(baseUrl: serverBaseUrl);
    // dio.interceptors.add(InterceptorsWrapper(
    //     onError: (DioError dioError, ErrorInterceptorHandler handler) {
    //       debugPrint(dioError.response!.data["Error"]);
    // }));
    return _ApiClient(dio);
  }

  ///[USER]
  @POST("/user")
  Future<AuthData> authentication(@Body() UserData user);

  @PUT("/user")
  Future<ResponseData> registration(@Body() UserData user);
}