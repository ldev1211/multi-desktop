import 'package:dio/dio.dart';
import 'package:multi_desktop/network/model/base_response.dart';
import 'package:multi_desktop/util/pref/pref_utils.dart';
import 'package:retrofit/http.dart';

part 'apiservice.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) {
    dio.options = BaseOptions(
        receiveTimeout: 10000,
        connectTimeout: 10000,
        contentType: 'application/json',
        headers: {
          'authorization':
              'Bearer ${PrefUtil.instance.getString("accessToken")}',
          'Content-Type': 'application/json'
        });
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST('/login')
  Future<BaseResponse> login(@Body() Map<String, dynamic> body);
}
