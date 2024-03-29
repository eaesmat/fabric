import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/customer_payment_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class CustomerPaymentApiServiceProvider {
  final String _baseURL = baseURL;

  Future<Either<String, List<Data>>> getCustomerPayment(
      String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final customerPayment = CustomerPaymentModel.fromJson(jsonResponse);

        return right(
          customerPayment.data!,
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

  Future<Either<String, int>> createCustomerPayment(
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

  Future<Either<String, int>> editCustomerPayment(
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

  Future<Either<String, int>> deleteCustomerPayment(String apiEndpoint) async {
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
