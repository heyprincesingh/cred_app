import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/loan_data_model.dart';

String apiUrl = "https://api.mocklets.com/p6764/test_mint";

class ApiService {
  static Future<LoanDataModel> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return LoanDataModel.fromMap(json.decode(response.body));
      } else {
        throw Exception("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error fetching data: $error");
    }
  }
}
