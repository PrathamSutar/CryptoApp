import 'package:crypto_currency_app556/Screens/secondscreen.dart';
import 'package:crypto_currency_app556/app_themes/app_themes.dart';
import 'package:crypto_currency_app556/Screens/updateprofilescreen.dart';
import 'package:crypto_currency_app556/utils/listviwe_widget.dart';
import 'package:crypto_currency_app556/services/httpcall.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto_currency_app556/Models/model.dart';

import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  List<CoinDetailsModel> dat1 = [];

  List<CoinDetailsModel> coindetaillist = [];
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String name = "", eamil = "";

  bool isdarkmode = AppTheme.isdarkmodeenable;

  @override
  void initState() {
    getuserdetail();
    Apiservice().getcoinsdetails();
    getapiresp();
    coindetaillist = dat1;
    super.initState();
  }

  void getuserdetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "";
      eamil = prefs.getString('email') ?? "";
    });
  }

  getapiresp() async {
    dat1 = (await Apiservice().getcoinsdetails());
    setState(() {
      dat1;
    });
  }

  Future<void> refresh() async {
    setState(() {
      dat1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor:
          isdarkmode ? Color.fromARGB(255, 52, 47, 47) : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
          },
          icon: Icon(Icons.menu),
          color: isdarkmode ? Colors.white : Colors.black,
        ),
        backgroundColor:
            isdarkmode ? Color.fromARGB(255, 52, 47, 47) : Colors.white,
        elevation: 0,
        title: Text(
          "CryptoCurrencyApp",
          style: TextStyle(
            color: isdarkmode ? Colors.white : Colors.black,
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor:
            isdarkmode ? Color.fromARGB(255, 52, 47, 47) : Colors.white,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: isdarkmode
                      ? Color.fromARGB(255, 52, 47, 47)
                      : Colors.blue,
                ),
                otherAccountsPictures: [
                  GestureDetector(
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      setState(() {
                        isdarkmode = !isdarkmode;
                      });

                      AppTheme.isdarkmodeenable = isdarkmode;
                      await prefs.setBool("isdarkmode", isdarkmode);
                    },
                    child:
                        Icon(isdarkmode ? Icons.dark_mode : Icons.light_mode),
                  )
                ],
                accountName: Text(
                  name,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  eamil,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                currentAccountPicture: const Icon(
                  Icons.account_circle_sharp,
                  size: 70,
                  color: Colors.white,
                )),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => updateprofile(),
                    ));
              },
              leading: Icon(Icons.account_box),
              iconColor: isdarkmode ? Colors.white : Colors.black,
              title: Text(
                "Update Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isdarkmode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                style:
                    TextStyle(color: isdarkmode ? Colors.white : Colors.black),
                onChanged: (Query) {
                  List<CoinDetailsModel> searchResult = dat1.where((Element) {
                    String coinname = Element.name.toString();

                    bool isItemFound = coinname.contains(Query);

                    return isItemFound;
                  }).toList();
                  setState(() {
                    coindetaillist = searchResult;
                  });
                },
                decoration: InputDecoration(
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                            color: isdarkmode ? Colors.white : Colors.black)),
                    hintText: "Search Coins",
                    hintStyle: TextStyle(
                        color: isdarkmode ? Colors.white : Colors.black),
                    prefixIcon: Icon(
                      Icons.search,
                      color: isdarkmode ? Colors.white : Colors.black,
                    )),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: RefreshIndicator(
              onRefresh: refresh,
              child: Scrollbar(
                child: ListView.builder(
                    itemCount: coindetaillist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => secondscreen(
                                      coinDetailsModel: coindetaillist[index]),
                                ));
                          },
                          child: ListTile(
                            leading: Image.network(
                                coindetaillist[index].image.toString()),
                            title: Text(
                              "${coindetaillist[index].name}\n${dat1[index].id}"
                                  .trim(),
                              style: TextStyle(
                                color: isdarkmode ? Colors.white : Colors.black,
                              ),
                            ),
                            trailing: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                  text:
                                      "RS.${coindetaillist[index].currentPrice}\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isdarkmode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                        text:
                                            "${coindetaillist[index].priceChangePercentage24h}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red))
                                  ]),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
