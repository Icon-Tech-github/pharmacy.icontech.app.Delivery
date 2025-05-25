
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../local_storage.dart';
import '../ServerConstants.dart';

abstract class OrderDetailsRepository {

  Future fetchOrder(String token,int id);

}

class OrderDetailsRepo implements OrderDetailsRepository {

  var dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

  //
  static Map<String, String> apiHeaders = {
    "Content-Type": "application/json",
    "X-Requested-With": "XMLHttpRequest",
    "Content-Language": LocalStorage.getData(key: "lang") == "ar"? "ar":"en",
  };

  @override
  Future fetchOrder(String token,int id ) async{
    print(  LocalStorage.getData(key: "lang") == "ar"? "arrrrrrrrrr":"en");
    try
    {
      var response = await dio.get('${ServerConstants.details}/$id',
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "X-Requested-With": "XMLHttpRequest",
              "Content-Language": LocalStorage.getData(key: "lang") == "ar"? "ar":"en",
              'Authorization': '$token',
            },
            validateStatus: (status) {
              return status! < 500;
            },
          ));
      if (ServerConstants.isValidResponse(response.statusCode!)) {
        return response.data['data'];
      } else {
        return null;
      }
    }
    catch (error){
      return throw error;
    }
  }




}
