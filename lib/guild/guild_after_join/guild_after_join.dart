// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/guild/guild_details/guild_details.dart';
import 'package:journey_recorded/guild/my_guild_members/my_guild_members.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuildAfterJoinScreen extends StatefulWidget {
  const GuildAfterJoinScreen({super.key, this.dict_value});

  final dict_value;

  @override
  State<GuildAfterJoinScreen> createState() => _GuildAfterJoinScreenState();
}

class _GuildAfterJoinScreenState extends State<GuildAfterJoinScreen> {
  //
  var arr_new_guild = [];
  //
  var str_save_and_continue_loader = '0';
  var str_guild_loader = '0';
  var arr_guild_list = [];
  //
  var str_chat_click = '0';
  var str_information_click = '0';
  var str_choose_guild_click = '0';
  //
  @override
  void initState() {
    super.initState();

    //
    // get_goals_list_WB('');
    //
    // print('dishant rajput');
    // print(widget.dict_value[0]);
    // print(widget.dict_value[0]['name'].toString());
    //
    arr_new_guild = [
      {
        'title': 'Guild Name',
        'name': widget.dict_value['name'].toString(),
      },
      {
        'title': 'Subject of Guild',
        'name': widget.dict_value['subject'].toString(),
      },
      {
        'title': 'Donation',
        'name': widget.dict_value['Donation'].toString(),
      },
      {
        'title': 'Creator Name',
        'name': widget.dict_value['createrName'].toString(),
      },
      {
        'title': 'Access code',
        'name': widget.dict_value['accessCode'].toString(),
      },
      {
        'title': 'Purpose of this Guild',
        'name': widget.dict_value['Description'].toString(),
      },
      {
        'title': 'Guild Radius',
        'name': widget.dict_value['miles'].toString(),
      },
      {
        'title': 'What is our goal to you',
        'name': widget.dict_value['benefit'].toString(),
      },
    ];
    //
    if (kDebugMode) {
      // print('object');
      // print(arr_new_guild);
      // print('object');
      // print(widget.dict_value);
    }
    //
  }

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
          widget.dict_value['name'].toString(),
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Center(
              child: Container(
                // margin: const EdgeInsets.all(10.0),
                // color: Colors.amber[600],
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(
                        54,
                        30,
                        107,
                        1,
                      ),
                      Color.fromRGBO(
                        92,
                        21,
                        93,
                        1,
                      ),
                      Color.fromRGBO(
                        138,
                        0,
                        70,
                        1,
                      ),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                // height: 48.0,
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      // color: Colors.amber[800],
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(),
                      ),
                      child: Image.network(
                        widget.dict_value['imge'].toString(),
                        fit: BoxFit.cover,
                      ),
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
                                    text: '',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.dict_value['name']
                                            .toString(),
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
                                  //
                                  widget.dict_value['subject'].toString(),
                                  //
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
                                      child: InkWell(
                                        onTap: () async {
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();

                                          if (kDebugMode) {
                                            print(widget.dict_value['userId']);
                                            print(prefs
                                                .getInt('userId')
                                                .toString());
                                          }

                                          (prefs.getInt('userId').toString() ==
                                                  widget.dict_value['userId']
                                                      .toString())
                                              ? Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyGuildMembersScreen(
                                                      str_guild_id: widget
                                                          .dict_value['gluidId']
                                                          .toString(),
                                                      str_remove_member: 'yes',
                                                    ),
                                                  ),
                                                )
                                              : Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyGuildMembersScreen(
                                                      str_guild_id: widget
                                                          .dict_value['gluidId']
                                                          .toString(),
                                                      str_remove_member: 'no',
                                                    ),
                                                  ),
                                                );
                                          // print();

                                          /**/
                                        },
                                        child: Text(
                                          //
                                          'Max Member : ${widget.dict_value['maxNumber']}',
                                          //
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: font_style_name,
                                            fontWeight: FontWeight.bold,
                                          ),
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
                          str_guild_loader = '0';
                          str_chat_click = '0';
                          str_information_click = '0';
                          str_choose_guild_click = '1';
                        });
                        //
                        get_goals_list_WB('');
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
            if (str_information_click == '1') ...[
              for (int i = 0; i < arr_new_guild.length; i++) ...[
                //
                guild_information_UI(context, i),
                //
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
              ],
            ] else if (str_choose_guild_click == '1') ...[
              //

              //
              // const SizedBox(
              //   height: 40,
              // ),
              // const CircularProgressIndicator(),
              //
              if (str_guild_loader == '0') const CircularProgressIndicator(),
              if (str_guild_loader == '2')
                const CustomeLoaderPopUp(
                  str_custom_loader: 'No Data found.',
                  str_status: '4',
                )
              else
                ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: arr_guild_list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        //
                        if (arr_guild_list[index]['youJoin'].toString() ==
                            'Yes') {
                          if (kDebugMode) {
                            print('object 121212');
                          }

                          push_to_quit_grid(context, index);
                          //
                        } else {
                          if (kDebugMode) {
                            print(arr_guild_list[index]);
                          }
                          //
                          if (kDebugMode) {
                            print('object 121212.1');
                          }
                          //
                          push_to_quit_grid(context, index);
                        }
                        //
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 0.0,
                        ),
                        height: 80,
                        color: Colors.transparent,
                        child: ListTile(
                          // iconColor: Colors.pink,
                          leading: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(
                                40.0,
                              ),
                            ),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                // color: Colors.blueAccent[200],
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              child:
                                  (arr_guild_list[index]['imge'].toString() !=
                                          '')
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            arr_guild_list[index]['imge']
                                                .toString(),
                                          ),
                                          radius: 60,
                                        )
                                      : Align(
                                          child: Text(
                                            //
                                            // arr_guild_list[index]['name'].toString(),
                                            func_get_initials(
                                                arr_guild_list[index]['name']
                                                    .toString()),

                                            //
                                            style: TextStyle(
                                              fontFamily: font_style_name,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                            ),
                          ),

                          title: Text(
                            //
                            arr_guild_list[index]['name'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: RichText(
                            text: TextSpan(
                              text:
                                  'Total Member : ${arr_guild_list[index]['maxNumber']}',
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 16.0,
                                color: Colors.orange,
                                // fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                  text: '\n',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Miles : ${arr_guild_list[index]['miles']}',
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              //
            ],
            //
          ],
        ),
      ),
    );
  }

  Padding guild_information_UI(BuildContext context, int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // margin: const EdgeInsets.all(10.0),
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        // height: 70,
        child: Column(
          children: [
            const SizedBox(
              width: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  //
                  arr_new_guild[i]['title'].toString(),
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  //
                  arr_new_guild[i]['name'].toString(),
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //
  func_get_initials(String str_name) {
    var initials_are = str_name.split(' ');

    var final_initial_name = '';
    // print(initials_are.length);
    // if (initials_are.length == 1) {
    final_initial_name = initials_are[0][0].toString().toUpperCase();
    /*}else if (initials_are.length == 2) {
      final_initial_name =
          (initials_are[0][0] + initials_are[1][0]).toString().toUpperCase();
    } else {
      final_initial_name = initials_are[0][0].toString().toUpperCase();
    }*/
    return final_initial_name;
  }

  //
  get_goals_list_WB(
    String str_search,
  ) async {
    print('=====> POST : GUILD LIST');

    // setState(() {
    //   str_guild_loader = '1';
    // });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getInt('userId').toString());
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'gulidlist',
          'userId': prefs.getInt('userId').toString(),
          'searchKey': str_search.toString(),
          // 'own': '',
          // 'subGoal': '2'
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(get_data);
    }

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        arr_guild_list.clear();
        for (var i = 0; i < get_data['data'].length; i++) {
          arr_guild_list.add(get_data['data'][i]);
        }

        if (arr_guild_list.isEmpty) {
          setState(() {
            str_guild_loader = '2';
            str_save_and_continue_loader = '1';
          });
        } else {
          setState(() {
            str_guild_loader = '1';
            str_save_and_continue_loader = '1';
          });
        }
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      print('something went wrong');
    }
  }

  //
  Future<void> push_to_quit_grid(BuildContext context, i) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuildDetailsScreen(
          dict_get_data: arr_guild_list[i],
          str_from_list: 'no',
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    if (!mounted) return;

    if (result.toString() == 'back') {
      if (kDebugMode) {
        print('object 32');
      }
    }

    setState(() {
      str_guild_loader = '0';
      str_chat_click = '0';
      str_information_click = '0';
      str_choose_guild_click = '1';
    });
    //
    get_goals_list_WB('');
  }
  //
}
