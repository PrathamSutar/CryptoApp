import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import '../Models/model.dart';
import '../Models/chartmodel.dart';
import 'package:crypto_currency_app556/Models/chartmodel.dart';
import 'package:crypto_currency_app556/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

import '../app_themes/app_themes.dart';

class Graphapi extends StatefulWidget {
  final CoinDetailsModel coinDetailsModel;

  const Graphapi({super.key, required this.coinDetailsModel});

  @override
  State<Graphapi> createState() => _GraphapiState();
}

class _GraphapiState extends State<Graphapi> {

   bool isdarkmode = AppTheme.isdarkmodeenable;
  bool isfirsttime = true;
  bool isLoading = false;
  List<FlSpot> flspotlist = [];

  double minX = 0.0, maxX = 0.0, minY = 0.0, maxY = 0.0;
  @override
  void initState() {
    getChartdata("1");
    super.initState();
  }

  void getChartdata(String days) async {
    if (isfirsttime) {
      isfirsttime = false;
    } else {
      setState(() {
        isLoading = true;
      });
    }
    final response = await http.get(Uri.parse(
        "https://api.coingecko.com/api/v3/coins/${widget.coinDetailsModel.id}/market_chart?vs_currency=inr&days=$days"));

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);

      List rawList = result['prices'];

      List<List> chartdata = rawList.map((e) => e as List).toList();

      List<PriceAndTime> PriceAndtimeList = chartdata
          .map((e) => PriceAndTime(price: e[1] as double, time: e[0] as int))
          .toList();

      flspotlist = [];

      for (var e in PriceAndtimeList) {
        flspotlist.add(FlSpot(e.time.toDouble(), e.price));
      }

      minX = PriceAndtimeList.first.time.toDouble();
      maxX = PriceAndtimeList.last.time.toDouble();

      PriceAndtimeList.sort(
        (a, b) => a.price.compareTo(b.price),
      );

      minY = PriceAndtimeList.first.price;
      maxY = PriceAndtimeList.last.price;

      setState(() {
        isLoading = true;
      });
    }
  }








  // graphapi(coinDetailsModel) {
  //   bool isfirsttime = true;
  //   bool isLoading = false;
  //   List<FlSpot> flspotlist = [];
  //   double minX = 0.0, maxX = 0.0, minY = 0.0, maxY = 0.0;

  //   void getChartdata(String days) async {
  //     if (isfirsttime) {
  //       isfirsttime = false;
  //     } else {
  //       setState(() {
  //         isLoading = true;
  //       });
  //     }
  //     final response = await http.get(Uri.parse(
  //         "https://api.coingecko.com/api/v3/coins/${widget.coinDetailsModel.id}/market_chart?vs_currency=inr&days=$days"));

  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> result = jsonDecode(response.body);

  //       List rawList = result['prices'];

  //       List<List> chartdata = rawList.map((e) => e as List).toList();

  //       List<PriceAndTime> PriceAndtimeList = chartdata
  //           .map((e) => PriceAndTime(price: e[1] as double, time: e[0] as int))
  //           .toList();

  //       flspotlist = [];

  //       for (var e in PriceAndtimeList) {
  //         flspotlist.add(FlSpot(e.time.toDouble(), e.price));
  //       }

  //       minX = PriceAndtimeList.first.time.toDouble();
  //       maxX = PriceAndtimeList.last.time.toDouble();

  //       PriceAndtimeList.sort(
  //         (a, b) => a.price.compareTo(b.price),
  //       );

  //       minY = PriceAndtimeList.first.price;
  //       maxY = PriceAndtimeList.last.price;

  //       setState(() {
  //         isLoading = true;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isdarkmode ? Color.fromARGB(255, 52, 47, 47) : Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: isdarkmode ? Colors.white : Colors.black,
            )),
        backgroundColor:
            isdarkmode ? Color.fromARGB(255, 52, 47, 47) : Colors.white,
        elevation: 0,
        title: Text(
          widget.coinDetailsModel.name.toString(),
          style: TextStyle(
              color: isdarkmode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
      ),
      body: isLoading
          ? Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: "${widget.coinDetailsModel.name} Price\n",
                          style: TextStyle(
                              color: isdarkmode ? Colors.white : Colors.black,
                              fontSize: 18),
                          children: [
                            TextSpan(
                              text:
                                  "Rs.${widget.coinDetailsModel.currentPrice}\n",
                              style: TextStyle(
                                color: isdarkmode ? Colors.white : Colors.black,
                                fontSize: 38,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${widget.coinDetailsModel.priceChangePercentage24h}%\n",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            TextSpan(
                              text: "Rs.$maxY",
                              style: TextStyle(
                                  color:
                                      isdarkmode ? Colors.white : Colors.black,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 350,
                    width: double.infinity,
                    child: LineChart(
                      LineChartData(
                        minX: minX,
                        maxX: maxX,
                        minY: minY,
                        maxY: maxY,
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          show: false,
                        ),
                        gridData: FlGridData(
                          getDrawingVerticalLine: (value) {
                            return FlLine(strokeWidth: 0);
                          },
                          getDrawingHorizontalLine: (value) {
                            return FlLine(strokeWidth: 0);
                          },
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: flspotlist,
                            dotData: FlDotData(show: false),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            getChartdata("1");
                          },
                          child: Text("1D")),
                      ElevatedButton(
                          onPressed: () {
                            getChartdata("15");
                          },
                          child: Text("15D")),
                      ElevatedButton(
                          onPressed: () {
                            getChartdata("30");
                          },
                          child: Text("30D")),
                    ],
                  ),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
