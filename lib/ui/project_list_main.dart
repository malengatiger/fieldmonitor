import 'package:fieldmonitor/ui/project_list_desktop.dart';
import 'package:fieldmonitor/ui/project_list_mobile.dart';
import 'package:fieldmonitor/ui/project_list_tablet.dart';
import 'package:flutter/material.dart';
import 'package:monitorlibrary/auth/app_auth.dart';
import 'package:monitorlibrary/functions.dart';
import 'package:monitorlibrary/ui/signin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProjectListMain extends StatefulWidget {
  final String type;

  ProjectListMain(this.type);

  @override
  _ProjectListMainState createState() => _ProjectListMainState();
}

class _ProjectListMainState extends State<ProjectListMain>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  var isBusy = false;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    setState(() {
      isBusy = true;
    });
    pp('🔐 🔐 🔐 🔐 ... Checking user ......');
    var signeIn = await AppAuth.isUserSignedIn();
    pp('ProjectList: 🥦🥦 is user signed in? $signeIn : 🔐 if false, go sign in ...');
    if (!signeIn) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.scale,
              alignment: Alignment.topLeft,
              duration: Duration(seconds: 1),
              child: SignIn(widget.type)));
    }
    setState(() {
      isBusy = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isBusy
        ? Center(
            child: Container(
              child: CircularProgressIndicator(
                strokeWidth: 8,
                backgroundColor: Colors.pink,
              ),
            ),
          )
        : ScreenTypeLayout(
            mobile: ProjectListMobile(),
            tablet: ProjectListTablet(),
            desktop: ProjectListDesktop(),
          );
  }
}
