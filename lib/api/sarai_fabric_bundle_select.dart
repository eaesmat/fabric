import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../model/sarai_fabric_bundle_select_model.dart';

// this class is providing company api calls
class SaraiFabricBundleSelectApiServiceProvider {
// base url comes from constant/ api url
  final String _baseURL = baseURL;
  // Data type comes from its model
  // api EndPoint comes from controller
  Future<Either<String, List<Data>>> getSaraiFabricBundleSelect(String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final saraiMarka = SaraiFabricBundlesSelectModel.fromJson(jsonResponse);
// return data to the controller
        return right(
          saraiMarka.data!,
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
}
