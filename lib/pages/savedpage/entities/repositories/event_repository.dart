import 'package:dio/dio.dart';
import 'package:sebarin/shared/function/dio_function.dart';

class EventRequest {
  static getEventById(int id) async {
    final url = "/api/events/show.php?id=$id";
    Response response;
    var dio = initiateDio();
    dio.interceptors.add(InterceptorsWrapper(
      onError: (e, handler) {
        print(e);

        return handler.resolve(Response(
            requestOptions: RequestOptions(path: url),
            data: {'status': 010, 'message': "connection timed out"}));
      },
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (e, handler) {
        return handler.next(e);
      },
    ));
    response = await dio.get(url);
    return response;
  }
}
