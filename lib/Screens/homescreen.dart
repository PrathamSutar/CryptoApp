import 'package:crypto_currency_app556/Models/model.dart';
import 'package:crypto_currency_app556/Screens/app_themes/app_themes.dart';
import 'package:crypto_currency_app556/Screens/updateprofilescreen.dart';
import 'package:crypto_currency_app556/Screens/utils/listviwe_widget.dart';
import 'package:crypto_currency_app556/services/httpcall.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class homescreen extends StatefulWidget {
  const homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  String name = "", eamil = "";

  bool isdarkmode = AppTheme.isdarkmodeenable;

  @override
  void initState() {
    getuserdetail();
    getcoindata();

    super.initState();
  }


  






  void getuserdetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? "";
      eamil = prefs.getString('email') ?? "";
    });
  }

  getcoindata()async{

     ApiService().getcoindetails();

     

    



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
          children:  [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  hintText: "Search Coins",
                  prefixIcon: Icon(Icons.search)
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ), Expanded(child: ListView.builder(
              itemCount: 1,
              
              itemBuilder: (context, index) {
                return listviwe_widget();
              
            },))

          
          ],
        ),
      ),
    );
  }
}
