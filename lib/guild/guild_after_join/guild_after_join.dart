// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';

class GuildAfterJoinScreen extends StatefulWidget {
  const GuildAfterJoinScreen({super.key});

  @override
  State<GuildAfterJoinScreen> createState() => _GuildAfterJoinScreenState();
}

class _GuildAfterJoinScreenState extends State<GuildAfterJoinScreen> {
  //
  var str_chat_click = '0';
  var str_information_click = '0';
  var str_choose_guild_click = '0';
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
          'Guild details 2',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              // margin: const EdgeInsets.all(10.0),
              color: Colors.amber[600],
              width: MediaQuery.of(context).size.width,
              // height: 48.0,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    color: Colors.amber[800],
                    width: 120,
                    height: 120,
                  ),
                  //
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.transparent,
                      // width: 48.0,
                      height: 120,
                      child: Column(
                        children: [
                          Container(
                            // margin: const EdgeInsets.all(10.0),
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  text: 'SUBJECT : ',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Arts',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // TextSpan(text: ' world!'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //
                          Container(
                            // margin: const EdgeInsets.all(10.0),
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Account, Design, Leader',
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          //
                          Container(
                            // margin: const EdgeInsets.all(10.0),
                            color: Colors.transparent,
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Stack(
                              children: [
                                Container(
                                  child: Image.asset(
                                    'assets/images/btn_round.png',
                                    height: 140,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        8,
                                      ),
                                    ),
                                    // border: Border.all(),
                                  ),
                                ),
                                Positioned(
                                  child: Center(
                                    child: Text(
                                      'Members : 20',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: font_style_name,
                                      ),
                                    ),
                                  ),
                                  // top: 45,
                                  // left: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          // 250 , 0 ,30
          Container(
            // margin: const EdgeInsets.all(10.0),
            color: const Color.fromRGBO(250, 0, 30, 1),
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Row(
              children: <Widget>[
                //
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('chat click');
                      }
                      //
                      setState(() {
                        str_chat_click = '1';
                        str_information_click = '0';
                        str_choose_guild_click = '0';
                      });

                      //
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 8,
                      ),
                      height: 70,
                      decoration: (str_chat_click == '0')
                          ? const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                right: BorderSide(
                                  width: 0.4,
                                ),
                                bottom: BorderSide(
                                  width: 0,
                                ),
                              ),
                            )
                          : const BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                right: BorderSide(
                                  width: 0.4,
                                ),
                                bottom: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                      child: Center(
                        child: Text(
                          'CHAT',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('chat click');
                      }
                      //
                      setState(() {
                        str_chat_click = '0';
                        str_information_click = '1';
                        str_choose_guild_click = '0';
                      });

                      //
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 8,
                      ),
                      height: 70,
                      decoration: (str_information_click == '0')
                          ? BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 0.4,
                                ),
                                bottom: BorderSide(
                                  width: 0,
                                ),
                              ),
                            )
                          : BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 0.4,
                                ),
                                bottom: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                      child: Center(
                        child: Text(
                          'INFORMATION',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        print('chat click');
                      }
                      //
                      setState(() {
                        str_chat_click = '0';
                        str_information_click = '0';
                        str_choose_guild_click = '1';
                      });

                      //
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      height: 70,
                      decoration: (str_choose_guild_click == '0')
                          ? const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 0,
                                ),
                                bottom: BorderSide(
                                  width: 0,
                                ),
                              ),
                            )
                          : const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  width: 0,
                                ),
                                bottom: BorderSide(
                                  width: 2,
                                ),
                              ),
                            ),
                      child: Center(
                        child: Text(
                          'CHOOSE GUILD',
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
          //
          Container(
            // margin: const EdgeInsets.all(10.0),
            color: Colors.amber[600],
            width: MediaQuery.of(context).size.width,
            // height: 70,
            child: Column(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Guild Name',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Guild Name',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 16.0,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
