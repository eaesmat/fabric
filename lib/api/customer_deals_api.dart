import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/customer_deals_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class CustomerDealsApiServiceProvider {
  final String _baseURL = baseURL;

  Future<Either<String, CustomerDealsModel>> getCustomerDeals(
      String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final customerDeals = CustomerDealsModel.fromJson(jsonResponse);

        return right(customerDeals);
      } else {
        return left("${response.statusCode}");
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
