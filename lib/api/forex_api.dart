import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/forex_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class ForexApiServiceProvider {
  // baseURL comes from constant class and hold base url
  final String _baseURL = baseURL;

// Either if fpDart package to hold the success and failure cases
// right success left failure
// Data is type comes from related models
// apiEndpoint gets endPoint from the controller
  Future<Either<String, List<Data>>> getForex(String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(
          response.body.toString(),
        );
// ForexModel do conversion (toJson fromJson)comes from related model file
        final forex = ForexModel.fromJson(jsonResponse);
// if success data is returned to the controller
        return right(
          forex.data!,
        );
      } else {
// if failure statues code data is returned to the controller
        return left(" ${response.statusCode}");
      }
    } catch (e) {
// if failure statues code data is returned to the controller
      return left(
        e.toString(),
      );
    }
  }

  Future<Either<String, int>> createForex(
      String apiEndpoint, Map<String, dynamic> data) async {
    String jsonData = json.encode(data);
    try {
      final response = await http
          .post(Uri.parse(_baseURL + apiEndpoint), body: jsonData, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        return right(response.statusCode);
      } else {
        return left(response.statusCode.toString());
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }

  Future<Either<String, int>> editForex(
      String apiEndpoint, Map<String, dynamic> data) async {
    String jsonData = json.encode(data);
    try {
      final response = await http
          .put(Uri.parse(_baseURL + apiEndpoint), body: jsonData, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        return right(response.statusCode);
      } else {
        return left(
          response.statusCode.toString(),
        );
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }

  Future<Either<String, int>> deleteForex(String apiEndpoint) async {
    try {
      final response = await http.delete(Uri.parse(_baseURL + apiEndpoint));
      if (response.statusCode == 200) {
        return right(response.statusCode);
      } else if (response.statusCode == 500) {
        return right(response.statusCode);
      } else {
        return left(
          response.statusCode.toString(),
        );
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }
}
