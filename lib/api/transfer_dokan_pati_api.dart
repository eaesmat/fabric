// Import necessary dependencies and files
import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

// Class responsible for handling API calls related to fabric designs
class TransferDokanPatiApiServiceProvider {
  final String _baseURL = baseURL;

  Future<Either<String, int>> transferBundles(
      String apiEndpoint, List<Map<String, dynamic>> data) async {
    String jsonData = json.encode({"data": data}); // Wrap data with "data" key
    print(jsonData);
    try {
      final response = await http.post(
        Uri.parse(_baseURL + apiEndpoint),
        body: jsonData,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return right(response.statusCode);
      } else {
        return left(response.statusCode.toString());
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
