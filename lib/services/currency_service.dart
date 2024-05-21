import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/currency_rate.dart';

class CurrencyService {
  static const String _apiKey = 'fca_live_EyIUg9OkoDDJ5AgMg0P9jcFV5rAYSaJgm7i3A09p';
  static const String _apiUrl = 'https://api.freecurrencyapi.com/v1/latest?apikey=$_apiKey';

  Future<CurrencyRate> fetchExchangeRate() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      return CurrencyRate.fromJson(json.decode(response.body));
    } else {

      throw Exception('Failed to load exchange rate');
    }
  }
}
