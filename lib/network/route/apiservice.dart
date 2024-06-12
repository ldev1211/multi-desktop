import 'package:dio/dio.dart';
import 'package:multi_desktop/app/features/pointing/data/model/point_ext.dart';
import 'package:multi_desktop/app/features/pointing/data/model/response_cert.dart';
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
          'authorization': 'Bearer ${PrefUtil.instance.getString("accessToken")}',
          'Content-Type': 'application/json'
        });
    return _ApiService(dio, baseUrl: baseUrl);
  }

  @POST('/login')
  Future<BaseResponse> login(@Body() Map<String, dynamic> body);

  @GET('/stu_inf/get_members_class')
  Future<BaseResponse> getMembers();

  @GET('/point_ext/get_status_point_ext')
  Future<BaseResponse> getStatusPoint();

  @POST('/point_ext/toggle_status')
  Future<BaseResponse> toggleStatus(@Body() Map<String, dynamic> body);

  @GET('/get_config')
  Future<BaseResponse> getConfig();

  @GET('/point_ext/get_point/{stuCode}')
  Future<ResponsePointExt> getPointExt(@Path("stuCode") String stuCode);

  @GET('/point_ext/get_cert/{stuCode}')
  Future<ResponseCert> fetchCert(@Path("stuCode") String stuCode);

  @POST('/point_ext/post_point')
  Future<BaseResponse> postPoint(@Body() Map<String, dynamic> body);

  @POST('/point_ext/init')
  Future<BaseResponse> initPointing();
}
