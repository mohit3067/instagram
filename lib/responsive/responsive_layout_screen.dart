import 'package:flutter/material.dart';
import 'package:instagram/provides/user_provider.dart';
import 'package:instagram/util/global_variable.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  ResponsiveLayout(
      {required this.mobileScreenLayout, required this.webScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  void addData() async{
    UserProvider userProvider = Provider.of(context,listen: false);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < webScreensize) {
          return widget.mobileScreenLayout;
        }
        return widget.webScreenLayout;
      },
    );
  }
}
