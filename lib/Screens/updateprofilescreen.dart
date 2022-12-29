import 'dart:ui';

import 'package:crypto_currency_app556/Screens/app_themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class updateprofile extends StatelessWidget {
  updateprofile({super.key});
  final TextEditingController Name = TextEditingController();
  final TextEditingController Email = TextEditingController();

  Future<void> savedata(String key, String value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(key, value);
  }

  void saveuserdetails() async {
    await savedata("name", Name.text);
    await savedata("email", Email.text);
    print("data has been saved");
  }

  bool isdarkmodeenable = AppTheme.isdarkmodeenable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isdarkmodeenable ? Color.fromARGB(255, 52, 47, 47) : Colors.white,
      appBar: AppBar(
        backgroundColor:
            isdarkmodeenable ? Color.fromARGB(255, 52, 47, 47) : Colors.blue,
        title: const Text("Profile Update"),
      ),
      body: Column(
        children: [
          customtextfiled("Enter Your Name", Name, "Name"),
          customtextfiled("Enter Your Email", Email, "Email"),
          ElevatedButton(
              onPressed: () {
                saveuserdetails();
                Navigator.pop(context);
              },
              child: Text("Save Details"))
        ],
      ),
    );
  }

  Widget customtextfiled(
      String title, TextEditingController controller, String labletext) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextField(style: TextStyle(color: isdarkmodeenable?Colors.white:Colors.black),
        controller: controller,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: isdarkmodeenable ? Colors.white : Colors.grey)),
            hintText: title,
            hintStyle: TextStyle(color: isdarkmodeenable ? Colors.white : null),
            label: Text(
              labletext,
              style: TextStyle(color: isdarkmodeenable ? Colors.white : null),
            )),
      ),
    );
  }
}
