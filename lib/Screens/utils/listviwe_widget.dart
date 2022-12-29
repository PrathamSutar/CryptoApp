import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class listviwe_widget extends StatefulWidget {
  const listviwe_widget({super.key});

  @override
  State<listviwe_widget> createState() => _listviwe_widgetState();
}

class _listviwe_widgetState extends State<listviwe_widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/128px-Bitcoin.svg.png"),
        title: Text("Bitcoin\nBTC"),
        trailing: RichText(textAlign: TextAlign.end,
          text: TextSpan(
            text: "Rs.18695.39\n",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),children: [
              TextSpan(
                text: "3.02%",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.red)
              )
            ]
          ),
        ),
      ),
    );
  }
}
