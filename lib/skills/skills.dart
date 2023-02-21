// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/skills/create_skills/create_skills.dart';
import 'package:journey_recorded/training/create_task/create_training.dart';
import 'package:journey_recorded/training/skill_training_list.dart';
import 'package:journey_recorded/training/training_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({super.key});

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  //
  var str_main_loader = '0';
  var arr_skills = [];

  @override
  void initState() {
    super.initState();
    get_skills_list_WB();
  }

// get skills
  get_skills_list_WB() async {
    print('=====> POST : HABIT LIST');

    str_main_loader = '0';
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
          'action': 'skilllist',
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
        arr_skills.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          //
          arr_skills.add(get_data['data'][i]);
          //
        }

        //
        str_main_loader = '1';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              //
              navigation_title_skills,
              //
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
            backgroundColor: navigation_color,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            /*bottom: TabBar(
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'All',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    2.0,
                  ),
                  child: Text(
                    'By Category',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'By Level',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      fontSize: 18.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),*/
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: InkWell(
                  onTap: () {
                    push_to_create_skill(context);
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          body: tabbar_ALL_ui(context),
        ),
      ),
    );
  }

  SingleChildScrollView tabbar_ALL_ui(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          for (int i = 0; i < arr_skills.length; i++) ...[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SkillTrainingListScreen(
                        str_skill_id: arr_skills[i]['skillId'].toString(),
                      ),
                    ),
                  );
                  /**/
                },
                child: Container(
                  height: 46,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      const SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: (arr_skills[i]['image'].toString() == '')
                            ? Image.asset('assets/images/logo.png')
                            : FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loader.gif',
                                image: arr_skills[i]['image'].toString(),
                              ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Text(
                            //
                            arr_skills[i]['SkillName'].toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 18.0,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
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
                          color: const Color.fromRGBO(
                            250,
                            0,
                            60,
                            1,
                          ),
                          borderRadius: BorderRadius.circular(
                            20.0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            //
                            'Level : ${int.parse(arr_skills[i]['currentLavel'].toString()) + 1}',
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            // const SizedBox(
            //   height: 10,
            // ),
          ],
        ],
      ),
    );
  }

  Container tabbar_CATEGORY_ui(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.abc,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Text(
                'Knitting',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
              color: const Color.fromRGBO(
                250,
                0,
                60,
                1,
              ),
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            child: Center(
              child: Text(
                'LV:3',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container tabbar_LEVEL_ui(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.abc,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              color: Colors.transparent,
              child: Text(
                'Knitting',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
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
              color: const Color.fromRGBO(
                250,
                0,
                60,
                1,
              ),
              borderRadius: BorderRadius.circular(
                20.0,
              ),
            ),
            child: Center(
              child: Text(
                'LV:3',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> push_to_create_skill(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateSkills(),
      ),
    );

    print('result =====> ' + result);

    if (!mounted) return;

    str_main_loader = '0';
    setState(() {});
    get_skills_list_WB();
  }
}
