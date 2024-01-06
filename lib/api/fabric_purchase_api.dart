import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/fabric_purchase_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class FabricPurchaseApiServiceProvider {
  // baseURL comes from the constant class
  final String _baseURL = baseURL;
// Data is is a type comes from the Model class
  Future<Either<String, List<Data>>> getFabricPurchase(
      // gets the endpoint from the controller class
      String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final fabricPurchase = FabricPurchaseModel.fromJson(jsonResponse);

        return right(
          fabricPurchase.data!,
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

  Future<Either<String, int>> createFabricPurchase(
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

  Future<Either<String, int>> editFabricPurchase(
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

  Future<Either<String, int>> deleteFabricPurchase(String apiEndpoint) async {
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
