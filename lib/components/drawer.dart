import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return (Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            accountName: Text(
              "Zanas",
              style: TextStyle(),
            ),
            accountEmail: Text(
              "zanas.kovaliovas@gmail.com",
              style: TextStyle(),
            ),
            currentAccountPicture: Icon(
              Icons.account_box_outlined,
              size: 85,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.call_rounded,
            ),
            title: const Text('Calls'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.history,
            ),
            title: const Text('History page'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/history");
            },
          ),
        ],
      ),
    ));
  }
}
