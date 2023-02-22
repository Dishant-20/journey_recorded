// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/single_classes/custom_loader/custom_loader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuildScreen extends StatefulWidget {
  const GuildScreen({super.key});

  @override
  State<GuildScreen> createState() => _GuildScreenState();
}

class _GuildScreenState extends State<GuildScreen> {
  //
  ImagePicker picker = ImagePicker();
  XFile? image;
  File? imageFile;
  //
  var str_save_and_continue_loader = '0';
  //
  final _formKey = GlobalKey<FormState>();
  //
  TextEditingController cont_search = TextEditingController();
  //
  late final TextEditingController cont_name_your_guild;
  late final TextEditingController cont_subject_of_guild;
  late final TextEditingController cont_create_access_code;
  late final TextEditingController cont_max_member;
  late final TextEditingController cont_creator_name;
  late final TextEditingController cont_miles_radius;
  late final TextEditingController cont_describe;

  late final TextEditingController cont_donation;
  late final TextEditingController cont_how_will_you;
  late final TextEditingController cont_write_10;

  //

  @override
  void initState() {
    super.initState();
    //
    cont_name_your_guild = TextEditingController();
    cont_subject_of_guild = TextEditingController();
    cont_create_access_code = TextEditingController();
    cont_max_member = TextEditingController();
    cont_creator_name = TextEditingController();
    cont_miles_radius = TextEditingController();
    cont_describe = TextEditingController();

    cont_donation = TextEditingController();
    cont_how_will_you = TextEditingController();
    cont_write_10 = TextEditingController();
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
            }),
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //
              Center(
                child: InkWell(
                  onTap: () {
                    //
                    _showActionSheet_for_camera_gallery(context);
                    //
                  },
                  child: imageFile == null
                      ? Container(
                          margin: const EdgeInsets.all(10.0),
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              0,
                            ),
                            border: Border.all(),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.all(10.0),
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              14.0,
                            ),
                            border: Border.all(),
                          ),
                          child: Image.file(
                            fit: BoxFit.cover,
                            imageFile!,
                            height: 150.0,
                            width: 100.0,
                          ),
                        ),
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_name_your_guild,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name Your Guild',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name your guild';
                    }
                    return null;
                  },
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_subject_of_guild,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Subject of Guild',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Subject of Guild';
                    }
                    return null;
                  },
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_create_access_code,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Create Access Code',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Create Access Code';
                    }
                    return null;
                  },
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_max_member,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Max Member',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Max Member';
                    }
                    return null;
                  },
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_creator_name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Creator Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Creator Name';
                    }
                    return null;
                  },
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_miles_radius,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Miles Radius from your Location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Miles Radius';
                    }
                    return null;
                  },
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_describe,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Describe the purpose of this guild in details.',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_donation,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Donation Required',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },
                  maxLines: 1,
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_how_will_you,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText:
                        'How will you benifit from being a member from this guild',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter How will you benifit from being a member from this guild.';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
              ),
              //
              Container(
                margin: const EdgeInsets.all(
                  10.0,
                ),
                child: TextFormField(
                  readOnly: false,
                  onTap: () {
                    if (kDebugMode) {
                      print('group name click');
                    }
                  },
                  controller: cont_write_10,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Write 10 words used for searching this guild.',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Write 10 words used for searching this guild.';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
              ),
              //
              (str_save_and_continue_loader == '1')
                  ? const CustomeLoaderPopUp(
                      str_custom_loader: 'please wait...',
                      str_status: '3',
                    )
                  : InkWell(
                      onTap: () {
                        //
                        if (_formKey.currentState!.validate()) {
                          if (kDebugMode) {
                            print('value all fill now');
                          }
                          //
                          func_create_guild_WB();
                          //
                        }
                        //
                      },
                      child: Container(
                        margin: const EdgeInsets.all(
                          10.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ),
                          color: navigation_color,
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
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // create guild
  func_create_guild_WB() async {
    print('object');

    setState(() {
      str_save_and_continue_loader = '1';
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getInt('userId').toString());
    final resposne = await http.post(
      Uri.parse(
        application_base_url,
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

      /*
      action: gulidadd
userId:
name:
subject:
accessCode:
maxNumber:
createrName:
miles:
Description:
Donation:
searchKey:
benefit:
      */
      body: jsonEncode(
        <String, String>{
          'action': 'gulidadd',
          'userId': prefs.getInt('userId').toString(),
          'name': cont_name_your_guild.text.toString(),
          'subject': cont_subject_of_guild.text.toString(),
          'accessCode': cont_create_access_code.text.toString(),
          'maxNumber': cont_max_member.text.toString(),
          'createrName': cont_creator_name.text.toString(),
          'miles': cont_miles_radius.text.toString(),
          'Description': cont_describe.text.toString(),
          'Donation': cont_donation.text.toString(),
          'searchKey': cont_write_10.text.toString(),
          'benefit': cont_how_will_you.text.toString(),
        },
      ),
    );

    // convert data to dict
    var get_data = jsonDecode(resposne.body);
    print(get_data);

    if (resposne.statusCode == 200) {
      if (get_data['status'].toString().toLowerCase() == 'success') {
        //
        setState(() {
          str_save_and_continue_loader = '0';
        });
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

  //
  //
  void _showActionSheet_for_camera_gallery(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Camera option'),
        // message: const Text(''),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.camera,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  imageFile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Camera',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);

              // ignore: deprecated_member_use
              PickedFile? pickedFile = await ImagePicker().getImage(
                source: ImageSource.gallery,
                maxWidth: 1800,
                maxHeight: 1800,
              );
              if (pickedFile != null) {
                setState(() {
                  print('object');
                  imageFile = File(pickedFile.path);
                });
              }
            },
            child: Text(
              'Open Gallery',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Dismiss',
              style: TextStyle(
                fontFamily: font_style_name,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
  //
}
