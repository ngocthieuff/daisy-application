import 'package:daisy_application/core_services/models/job_application/job_application_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'job_application_rest_api.g.dart';

@RestApi()
abstract class JobApplicationRestApi {
  factory JobApplicationRestApi(Dio dio, {String baseUrl}) =
      _JobApplicationRestApi;

  @POST('')
  Future<HttpResponse<void>> create(@Body() JobApplicationModel body);
}