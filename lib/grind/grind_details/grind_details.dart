import 'package:flutter/material.dart';
import 'package:journey_recorded/custom_files/app_bar/app_bar.dart';

class GrindDetailsScreen extends StatefulWidget {
  const GrindDetailsScreen({super.key});

  @override
  State<GrindDetailsScreen> createState() => _GrindDetailsScreenState();
}

class _GrindDetailsScreenState extends State<GrindDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        str_app_bar_title: 'Grind Details',
        str_back_button_status: '1',
      ),
    );
  }
}
