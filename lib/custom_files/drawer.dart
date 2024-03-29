// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:journey_recorded/Utils.dart';
import 'package:journey_recorded/dashboard/dashboard.dart';
import 'package:journey_recorded/edit_profile/edit_profile.dart';
import 'package:journey_recorded/login/login.dart';
// import 'package:journey_recorded/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class navigationDrawer extends StatefulWidget {
  const navigationDrawer({Key? key}) : super(key: key);

  @override
  State<navigationDrawer> createState() => _navigationDrawerState();
}

class _navigationDrawerState extends State<navigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: navigation_color,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(
              252,
              118,
              10,
              1,
            ),
            child: const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '',
              ),
            ),
          ),
          Container(
            // 33 237 244
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromRGBO(
              33,
              237,
              244,
              1,
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'REQUESTER',
                      style: TextStyle(
                        fontFamily: font_style_name,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: 200,
            // color: Colors.brown,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(
                252,
                118,
                10,
                1,
              ),
              // image: const DecorationImage(
              //   image: AssetImage(
              //     // image name
              //     'assets/images/login_back.png',
              //   ),
              //   fit: BoxFit.fitHeight,
              //   opacity: .4,
              // ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  iconColor: Colors.white,
                  title: Text(
                    'Dashboard',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    print('1.1.1');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );

                    // Update the state of the app
                    // ...
                    // Then close the drawrer
                    // Navigator.pop(context);
                  },
                ),
                /*ListTile(
                  leading: const Icon(
                    Icons.list_alt,
                  ),
                  iconColor: Colors.white,
                  title: Text(
                    'Categories',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    print('1.1.1');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const DashboardScreen(
                    //       get_login_sender_chat_id: 'Dashboard',
                    //     ),
                    //   ),
                    // );

                    // Update the state of the app
                    // ...
                    // Then close the drawrer
                    // Navigator.pop(context);
                  },
                ),*/
                /*ListTile(
                  leading: const Icon(
                    Icons.filter_alt,
                  ),
                  trailing: const Icon(
                    Icons.add,
                  ),
                  iconColor: Colors.white,
                  title: Text(
                    'Filters',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),*/
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                  ),
                  iconColor: Colors.white,
                  title: Text(
                    'Edit profile',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(
                            // get_login_sender_chat_id: 'Dashboard',
                            ),
                      ),
                    );
                    // Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.question_answer,
                  ),
                  iconColor: Colors.white,
                  title: Text(
                    'Q/A',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.help,
                  ),
                  iconColor: Colors.white,
                  title: Text(
                    'Help',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.language,
                  ),
                  iconColor: Colors.white,
                  title: Text(
                    'Language',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                  ),
                  iconColor: Colors.white,
                  title: Text(
                    'Account Settings',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  iconColor: Colors.white,
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      fontFamily: font_style_name,
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onTap: () async {
                    // Update the state of the app
                    // ...
                    // Then close the drawer

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
