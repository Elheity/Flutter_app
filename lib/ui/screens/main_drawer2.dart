import 'package:flutter/material.dart';

class MainDrawer2 extends StatelessWidget {
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
          color: Colors.orange[500],
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "CookUP!",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildList("Meals", Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('customer');
          }),
          buildList("Back to Intro Screen", Icons.logout, () {
            Navigator.of(context).pushReplacementNamed('intro');
          }),
        ],
      ),
    );
  }
}
