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
            title: const Text('Página Inicial'),
            onTap: () {
              Routefly.push('/lib/app');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Incluir'),
            onTap: () {
              Routefly.push('/bike/create');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () {
              Routefly.push('/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('Contato'),
            onTap: () {
              Routefly.push('/contact');
            },
          ),
        ],
      ),
    );
  }
}