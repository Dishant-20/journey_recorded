// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/guild/guild_details/guild_details.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuildList extends StatefulWidget {
  const GuildList({super.key});

  @override
  State<GuildList> createState() => _GuildListState();
}

class _GuildListState extends State<GuildList> {
  //
  var str_guild_loader = '0';
  var arr_guild_list = [];
  //
  @override
  void initState() {
    super.initState();
    get_goals_list_WB();
  }

  get_goals_list_WB() async {
    print('=====> POST : GOAL LIST');

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
          'searchKey': '',
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

        setState(() {
          str_guild_loader = '1';
        });
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          //
          'Guild',
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('qwkhfcfhgvjb');
        },
        backgroundColor: navigation_color,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: (str_guild_loader == '0')
            ? const CustomeLoaderPopUp(
                str_custom_loader: 'please wait...', str_status: '3')
            : ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: arr_guild_list.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      print('object');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => GuildDetailsScreen(
                      //       dict_get_data: arr_guild_list[index],
                      //     ),
                      //   ),
                      // );

                      push_to_guild_details(
                        context,
                        arr_guild_list[index],
                      );
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
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Align(
                              child: Text(
                                //
                                // arr_guild_list[index]['name'].toString(),
                                func_get_initials(arr_guild_list[index]
                                        ['createrName']
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

                        /*ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: (arr_goal_list[index]['image'].toString() ==
                              '')
                          ? Image.asset('assets/images/logo.png')
                          : FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loader.gif',
                              image:
                                  arr_goal_list[index]['image'].toString(),
                            ),
                    ),*/
                        // const CircleAvatar(
                        //   radius: 30,
                        //   backgroundImage: AssetImage(
                        //     'assets/images/3.png',
                        //   ),
                        // ),
                        title: Text(
                          //
                          arr_guild_list[index]['createrName'].toString(),
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
                        /*Text(
                          //
                          'Total Member : ${arr_guild_list[index]['maxNumber']}',
                          // 'category name',
                          //
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 14.0,
                            color: const Color.fromRGBO(
                              30,
                              58,
                              118,
                              1,
                            ),
                          ),
                        ),*/
                        /*trailing: Container(
                          height: 40,
                          width: 120,
                          decoration: const BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                25.0,
                              ),
                            ),
                          ),
                          child: Align(
                            child: Text(
                              //
                              'Miles : ${arr_guild_list[index]['miles']}',
                              //
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),*/
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> push_to_guild_details(BuildContext context, dict_value) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GuildDetailsScreen(
          dict_get_data: dict_value,
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    if (result.toString() == 'back') {
      print('object 32');
    }

    str_guild_loader = '0';
    setState(() {});
    get_goals_list_WB();
  }

  //
  func_get_initials(String str_name) {
    var initials_are = str_name.split(' ');

    var final_initial_name = '';
    // print(initials_are.length);
    if (initials_are.length == 1) {
      final_initial_name = initials_are[0][0].toString().toUpperCase();
    } else if (initials_are.length == 2) {
      final_initial_name =
          (initials_are[0][0] + initials_are[1][0]).toString().toUpperCase();
    } else {
      final_initial_name = initials_are[0][0].toString().toUpperCase();
    }
    return final_initial_name;
  }
}
