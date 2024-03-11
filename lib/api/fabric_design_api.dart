// Import necessary dependencies and files
import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/fabric_design_model.dart';
import 'package:fabricproject/model/remaining_bundle_war_model.dart'
    as remainingWarBundle;
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

// Class responsible for handling API calls related to fabric designs
class FabricDesignApiServiceProvider {
  final String _baseURL = baseURL;

  // Function to fetch fabric designs from the API
  Future<Either<String, FabricDesignModel>> getFabricDesign(
      String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final fabricDesign = FabricDesignModel.fromJson(jsonResponse);

        return right(fabricDesign);
      } else {
        return left(" ${response.statusCode}");
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }

  Future<Either<String, remainingWarBundle.Data>>
      getFabricDesignRemainBundleAndWar(String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final remainBundleAndWarModel =
            remainingWarBundle.RemainingBundleAndWar.fromJson(jsonResponse);
        return right(
          remainBundleAndWarModel.data!,
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

  // Function to create a new fabric design through the API
  Future<Either<String, int>> createFabricDesign(
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

  // Function to edit an existing fabric design through the API
  Future<Either<String, int>> editFabricDesign(
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

  // Function to delete a fabric design through the API
  Future<Either<String, int>> deleteFabricDesign(String apiEndpoint) async {
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
