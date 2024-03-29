// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/actions/actions.dart';
import 'package:journey_recorded/active_team/active_team.dart';
import 'package:journey_recorded/all_quotes_list/all_quotes_list.dart';
// import 'package:journey_recorded/category_list/category_list.dart';
import 'package:journey_recorded/custom_files/drawer.dart';
import 'package:journey_recorded/finance/finance.dart';
import 'package:journey_recorded/friends/friends.dart';
import 'package:journey_recorded/goals/goals.dart';
import 'package:journey_recorded/grind/grind.dart';
// import 'package:journey_recorded/guild/guild.dart';
import 'package:journey_recorded/guild/guild_list.dart';
import 'package:journey_recorded/habits/habits.dart';
import 'package:journey_recorded/house_1/house_1.dart';
import 'package:journey_recorded/inventory/inventory.dart';
// import 'package:journey_recorded/invite_friend/invite_friend.dart';
import 'package:journey_recorded/mission/mission.dart';
import 'package:journey_recorded/notes/notes.dart';
import 'package:journey_recorded/physical/physical.dart';
import 'package:journey_recorded/quest/quest.dart';
import 'package:journey_recorded/quotes/quotes.dart';
import 'package:journey_recorded/request/request_list.dart';
import 'package:journey_recorded/shops/game/game.dart';
import 'package:journey_recorded/skills/skills.dart';
import 'package:journey_recorded/sub_goals/sub_goals.dart';
import 'package:journey_recorded/task/task.dart';
// import 'package:journey_recorded/training/training_list.dart';
import 'package:journey_recorded/training/training_list_dashboard/training_list_dashboard.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //
  var login_user_name;
  //
  final PageController controller = PageController();
  late final TabController _controller;
  //
  var str_dashboard_category_loader = '0';
  var arr_category = [];
  //
  // slider
  double _currentSliderValue = 0;
  //
  var strTotalCoins = '0';
  var strLoginUserLevel = '0';
  //
  var arr_dashboard_data = [
    'Goals',
    'Sub Goals',
    'Quest',
    'Missions',
    'Tasks',
    'Training',
    'Grind',
    'Habits',
    'Quotes',
    'Skills',
    'Friends',
    'Requests',
    'Notes',
    'Inventory',
    'Shops',
    'Actions',
    'Guild',
  ];
  var arr_dashboard_data_image = [
    'assets/images/dashboard_goal.png',
    'assets/images/dashbaord_sub-goals.png',
    'assets/images/dashboard_quest.png',
    'assets/images/dashboard_mission.png',
    'assets/images/dashboard_tasks.png',
    'assets/images/dashbaord_training.png',
    'assets/images/dashboard_grind.png',
    'assets/images/dashboard_habits.png',
    'assets/images/dashboard_quote.png',
    'assets/images/dashboard_skills.png',
    'assets/images/dashboard_friends.png',
    'assets/images/dashbaord_requests.png',
    'assets/images/dashbaord_notes.png',
    'assets/images/dashbaord_inventory.png',
    'assets/images/dashboard_shop.png',
    'assets/images/dashboard_shop.png',
    'assets/images/dashboard_shop.png',
  ];
  //
  @override
  void initState() {
    super.initState();
    func_add();
    get_category_list_WB();
    func_name();
  }

