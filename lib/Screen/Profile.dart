import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zuci/callScreen/pickup/pickup_layout.dart';
import 'package:zuci/provider/user_provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  UserProvider userProvider;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.refreshUser();
    });

  }
  
  
  @override
  Widget build(BuildContext context) {
    return PickupLayout(
        scaffold: Scaffold(
          body: Center(
            child: Text('${userProvider.getUser}'),

          ),
    ));
  }
}
