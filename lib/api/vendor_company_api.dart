import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/vendor_company_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

// this class provides api calls to the controller
class VendorCompanyApiServiceProvider {
// base URL comes from constant
  final String _baseURL = baseURL;
// data is model type
// this methods are expecting endpoint from controller
  Future<Either<String, List<Data>>> getVendorCompany(
      String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final vendorCompany = VendorCompanyModel.fromJson(jsonResponse);
// return data to the controller
        return right(
          vendorCompany.data!,
        );
      } else {
// return status code if failure
        return left(" ${response.statusCode}");
      }
    } catch (e) {
      return left(
        e.toString(),
      );
    }
  }


  Future<Either<String, int>> createVendorCompany(
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

  Future<Either<String, int>> editVendorCompany(
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

  Future<Either<String, int>> deleteVendorCompany(String apiEndpoint) async {
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
