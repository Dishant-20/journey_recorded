// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/grind/create_grind/create_grind.dart';
import 'package:journey_recorded/grind/grind_details/grind_details.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GrindScreen extends StatefulWidget {
  const GrindScreen({super.key});

  @override
  State<GrindScreen> createState() => _GrindScreenState();
}

class _GrindScreenState extends State<GrindScreen> {
  //
  var strGrindLoader = '0';
  var arrGrindList = [];
  //
  @override
  void initState() {
    super.initState();
    //
    getGrindWB();
    //
  }

  getGrindWB() async {
    if (kDebugMode) {
      print('=====> POST : MISSION LIST');
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
          'action': 'grindlist',
          'userId': prefs.getInt('userId').toString(),
          'pageNo': '1'
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        arrGrindList.clear();
        //
        for (var i = 0; i < getData['data'].length; i++) {
          arrGrindList.add(getData['data'][i]);
        }
        //
        if (arrGrindList.isEmpty) {
          strGrindLoader = '1';
        } else {
          strGrindLoader = '3';
        }
        setState(() {});
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
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
    //
    // get mission details

    //
    return Scaffold(
      appBar: AppBar(
        title: Text(
          //
          navigation_title_grind,
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
                  if (kDebugMode) {
                    print('object');
                  }
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
          //
          pushToCreateGrind(context);
          //
        },
        backgroundColor: navigation_color,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 160,
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
                    height: 140,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/images/task_bg.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(
                        14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      height: 140,
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
                                        color: Colors.white,
                                        width: 2.0,
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
                                        color: Colors.white,
                                        width: 2.0,
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
                                        color: Colors.white,
                                        width: 2.0,
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
                                        color: Colors.white,
                                        width: 2.0,
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
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Most Recent',
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
                                        color: Colors.white,
                                        width: 2.0,
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

            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            ///
            if (strGrindLoader == '0') ...[
              //
              const CustomeLoaderPopUp(
                str_custom_loader: 'Please wait...',
                str_status: '0',
              ),
              //
            ] else if (strGrindLoader == '1') ...[
              //
              const CustomeLoaderPopUp(
                str_custom_loader: 'Grind not Added Yet.',
                str_status: '4',
              ),
              //
            ] else ...[
              //
              Container(
                // width: MediaQuery.of(context).size.width,
                height: 60.0,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(
                    246,
                    200,
                    68,
                    1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffDDDDDD),
                      blurRadius: 6.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 0.0),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20),
                      color: Colors.transparent,
                      // width: MediaQuery.of(context).size.width,
                      // height: 60.0,
                      child: text_with_bold_style_black(
                        //
                        'Grind',
                        //
                      ),
                    ),
                    //
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      color: Colors.transparent,
                      width: 120,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              if (kDebugMode) {
                                print('object1');
                              }
                            },
                            icon: const Icon(
                              Icons.check_box,
                              color: Colors.pink,
                              size: 30,
                            ),
                          ),
                          //
                          text_with_regular_style(
                            'Expect',
                          )
                        ],
                      ),
                    ),
                    //
                  ],
                ),
              ),
              for (int i = 0; i < arrGrindList.length; i++) ...[
                InkWell(
                  onTap: () {
                    if (kDebugMode) {
                      print('asas');
                    }
                    //
                    grindDetails(context, i);
                    //
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        color: Colors.transparent,
                        // width: MediaQuery.of(context).size.width,
                        // height: 60.0,
                        child: text_with_semi_bold_style_black(
                          //
                          arrGrindList[i]['grindName'].toString(),
                          //
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.all(10.0),
                        color: Colors.transparent,
                        width: 120,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (kDebugMode) {
                                  print('object1');
                                }
                              },
                              icon: const Icon(
                                Icons.watch_later_rounded,
                                color: Colors.pink,
                                size: 30,
                              ),
                            ),
                            //
                            IconButton(
                              onPressed: () {
                                if (kDebugMode) {
                                  print('object1');
                                }
                                //
                                deleteGrindPopUp(
                                  arrGrindList[i]['grindName'].toString(),
                                  arrGrindList[i]['grindId'].toString(),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      //
                    ],
                  ),
                ),
                //
                Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width,
                  height: 1.0,
                ),
              ]
              //
            ],
          ],
        ),
      ),
    );
  }

  //
  Future<void> pushToCreateGrind(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateGrindScreen(
            // str_goal_id: widget.str_get_goal_id.toString(),
            ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    print('hello 1');
    if (!mounted) return;
    print('hello 2');
    if (result == 'back_from_create_grind') {
      setState(() {
        strGrindLoader = '0';
        getGrindWB();
      });
    } else {
      //

      //
    }
  }

  //
  Future<void> grindDetails(BuildContext context, i) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GrindDetailsScreen(
          dictShowFullData: arrGrindList[i],
        ),
      ),
    );

    if (kDebugMode) {
      print('result =====> ' + result);
    }

    print('hello 1');
    if (!mounted) return;
    print('hello 2');
    if (result == 'back_from_create_grind') {
      setState(() {
        strGrindLoader = '0';
        getGrindWB();
      });
    } else {
      //

      //
    }
  }

  //
  // ALERT
  Future<void> deleteGrindPopUp(strGrindName, strGrindId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: text_with_bold_style_black(
            'Delete',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: text_with_regular_style(
                    'Are you sure you want to delete "' + strGrindName + '" ?',
                  ),
                ),
              ],
              //
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Dismiss',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Yes, delete',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                //
                deleteGrindWB(
                  strGrindId,
                );
              },
            ),
          ],
        );
      },
    );
  }

  // delete grind
  deleteGrindWB(getGrindId) async {
    if (kDebugMode) {
      print('=====> POST : MISSION LIST');
    }

    setState(() {
      strGrindLoader = '0';
    });
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
          'action': 'girnddelete',
          'userId': prefs.getInt('userId').toString(),
          'grindId': getGrindId.toString(),
        },
      ),
    );

    // convert data to dict
    var getData = jsonDecode(resposne.body);
    if (kDebugMode) {
      print(getData);
    }

    if (resposne.statusCode == 200) {
      if (getData['status'].toString().toLowerCase() == 'success') {
        //
        getGrindWB();
        //
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
      if (kDebugMode) {
        print('something went wrong');
      }
    }
  }
  //
}
