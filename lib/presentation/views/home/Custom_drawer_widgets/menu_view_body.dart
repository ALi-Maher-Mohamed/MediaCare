import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MenuViewBody extends StatelessWidget {
  const MenuViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        CircleAvatar(
          backgroundImage: Image.asset(
            'assets/images/Ali1.jpg',
            fit: BoxFit.fitHeight,
          ).image,
          radius: 100,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Ali Maher',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'باشا البلد @example.com',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text(
              'Home',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.help,
            color: Colors.black,
          ),
          title: Text(
            'Help',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.black,
          ),
          title: Text(
            'Logout',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
