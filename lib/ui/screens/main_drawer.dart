import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/services/auth.dart';

class MainDrawer extends StatelessWidget {
  Widget buildList(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthBase authBase = AuthBase();
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            color: Colors.black,
            child: Text(
              'Menu!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildList("Coures", Icons.video_camera_back, () {
            Navigator.of(context).pushReplacementNamed('home');
          }),
          buildList("Log Out", Icons.logout, () async {
            await authBase.logout();
            Navigator.of(context).pushReplacementNamed('intro');
          }),
          buildList("Create anew Account", Icons.account_circle, () {
            Navigator.of(context).pushReplacementNamed('register');
          }),
          buildList("Info", Icons.info, () {
            Navigator.of(context).pushReplacementNamed('info');
          }),
        ],
      ),
    );
  }
}
