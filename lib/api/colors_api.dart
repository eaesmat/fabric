import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/colors_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

// this class is providing colors api calls
class ColorsApiServiceProvider {
// base url comes from constant/ api url
  final String _baseURL = baseURL;
  // Data type comes from its model
  // api EndPoint comes from controller
  Future<Either<String, List<Data>>> getColor(String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final colors = ColorsModel.fromJson(jsonResponse);
// return data to the controller
        return right(
          colors.data!,
        );
      } else {
        return left(" ${response.statusCode}");
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }

  Future<Either<String, int>> createColor(
      String apiEndpoint, Map<String, dynamic> data) async {
    String jsonData = json.encode(data);
    try {
      final response = await http
          .post(Uri.parse(_baseURL + apiEndpoint), body: jsonData, headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        // Parse the response body
        final responseBody = json.decode(response.body);
        final int lastId = responseBody['last_id'];
        return right(lastId); // Return the last inserted ID
      } else {
        return left(response.statusCode.toString());
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