// get cart
  get_category_list_WB() async {
    if (kDebugMode) {
      print('=====> POST : CATEGORY');
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'categorylistbyskilllabel',
          'userId': prefs.getInt('userId').toString()
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
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_category.add(get_data['data'][i]);
        }

        str_dashboard_category_loader = '1';

        strTotalCoins = prefs.getInt('totalPoints').toString();
        strLoginUserLevel = prefs.getInt('skill_Lavel').toString();

        setState(() {});
      } else {
        if (kDebugMode) {
          print(
            '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
          );
        }
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const navigationDrawer(),
      appBar: dashboard_app_bar_UI(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 500 - 160,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
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
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            if (str_dashboard_category_loader == '1') ...[
                              for (int i = 0; i < arr_category.length; i++) ...[
                                InkWell(
                                  onTap: () {
                                    //
                                    if (kDebugMode) {
                                      print(
                                        arr_category[i]['id'].toString(),
                                      );
                                    }

                                    //
                                    //
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AllQuotesListScreen(
                                          str_cateogry_id:
                                              arr_category[i]['id'].toString(),
                                          str_cateogry_name: arr_category[i]
                                                  ['name']
                                              .toString(),
                                        ),
                                      ),
                                    );
                                    //
                                    //
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 20.0,
                                      left: 20.0,
                                      right: 10.0,
                                    ),
                                    height: 60,
                                    width: 200,
                                    decoration: const BoxDecoration(
                                      // color: Colors.orange,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          // image name
                                          'assets/images/dashboard_upper_button.png',
                                        ),
                                        fit: BoxFit.fill,
                                        // opacity: .4,
                                      ),
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                            //
                                            arr_category[i]['category'] +
                                                ' : LV ' +
                                                arr_category[i]['skill_Lavel']
                                                    .toString(),
                                            //
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ] else ...[
                              const Center(
                                child: Text(
                                  'please wait...',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 90.0,
                      left: 10.0,
                      right: 10.0,
                    ),
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage(
                          // image name
                          'assets/images/dashboard_pink_box.png',
                        ),
                        fit: BoxFit.fill,
                        // opacity: .4,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 50.0,
                                  left: 40.0,
                                  bottom: 40.0,
                                ),
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 50.0,
                                  left: 10.0,
                                  bottom: 40.0,
                                  right: 30.0,
                                ),
                                height: 90,
                                // width: MediaQuery.of(context).size.width - 150,
                                color: Colors.transparent,
                                child: Column(
                                  children: <Widget>[
                                    // Icon(Icons.abc),
                                    Row(
                                      children: [
                                        //
                                        const Icon(
                                          Icons.currency_rupee,
                                          color: Colors.white,
                                        ),
                                        //
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.transparent,
                                            child: Text(
                                              //
                                              strTotalCoins.toString(),
                                              //
                                              style: TextStyle(
                                                fontFamily: font_style_name,
                                                fontSize: 24.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '13/3600',
                                          style: TextStyle(
                                            fontFamily: font_style_name,
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //
                                    Expanded(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.transparent,
                                        child: Slider(
                                          value: _currentSliderValue,
                                          max: 100,
                                          divisions: 5,
                                          label: _currentSliderValue
                                              .round()
                                              .toString(),
                                          onChanged: (double value) {
                                            setState(
                                              () {
                                                _currentSliderValue = value;
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 142.0,
                            left: 40.0,
                            bottom: 40.0,
                          ),
                          // height: 140,
                          width: 90,
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              //
                              login_user_name.toString(),
                              //
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: font_style_name,
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 142.0,
                            left: 140.0,
                            bottom: 40.0,
                            right: 40.0,
                          ),
                          // height: 140,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 60,
                                  width: 160,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        // image name
                                        'assets/images/dashboard_upper_button.png',
                                      ),
                                      fit: BoxFit.fill,
                                      // opacity: .4,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      //
                                      'Level : ' + strLoginUserLevel.toString(),
                                      //
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 14.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                // Text(
                                //   'Donnie McClurrink',
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     fontFamily: font_style_name,
                                //     fontSize: 14.0,
                                //     color: Colors.white,
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 360,
                      left: 20,
                      right: 20,
                    ),
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage(
                          // image name
                          'assets/images/box1.png',
                        ),
                        fit: BoxFit.fill,
                        // opacity: .4,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          margin: const EdgeInsets.only(
                            top: 42.0,
                            left: 60.0,
                            right: 58.0,
                            // bottom: 80.0,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                              style: TextStyle(
                                fontFamily: font_style_name,
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            left: 60.0,
                            right: 58.0,
                            // bottom: 50.0,
                          ),
                          // child: const TabPageSelector(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //
            const SizedBox(
              height: 10,
            ),
            //
            dashboard_grid_UI(context),
            //
          ],
        ),
      ),
    );
  }

  Container dashboard_grid_UI(BuildContext context) {
    return Container(
      height: 600,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
        ),
        itemCount: arr_dashboard_data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (arr_dashboard_data[index].toString() == 'Goals') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GoalsScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Sub Goals') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubGoalsScreen(
                      str_from_goal_id: 'n.a.',
                    ),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Requests') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequestListScreen(
                        // str_from_goal_id: 'n.a.',
                        ),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Quest') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuestScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Missions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MissionScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Notes') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotesScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Tasks') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TaskScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Friends') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FriendsScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Grind') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GrindScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Habits') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HabitsScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Shops') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GameScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Inventory') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InventoryScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Skills') {
                // print('skills push');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SkillsScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'd_house_1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const House1Screen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'd_finance') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FinanceScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Quotes') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuotesScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() ==
                  'd_active_team') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActiveTeamScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'd_physical') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhysicalScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Skills') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SkillsScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Guild') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GuildList(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Actions') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActionsScreen(),
                  ),
                );
              } else if (arr_dashboard_data[index].toString() == 'Training') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrainingListFromDashboard(),
                  ),
                );
              }
            },
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          35.0,
                        ),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          // image name

                          arr_dashboard_data_image[index],
                        ),
                        fit: BoxFit.fitHeight,
                        //opacity: .4,
                      ),
                    ),
                  ),
                  Container(
                    // height: 10,
                    //width: 10,
                    color: Colors.transparent,
                    child: Text(
                      //
                      arr_dashboard_data[index].toUpperCase(),
                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar dashboard_app_bar_UI() {
    return AppBar(
      backgroundColor: navigation_color,
      title: Text(
        'Dashboard',
        style: TextStyle(
          fontFamily: font_style_name,
          fontSize: 18.0,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(
            right: 20.0,
          ),
          child: Icon(
            Icons.notifications,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 20.0,
          ),
          child: Icon(
            Icons.margin,
          ),
        ),
      ],
    );
  }

  func_add() {
    print('check');

    int summ = 0;

    var stop_add = 0;

    var start_add = 0;

    var value = [1, 2, 3, 4, 5, 6, 7, 5, 8, 9, 3, 2];
    for (int i = 0; i < value.length; i++) {
      print(value[i].runtimeType);

      stop_add = value[i];

      if (stop_add == 6) {
        print('i am 6');
        start_add = 1;
      }

      if (start_add == 0) {
        summ = summ + value[i];
      }

      if (stop_add == 9) {
        print('i am 9');
        start_add = 0;
      }
    }
    print(summ);
  }

  func_name() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    login_user_name = prefs.getString('fullName');

    setState(() {});
  }
}
