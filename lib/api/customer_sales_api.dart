import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/customer_sales.model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class CustomerSalesApiServiceProvider {
  final String _baseURL = baseURL;

  Future<Either<String, List<Data>>> getCustomerSales(
      String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final customerSales = CustomerSalesModel.fromJson(jsonResponse);
// return data to the controller
        return right(
          customerSales.data!,
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
