import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../models/folded_call_log.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            accountName: Text(
              "Zanas",
              style: TextStyle(),
            ),
            accountEmail: Text(
              "zanas.kovaliovas@gmail.com",
              style: TextStyle(),
            ),
            currentAccountPicture: Icon(Icons.account_box_outlined, size: 85,),
          ),
          ListTile(
            leading: Icon(
              Icons.call_rounded,
            ),
            title: const Text('Calls'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.history,
            ),
            title: const Text('History page'),
            onTap: () {
              // Update the state of the app.
              // ...
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ));
  }
}
