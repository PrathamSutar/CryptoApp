import 'dart:convert';

import 'package:crypto_currency_app556/Models/model.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  List<CoinDetailsModel> coinlist = [];

  Future<List<CoinDetailsModel>> getcoinsdetails() async {
    final resp = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false"));

    if (resp.statusCode == 200) {
      var coindata = jsonDecode(resp.body.toString());
      for (Map<String, dynamic> C in coindata) {
        coinlist.add(CoinDetailsModel.fromJson(C));
      }
      return coinlist;
    } else {
      return <CoinDetailsModel>[];
    }
  }
}
