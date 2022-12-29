import 'dart:convert';

import 'package:crypto_currency_app556/Models/model.dart';
import 'package:http/http.dart' as http;






class ApiService{



  Future<List<CoinDetailsModel>> getcoindetails() async {


    

          final resp =await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=100&page=1&sparkline=false"));





      if(resp.statusCode==200|| resp.statusCode==201){
        

        List coinsdata = jsonDecode(resp.body);

        List<CoinDetailsModel> data = coinsdata.map((e) => CoinDetailsModel.fromJson(e)).toList();

        return data;
        
      }else{
        return <CoinDetailsModel> [];
      }




    }


    

  }



