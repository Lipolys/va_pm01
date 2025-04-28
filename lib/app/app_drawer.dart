import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
              Routefly.pushNavigate('/lib/app');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Bike'),
            onTap: () {
              Routefly.push('/bike/create');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Routefly.push('/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contact'),
            onTap: () {
              Routefly.push('/contact');
            },
          ),
        ],
      ),
    );
  }
}