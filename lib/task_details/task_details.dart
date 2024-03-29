// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/create_check_list/create_check_list.dart';
import 'package:journey_recorded/goals/add_notes_in_goal/add_note_in_goal_modal.dart';
import 'package:journey_recorded/goals/add_notes_in_goal/add_notes_in_goal.dart';
import 'package:journey_recorded/goals/edit_notes_in_goal/edit_notes_in_goal.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen(
      {super.key,
      required this.str_task_name,
      required this.str_experince,
      required this.str_deduct_experince,
      required this.str_price,
      required this.str_professional_id,
      required this.str_add_reminder,
      required this.str_reminder_warning,
      required this.str_task_details,
      required this.str_due_date});

  final String str_due_date;
  final String str_task_details;
  final String str_task_name;
  final String str_experince;
  final String str_deduct_experince;
  final String str_price;
  final String str_professional_id;
  final String str_add_reminder;
  final String str_reminder_warning;

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  var hide_floating_button = '0';
  //
  var str_main_loader = '0';
  var arr_agents = [];
  //
  var arr_notes_list = [];
  //
  var arr_check_list = [];
  //
  AddNoteModal add_note_service = AddNoteModal();
  @override
  void initState() {
    super.initState();
    func_get_task_list_WB();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            //
            widget.str_task_name.toString(),
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
            onPressed: () => Navigator.pop(
              context,
              // 'back_from_create_task',
              // str_send_user_id.toString(),
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                _showMyDialog(
                  'Are you sure your want to delete ${widget.str_task_name.toString()} ?',
                  widget.str_professional_id.toString(),
                );
              },
              icon: Icon(
                Icons.delete_forever,
              ),
            ),
            /*IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
              ),
            ),*/
          ],
          bottom: TabBar(
            // controller: _tabController,
            indicatorColor: Colors.lime,
            isScrollable: true,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Info'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Rewards'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Reminders'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Agents'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Notes'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Checklist'.toUpperCase(),
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
            onTap: (value) {
              print(value);
              if (value == 4) {
                //

                func_check_list_WB();
                setState(() {});
              } else {
                hide_floating_button = '0';

                setState(() {});
              }
            },
          ),
        ),
        /*floatingActionButton: Column(
          children: <Widget>[
            (hide_floating_button == '0')
                ? FloatingActionButton(
                    onPressed: () {
                      print('object');
                    },
                    backgroundColor: navigation_color,
                    child: const Icon(Icons.add),
                  )
                : FloatingActionButton(
                    onPressed: () {
                      print('object');
                    },
                    backgroundColor: navigation_color,
                    child: const Icon(Icons.add),
                  ),
          ],
        ),*/
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // tab 1
            tab_1_info_UI(context),

            // tab 2
            tab_1_rewards_UI(context),

            // tab 3 ( reminders )
            tab_3_reminder_UI(context),

            // tab 4 ( agent )
            tab_2_agent_UI(),

            // tab 5
            (str_main_loader == 'notes_loader_start')
                ? const CustomeLoaderPopUp(
                    str_custom_loader: 'please wait...',
                    str_status: '3',
                  )
                : tab_4_notes_UI(),

            // tab 5
            tab_5_checklist_UI(context)
          ],
        ),
      ),
    );
  }

  Column tab_1_info_UI(BuildContext context) {
    return Column(
      children: <Widget>[
        //
        task_header_UI(context),
        //
        Container(
          margin: const EdgeInsets.all(
            12.0,
          ),
          // height: 120,
          width: MediaQuery.of(context).size.width,
          // color: Colors.amber,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(
              14.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      text: 'Description'.toString(),
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              //
                              '\n\n${widget.str_task_details}',
                          //,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                /*Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '  Description'.toUpperCase(),
                          style: TextStyle(
                            fontFamily: font_style_name,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            //
                            widget.str_task_details.toString(),
                            //
                            style: TextStyle(
                              fontFamily: font_style_name,
                              fontSize: 16.0,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),*/
                // const SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView tab_3_reminder_UI(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          task_header_UI(context),
          //

          Container(
            margin: const EdgeInsets.all(20),
            height: 80,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: navigation_color,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Align(
              child: Text(
                //
                widget.str_add_reminder.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(
              250,
              186,
              10,
              1,
            ),
            child: Align(
              child: Text(
                'Warning',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            // height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Align(
              child: Text(
                //
                widget.str_reminder_warning.toString(),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Column tab_5_checklist_UI(BuildContext context) {
    return Column(
      children: [
        //
        task_header_UI(context),
        //
        Expanded(
          child: (str_main_loader == 'checklist_loader_start')
              ? const CustomeLoaderPopUp(
                  str_custom_loader: 'please wait...', str_status: '3')
              : Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (int i = 0; i < arr_check_list.length; i++) ...[
                          Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                            ),
                            // height: 60,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      //
                                      arr_check_list[i]['message'].toString(),
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                      ),

                                      //
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 0.0,
                                  ),
                                  height: 50,
                                  width: 120,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            print('check list edit');

                                            push_to_edit_checklist(
                                              context,
                                              arr_check_list[i]['checklistId']
                                                  .toString(),
                                              arr_check_list[i]['message']
                                                  .toString(),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            print('ok');
                                            delete_checklist_WB(
                                                arr_check_list[i]['checklistId']
                                                    .toString());
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey,
                          )
                        ]
                      ],
                    ),
                  ),
                ),
        ),
        InkWell(
          onTap: () {
            print('full');
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            height: 100,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    print('12');
                    push_to_create_check_list(context);
                  },
                ),
                Text(
                  'Add check list',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Column tab_4_notes_UI() {
    return Column(
      children: [
        //
        task_header_UI(context),
        //
        Expanded(
          child: (str_main_loader == 'notes_loader_start')
              ? const CustomeLoaderPopUp(
                  str_custom_loader: 'please wait...', str_status: '3')
              : Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        for (int i = 0; i < arr_notes_list.length; i++) ...[
                          Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10,
                            ),
                            // height: 60,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      //
                                      arr_notes_list[i]['message'].toString(),
                                      style: TextStyle(
                                        fontFamily: font_style_name,
                                        fontSize: 16.0,
                                      ),

                                      //
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(
                                    right: 0.0,
                                  ),
                                  height: 50,
                                  width: 120,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            push_to_edit_task(
                                              context,
                                              arr_notes_list[i]['message']
                                                  .toString(),
                                              arr_notes_list[i]['noteId']
                                                  .toString(),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: IconButton(
                                          onPressed: () {
                                            delete_notes_WB(arr_notes_list[i]
                                                    ['noteId']
                                                .toString());
                                          },
                                          icon: Icon(
                                            Icons.cancel,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey,
                          )
                        ]
                      ],
                    ),
                  ),
                ),
        ),
        InkWell(
          onTap: () {
            print('full');
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            height: 100,
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    print('12');

                    //
                    push_to_create_notes(context);
                  },
                ),
                Text(
                  'Add Notes',
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  SingleChildScrollView tab_2_agent_UI() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //
          task_header_UI(context),
          //
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: arr_agents.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  print('object');
                  // print(arr_sub_goals);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 0.0,
                  ),
                  height: 80,
                  color: Colors.transparent,
                  child: ListTile(
                    // iconColor: Colors.pink,
                    leading: (arr_agents[index]['From_profile_picture']
                                .toString() ==
                            '')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset(
                              'assets/images/logo.png',
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loader.gif',
                              image: arr_agents[index]['From_profile_picture']
                                  .toString(),
                            ),
                          ),

                    title: Text(
                      //
                      arr_agents[index]['To_userName'].toString(),

                      //
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      //
                      arr_agents[index]['From_userAddress'].toString(),

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
                    ),
                    trailing: Column(
                      children: [
                        if ((arr_agents[index]['status'].toString()) == '1')
                          Container(
                            height: 40,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  25.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                //
                                'Pending',
                                // arr_agents[index]['deadline'].toString()),
                                //
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        else if ((arr_agents[index]['status'].toString()) ==
                            '2')
                          Container(
                            height: 40,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  25.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                //
                                'Chat',
                                //
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                        else
                          Container(
                            height: 40,
                            width: 100,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  25.0,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                //
                                'Decline',
                                // arr_agents[index]['deadline'].toString()),
                                //
                                style: TextStyle(
                                  fontFamily: font_style_name,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

// tab 1
  Column tab_1_rewards_UI(BuildContext context) {
    return Column(
      children: [
        //
        task_header_UI(context),
        //
        Container(
          margin: const EdgeInsets.all(12),
          // height: 200 - 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      top: 20.0,
                    ),
                    child: Text(
                      'Experience :',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 20.0,
                      top: 20.0,
                    ),
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        //
                        widget.str_experince.toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //
              //
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      top: 20.0,
                      bottom: 20,
                    ),
                    child: Text(
                      'Deduct Experince :',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 20.0,
                      top: 20.0,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                    ),
                    height: 30,
                    width: 60,
                    child: Center(
                      child: Text(
                        //
                        widget.str_deduct_experince.toString(),
                        //
                        style: TextStyle(
                          fontFamily: font_style_name,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              //
              //
              /*const SizedBox(
                height: 20,
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey,
              ),*/
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20.0,
                      top: 20.0,
                    ),
                    child: Text(
                      'Experince :',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 20.0,
                      top: 20.0,
                    ),
                    child: Text(
                      'data',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ],
    );
  }

  Container task_header_UI(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(
            0.0,
          ),
        ),
        image: DecorationImage(
          image: AssetImage(
            // image name
            'assets/images/task_bg.png',
          ),
          fit: BoxFit.cover,
          //opacity: .4,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            //
            widget.str_task_name.toString(),
            //
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          Container(
            height: 40,
            width: 140,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(
                250,
                180,
                12,
                1,
              ),
              borderRadius: BorderRadius.circular(
                14.0,
              ),
            ),
            child: Align(
              child: Text(
                //
                func_difference_between_date(
                  widget.str_due_date.toString(),
                ),
                //
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  func_get_task_list_WB() async {
    print('=====> POST : TASKS LIST');

    str_main_loader = 'start';
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
          'action': 'invitelist',
          'profesionalId': widget.str_professional_id.toString(),
          // 'profesionalId': '54',
          'profesionalType': 'Task',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        // get and parse data
        //
        arr_agents.clear();
        //
        for (var i = 0; i < get_data['data'].length; i++) {
          // print(get_data['data'][i]);
          arr_agents.add(get_data['data'][i]);
        }

        if (arr_agents.isEmpty) {
          // str_goal_loader = '1';
        } else {
          // str_goal_loader = '2';
        }

        // str_task_count = arr_task_list.length.toString();

        str_main_loader = 'stop';
        setState(() {});

        func_notes_WB();
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

  Future<void> push_to_create_check_list(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateCheckListScreen(
          str_professional_type: 'Task'.toString(),
          str_professional_id: widget.str_professional_id.toString(),
          str_edit_status: '1',
          str_check_list_id: 'n.a.',
          str_message: '',
        ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

// back_from_create_checklist

    if (!mounted) return;

    // if (result)
    func_check_list_WB();
    // setState(() {});
  }

  func_notes_WB() async {
    print('=====> POST : NOTES 1');

    setState(() {
      str_main_loader = 'notes_loader_start';
    });
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'notelist',
          // 'userId': prefs.getInt('userId').toString(),
          'pageNo': '',
          'profesionalId': widget.str_professional_id.toString(),
          'profesionalType': 'Task',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_notes_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          // print('object');

          arr_notes_list.add(i);
        }

        setState(() {
          str_main_loader = 'notes_loader_stop';
        });
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  func_check_list_WB() async {
    print('=====> POST : CHECKLIST');

    str_main_loader = 'checklist_loader_start';

    setState(() {});
    //
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'action': 'checklist',
          'pageNo': '',
          'profesionalId': widget.str_professional_id.toString(),
          'profesionalType': 'Task',
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);
    // print(get_data['data'][0]['id']);
    if (resposne.statusCode == 200) {
      //
      arr_check_list.clear();
      //
      if (get_data['status'].toString().toLowerCase() == 'success') {
        for (Map i in get_data['data']) {
          // print('object');

          arr_check_list.add(i);
        }

        setState(() {
          str_main_loader = 'checklist_loader_stop';
        });
      } else {
        print(
          '====> SOMETHING WENT WRONG IN "addcart" WEBSERVICE. PLEASE CONTACT ADMIN',
        );
      }
    } else {
      // return postList;
    }
  }

  Future<void> push_to_create_notes(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNotesInGoalScreen(
          str_profession_id: widget.str_professional_id.toString(),
          str_profession_type: 'Task',
        ),
        // str_professional_type: 'Task'.toString(),
        // str_professional_id:
        //  widget.str_professional_id.toString(),
        // ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

// get_back_from_add_notes

    if (!mounted) return;

    // if (result)
    func_notes_WB();
    // setState(() {});
  }

  Future<void> push_to_edit_checklist(
    BuildContext context,
    String str_checklist_id,
    String str_messages,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateCheckListScreen(
          str_professional_type: 'Task'.toString(),
          str_professional_id: widget.str_professional_id.toString(),
          str_edit_status: '2',
          str_check_list_id: str_checklist_id.toString(),
          str_message: str_messages.toString(),
        ),
      ),
    );

    // ignore: prefer_interpolation_to_compose_strings
    print('result =====> ' + result);

// get_back_from_add_notes

    if (!mounted) return;

    // if (result)
    func_check_list_WB();
    // setState(() {});
  }

  Future<void> push_to_edit_task(
    BuildContext context,
    String str_message,
    String str_note_id,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNotesInGoalScreen(
          str_message: str_message,
          str_note_id: str_note_id.toString(),
          str_professional_id: widget.str_professional_id.toString(),
          str_professional_type: 'Task'.toString(),
        ),
      ),
    );

    // print('result =====> ' + result);

    if (!mounted) return;

    if ('$result' == 'get_back_from_edit_notes') {
      arr_notes_list.clear();
      setState(() {
        func_notes_WB();
      });
    }
  }

  // delete note
  delete_notes_WB(
    String note_id,
  ) async {
    print('=====> POST : DELETE NOTES');

    // str_notes_loader_status = '0';
    setState(() {});

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
          'action': 'notedelete',
          'userId': prefs.getInt('userId').toString(),
          'noteId': note_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_notes_list = [];
        //
        func_notes_WB();
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

  // delete checklist
  delete_checklist_WB(
    String note_id,
  ) async {
    print('=====> POST : DELETE CHECKLIST');

    // str_notes_loader_status = '0';
    // setState(() {});

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
          'action': 'checklistdelete',
          'userId': prefs.getInt('userId').toString(),
          'checklistId': note_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        arr_notes_list = [];
        //
        func_check_list_WB();
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

  // ALERT
  Future<void> _showMyDialog(
    String str_message,
    String str_delete_task_id,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete',
            style: TextStyle(
              fontFamily: font_style_name,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  //
                  str_message,
                  //
                  style: TextStyle(
                    fontFamily: font_style_name,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Dismiss',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'yes,delete',
                style: TextStyle(
                  fontFamily: font_style_name,
                  fontSize: 16.0,
                  color: Colors.red,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                delete_task_WB(
                  str_delete_task_id,
                );
              },
            ),
          ],
        );
      },
    );
  }

  // delete task
  delete_task_WB(
    String str_task_id,
  ) async {
    print('=====> POST : DELETE TASK');

    const snackBar = SnackBar(
      content: Text('deleting...'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    ///
    ///
    ///
    ///
    // str_task_in_team = '2';
    str_main_loader = 'tasks_loader_start';
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
          'action': 'taskdelete',
          'userId': prefs.getInt('userId').toString(),
          'taskId': str_task_id.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //

        Navigator.pop(context, 'back_from_delete_task');
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

  // how many days left
  func_difference_between_date(String get_date) {
    String regex = '-';
    var full_date =
        get_date.substring(0, 10).replaceAll(RegExp(regex, unicode: true), '');

    var year = full_date.substring(0, 4);
    var month = full_date.substring(4, 6);
    var day = full_date.substring(6, 8);

    var year_to_int = int.parse(year);
    var month_to_int = int.parse(month);
    var day_to_int = int.parse(day);

    final birthday = DateTime(year_to_int, month_to_int, day_to_int);
    // final birthday = DateTime(2021, 12, 10);
    final date2 = DateTime.now();
    final difference = birthday.difference(date2).inDays;
    //
    if (difference.toString().substring(0, 1) == '-') {
      // var str_overdue = difference.toString();
      return 'overdue';
    } else {
      return '$difference days left';
    }
  }
}
