import 'package:fieldmonitor/ui/project_detail/project_detail_main.dart';
import 'package:flutter/material.dart';
import 'package:monitorlibrary/camera/example.dart';
import 'package:monitorlibrary/data/project.dart';
import 'package:monitorlibrary/functions.dart';
import 'package:monitorlibrary/location/loc_bloc.dart';
import 'package:monitorlibrary/snack.dart';
import 'package:page_transition/page_transition.dart';

class ProjectDetailMobile extends StatefulWidget {
  final Project project;

  ProjectDetailMobile(this.project);

  @override
  _ProjectDetailMobileState createState() => _ProjectDetailMobileState();
}

class _ProjectDetailMobileState extends State<ProjectDetailMobile>
    with SingleTickerProviderStateMixin
    implements ProjectDetailBase {
  AnimationController _controller;
  var isBusy = false;
  var _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    pp(' 🌸 🌸 ProjectDetailMobile: initState  🌸 🌸 '
        '${widget.project.name} ${widget.project.organizationName}');
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
        key: _key,
        appBar: AppBar(
          title: Text(widget.project.organizationName,
              style: Styles.whiteBoldSmall),
          bottom: PreferredSize(
            child: Column(
              children: [
                Text(widget.project.name, style: Styles.blackBoldSmall),
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Shit to do with the project',
                  style: Styles.whiteSmall,
                ),
                SizedBox(
                  height: 48,
                ),
              ],
            ),
            preferredSize: Size.fromHeight(240),
          ),
        ),
        backgroundColor: Colors.brown[100],
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  Text('Start Monitoring this project using Photos and Videos'),
                  SizedBox(
                    height: 24,
                  ),
                  RaisedButton(
                    onPressed: _startMonitoring,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Start Monitor',
                        style: Styles.whiteSmall,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  isBusy
                      ? Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                backgroundColor: Colors.yellowAccent,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Checking project location',
                              style: Styles.blackTiny,
                            )
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  listMonitorReports() {
    // TODO: implement listMonitorReports
    throw UnimplementedError();
  }

  @override
  listNearestCities() {
    // TODO: implement listNearestCities
    throw UnimplementedError();
  }

  @override
  startProjectMonitoring() {
    // TODO: implement startProjectMonitoring
    throw UnimplementedError();
  }

  @override
  updateProject() {
    // TODO: implement updateProject
    throw UnimplementedError();
  }

  void _startMonitoring() async {
    pp('🍏 🍏 Start Monitoring this project after checking that the device is within 500 metres of a project point');
    setState(() {
      isBusy = true;
    });

    var distance = await locationBloc.getDistanceFromCurrentPosition(
        latitude: widget.project.position.coordinates[1],
        longitude: widget.project.position.coordinates[0]);

    pp("🍏 🍏 🍏 App is ${distance.toStringAsFixed(1)} metres from the project point");
    if (widget.project.monitorMaxDistanceInMetres != null) {
      if (distance > widget.project.monitorMaxDistanceInMetres) {
        pp("🔆🔆🔆 App is ${distance.toStringAsFixed(1)} metres is greater than allowed project.monitorMaxDistanceInMetres: "
            "🍎 ${widget.project.monitorMaxDistanceInMetres} metres");
        AppSnackbar.showErrorSnackbar(
            scaffoldKey: _key,
            actionLabel: '',
            message:
                "You are too far from the project for monitoring to work properly");
        setState(() {
          isBusy = false;
        });
      } else {
        pp('🌸 🌸 🌸 The app is within the allowable project.monitorMaxDistanceInMetres of ${widget.project.monitorMaxDistanceInMetres} metres .'
            ' 🍎 Distance to project is ${distance.toStringAsFixed(1)} metres');
        _navigateToCameraHome();
      }
    } else {
      if (distance > 200.0) {
        pp("🔆🔆🔆 App is ${distance.toStringAsFixed(1)} metres is greater than allowed max default of 200.0 metres");
        setState(() {
          isBusy = false;
        });
      } else {
        pp('🌸 🌸 🌸 The app is within the allowable distance!${distance.toStringAsFixed(1)} metres');
        _navigateToCameraHome();
      }
    }
  }

  _navigateToCameraHome() async {
    var result = await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.topLeft,
            duration: Duration(seconds: 1),
            child: CameraHome(project: widget.project)));
  }
}
