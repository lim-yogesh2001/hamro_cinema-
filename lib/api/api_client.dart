import 'dart:developer';

// import 'package:easy_soft_mofin/provider/utility_provider.dart';
import 'package:http/http.dart';

// import '/provider/user_detail_provider.dart';
import '/utils/request_type.dart';
// import '/utils/request_type_exception.dart';
import '/utils/string_to_url.dart';

class APIClient {
  static String token = '';
  final Client _client;

  APIClient(this._client);

  Future<Response> request({
    required RequestType requestType,
    // dynamic heading = Nothing,
    required String url,
    dynamic parameter,
    dynamic headers,
  }) async {
    Map<String, String> heading = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    Map<String, String> headingWithToken = {
      'Content-Type': 'application/json',
      'Authorization': 'Token $token',
    };

    // if (EnvironmentConfig.isProd != "true" && UtilityProvider.url.isNotEmpty) {
    //   String split = url.split("8070")[1];
    //   String completeUrl = UtilityProvider.url;
    //   url = "http://$completeUrl:8070$split";
    // }
    log(url);
    switch (requestType) {
      case RequestType.get:
        return _client.get(
          stringToUrl(url),
          headers: heading,
        );
      case RequestType.getWithToken:
        return _client.get(
          stringToUrl(url),
          headers: headingWithToken,
        );
      case RequestType.post:
        return _client.post(
          stringToUrl(url),
          body: parameter,
          headers: heading,
        );
      case RequestType.postWithHeaders:
        return _client.post(
          stringToUrl(url),
          body: parameter,
          headers: {...heading, ...headers},
        );
      case RequestType.postWithToken:
        return _client.post(
          stringToUrl(url),
          body: parameter,
          headers: headingWithToken,
        );
      case RequestType.putWithToken:
        return _client.put(
          stringToUrl(url),
          body: parameter,
          headers: headingWithToken,
        );
      case RequestType.delete:
        return _client.delete(
          stringToUrl(url),
          headers: heading,
        );
      // default:
      //   return throw RequestTypeNotFoundException(
      //     "The HTTP request method is not found",
      //   );
    }
  }
}
