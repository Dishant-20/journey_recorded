// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class AccessCodeScreen extends StatefulWidget {
  const AccessCodeScreen(
      {super.key, required this.str_guild_name, required this.str_access_code});

  final String str_guild_name;
  final String str_access_code;

  @override
  State<AccessCodeScreen> createState() => _AccessCodeScreenState();
}

class _AccessCodeScreenState extends State<AccessCodeScreen> {
  //
  TextEditingController cont_guild_name = TextEditingController();
  TextEditingController cont_access_code = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navigation_color,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, 'back');
          },
        ),
        title: Text(
          //
          'Access Code',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
            ),
            height: 58,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                14.0,
              ),
            ),
            child: TextField(
              controller: cont_guild_name,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                if (kDebugMode) {
                  print("Go button is clicked");
                }
              },
              decoration: const InputDecoration(
                // labelText: "Search",
                hintText: 'Guild Name',
                // prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              top: 20,
              right: 20,
            ),
            height: 58,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                14.0,
              ),
            ),
            child: TextField(
              controller: cont_access_code,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                if (kDebugMode) {
                  print("Go button is clicked");
                }
              },
              decoration: const InputDecoration(
                // labelText: "Search",
                hintText: 'Access Code',
                // prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              color: const Color.fromRGBO(
                250,
                42,
                18,
                1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(
                    0,
                    3,
                  ), // changes position of shadow
                ),
              ],
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(
                'Save and Continue',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
