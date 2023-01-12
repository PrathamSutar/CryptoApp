import 'dart:convert';
import 'dart:ui';
import 'package:crypto_currency_app556/Models/chartmodel.dart';
import 'package:crypto_currency_app556/Models/model.dart';
import 'package:crypto_currency_app556/services/graphapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import '../app_themes/app_themes.dart';

class secondscreen extends StatefulWidget {
  final CoinDetailsModel coinDetailsModel;
  const secondscreen({super.key, required this.coinDetailsModel});

  @override
  State<secondscreen> createState() => _secondscreenState();
}

class _secondscreenState extends State<secondscreen> {
  @override
  Widget build(BuildContext context) {
    return Graphapi(coinDetailsModel: widget.coinDetailsModel);
  }
}
