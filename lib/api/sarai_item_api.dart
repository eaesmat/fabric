import 'dart:convert';
import 'package:fabricproject/constants/api_url.dart';
import 'package:fabricproject/model/sarai_item_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class SaraiItemApiServiceProvider {
  final String _baseURL = baseURL;

  Future<Either<String, List<Data>>> getSaraiItem(String apiEndpoint) async {
    try {
      var response = await http.get(
        Uri.parse(_baseURL + apiEndpoint),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body.toString());
        final saraiItems = SaraiItemModel.fromJson(jsonResponse);
// return data to the controller
        return right(
          saraiItems.data!,
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
