import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '/api/api_client.dart';
import '/utils/request_type.dart';

class APICall {
  final APIClient _client = APIClient(Client());

  postRequestWithoutToken(String url, Map body) async {
    try {
      Response _response = await _callApi(
        RequestType.post,
        url,
        body: body,
      );
      log(_response.body);
      if (_response.statusCode >= 200 || _response.statusCode <= 300) {
        return _response.body;
      }
      throw jsonDecode(_response.body)["error"] ??
          jsonDecode(_response.body)["non_field_errors"];
    } catch (ex) {
      rethrow;
    }
  }

  postRequestWithToken(String url, Map body, {RequestType? requestType}) async {
    try {
      Response _response = await _callApi(
        requestType ?? RequestType.postWithToken,
        url,
        body: body,
      );
      log(_response.body);
      if (_response.statusCode >= 200 || _response.statusCode <= 300) {
        return _response.body;
      }
      throw jsonDecode(_response.body)["error"];
    } catch (ex) {
      rethrow;
    }
  }

  getRequestWithToken(String url) async {
    try {
      Response _response = await _callApi(RequestType.getWithToken, url);
      if (_response.statusCode >= 200 || _response.statusCode <= 300) {
        return _response.body;
      }
      throw jsonDecode(_response.body)["error"];
    } catch (ex) {
      rethrow;
    }
  }

  _callApi(RequestType requestType, String url, {Map? body}) async {
    if (body != null) {
      return await _client.request(
        requestType: requestType,
        url: url,
        parameter: jsonEncode(body),
      );
    } else {
      return await _client.request(
        requestType: requestType,
        url: url,
      );
    }
  }
}
