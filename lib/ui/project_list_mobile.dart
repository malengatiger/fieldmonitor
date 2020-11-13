import 'package:flutter/material.dart';
import 'package:monitorlibrary/functions.dart';

class ProjectListMobile extends StatefulWidget {
  @override
  _ProjectListMobileState createState() => _ProjectListMobileState();
}

class _ProjectListMobileState extends State<ProjectListMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Projects',
            style: Styles.whiteSmall,
          ),
        ),
        body: Center(
          child: Container(
            color: Colors.brown[100],
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Project List',
                style: Styles.blackBoldMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
