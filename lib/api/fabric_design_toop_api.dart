import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/fabric_design_toop_model.dart';
import 'package:fabricproject/model/fabric_design_bundle_toop_color_model.dart'
    // ignore: library_prefixes
    as fabricDBTColor;
import 'package:fpdart/fpdart.dart';
import 'package:fabricproject/model/remaining_war_toop_model.dart'
    as remainingWarToop;
import 'package:http/http.dart' as http;

// this class provides api calls to the controller
class FabricDesignToopApiServiceProvider {
// baseURL comes from api url file in constant
  final String _baseURL = baseURL;
// Gets endpoint from controller
// Data type comes from model
  Future<Either<String, List<Data>>> getFabricDesignToop(
      String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final fabricFabricDesignToop =
            FabricDesignToopModel.fromJson(jsonResponse);
// r right returns success with data or status code
        return right(
          fabricFabricDesignToop.data!,
        );
      } else {
// l or left returns failure error or status code
        return left(" ${response.statusCode}");
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }

  // to get fabric design bundle toop color for selection
  Future<Either<String, List<fabricDBTColor.Data>>>
      getFabricDesignBundleToopColor(String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final fabricFabricDesignBundleToopColor =
            fabricDBTColor.FabricDesignBundleToopColorModel.fromJson(
                jsonResponse);
// r right returns success with data or status code
        return right(
          fabricFabricDesignBundleToopColor.data!,
        );
      } else {
// l or left returns failure error or status code
        return left(" ${response.statusCode}");
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }

   Future<Either<String, remainingWarToop.Data>>
      getFabricDesignRemainWarAndToop(String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final remainBundleAndWarModel =
            remainingWarToop.RemainingToopAndWar.fromJson(jsonResponse);
        if (remainBundleAndWarModel.data != null) {
          return right(remainBundleAndWarModel.data!);
        } else {
          return left("Data is null");
        }
      } else {
        return left(" ${response.statusCode}");
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }

  Future<Either<String, int>> createFabricDesignToop(
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

  Future<Either<String, int>> editFabricDesignToop(
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

  Future<Either<String, int>> deleteFabricDesignToop(String apiEndpoint) async {
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
