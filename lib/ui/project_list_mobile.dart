import 'package:flutter/material.dart';
import 'package:monitorlibrary/api/sharedprefs.dart';
import 'package:monitorlibrary/bloc/theme_bloc.dart';
import 'package:monitorlibrary/data/user.dart';
import 'package:monitorlibrary/functions.dart';

class ProjectListMobile extends StatefulWidget {
  @override
  _ProjectListMobileState createState() => _ProjectListMobileState();
}

class _ProjectListMobileState extends State<ProjectListMobile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  User user;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _getUser();
  }

  void _getUser() async {
    user = await Prefs.getUser();
    setState(() {});
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
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                themeBloc.changeToRandomTheme();
              },
            )
          ],
          bottom: PreferredSize(
            child: Column(
              children: [
                Text(
                  user == null ? 'Field Monitor' : user.name,
                  style: Styles.whiteBoldMedium,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Field Monitor',
                  style: Styles.blackSmall,
                ),
                SizedBox(
                  height: 48,
                ),
              ],
            ),
            preferredSize: Size.fromHeight(240),
          ),
        ),
        body: Center(
          child: Container(
            color: Colors.brown[50],
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Project List',
                style: Styles.pinkBoldMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
