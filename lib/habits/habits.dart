// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/habits/create_new_habit/create_new_habit.dart';
import 'package:journey_recorded/habits/habits_info.dart/habits_info.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HabitsScreen extends StatefulWidget {
  const HabitsScreen({super.key});

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  //
  var str_loader_habit = '0';
  var arr_habits_list = [];
  //
  @override
  void initState() {
    super.initState();

    //
    get_habits_list_WB();
  }

  // get cart
  get_habits_list_WB() async {
    print('=====> POST : HABIT LIST');

    str_loader_habit = '0';
    setState(() {});

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
          'action': 'habitlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': ''
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_habits_list.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arr_habits_list.add(get_data['data'][i]);
          //
        }

        //
        str_loader_habit = '1';
        setState(() {});
        //
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
        title: Text(
          //
          navigation_title_habits,
          //
          style: TextStyle(
            fontFamily: font_style_name,
            fontSize: 18.0,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: navigation_color,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
            ),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: app_yellow_color,
              child: InkWell(
                onTap: () {
                  print('object');
                },
                child: const Icon(
                  Icons.question_mark_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          func_push_to_add_new_habit(context);
        },
        backgroundColor: navigation_color,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            // color: Colors.amber,
            decoration: const BoxDecoration(
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
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    left: 20.0,
                  ),
                  height: 160,
                  width: 120,
                  decoration: const BoxDecoration(
                    // color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage(
                        //
                        'assets/images/dashboard_habits.png',
                        //
                      ),
                      fit: BoxFit.fill,
                      // opacity: .4,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                    ),
                    height: 160,
                    width: 120,
                    color: const Color.fromRGBO(
                      240,
                      20,
                      74,
                      1,
                    ),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Category',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'skill',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Stat',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Priority',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Mostrecent',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'None',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Mostrecent',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'None',
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          (str_loader_habit == '0')
              ? const CustomeLoaderPopUp(
                  str_custom_loader: 'please wait...',
                  str_status: '4',
                )
              : Column(
                  children: <Widget>[
                    for (var i = 0; i < arr_habits_list.length; i++) ...[
                      InkWell(
                        onTap: () {
                          print('<==== dishu ====>');

                          var split_date =
                              arr_habits_list[i]['reminderAlarm'].toString();

                          // print(split_date.split(' ')[0]);

                          push_to_edit_habits(
                            context,
                            arr_habits_list[i]['habitId'].toString(),
                            arr_habits_list[i]['name'].toString(),
                            arr_habits_list[i]['categoryId'].toString(),
                            arr_habits_list[i]['categoryName'].toString(),
                            arr_habits_list[i]['userName'].toString(),
                            arr_habits_list[i]['priority'].toString(),
                            split_date.split(' ')[0].toString(), // date
                            split_date.split(' ')[1].toString(), // time
                            arr_habits_list[i]['startPercentage'].toString(),
                            arr_habits_list[i]['tiggerPoint'].toString(),
                            arr_habits_list[i]['why'].toString(),
                            arr_habits_list[i]['danger'].toString(),
                            arr_habits_list[i]['pro'].toString(),
                            arr_habits_list[i]['specificDetails'].toString(),
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: 60.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: Text(
                                  //
                                  arr_habits_list[i]['name'].toString(),
                                  //
                                  style: TextStyle(
                                    fontFamily: font_style_name,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 20.0,
                                ),
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '+50%',
                                    style: TextStyle(
                                      fontFamily: font_style_name,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.grey,
                        width: MediaQuery.of(context).size.width,
                        height: 1.0,
                      ),
                    ]
                  ],
                ),
        ],
      ),
    );
  }

// push to add new habit
  Future<void> func_push_to_add_new_habit(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateNewHabitScreen(
          str_fetch_get_name_your_habit: '',
          str_fetch_get_user_name: '',
          str_fetch_get_priority: '',
          str_fetch_get_reminder_date: '',
          str_fetch_get_reminder_time: '',
          str_fetch_get_start: '',
          str_fetch_get_trigger: '',
          str_fetch_get_why: '',
          str_fetch_get_danger: '',
          str_fetch_get_pro: '',
          str_fetch_get_specify: '',
          str_fetch_get_habit_id: '',
          str_fetch_get_category_id: '',
          str_fetch_get_category_name: '',
        ),
      ),
    );

    print('result =====> ' + result);
    print('object 22.22');

    if (!mounted) return;

    //
    str_loader_habit = '0';
    get_habits_list_WB();
    //
  }

  Future<void> push_to_edit_habits(
    BuildContext context,
    String str_habit_id,
    String str_name,
    String str_get_category_id,
    String str_get_category_name,
    String str_user_name,
    String str_priority,
    String str_reminder_date,
    String str_reminder_time,
    String str_start,
    String str_trigger,
    String str_why,
    String str_danger,
    String str_pro,
    String str_specify,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HabitsInfoScreen(
          str_habit_id: str_habit_id.toString(),
          str_get_name_your_habit: str_name.toString(),
          str_get_category_id: str_get_category_id.toString(),
          str_get_category_name: str_get_category_name.toString(),
          str_get_user_name: str_user_name.toString(),
          str_get_priority: str_priority.toString(),
          str_get_reminder_date: str_reminder_date.toString(),
          str_get_reminder_time: str_reminder_time.toString(),
          str_get_start: str_start.toString(),
          str_get_trigger: str_trigger.toString(),
          str_get_why: str_why.toString(),
          str_get_danger: str_danger.toString(),
          str_get_pro: str_pro.toString(),
          str_get_specify: str_specify.toString(),
        ),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    //
    str_loader_habit = '0';
    get_habits_list_WB();
    //
  }
}
