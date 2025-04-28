import 'package:bikeapi/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';

import '../main.dart';

class BikeListPage extends StatefulWidget {
  const BikeListPage({super.key});

  @override
  State<BikeListPage> createState() => _BikeListPageState();
}

class _BikeListPageState extends State<BikeListPage> {
  late Future<List<BikeDTO>?> _bikesFuture;

  @override
  void initState() {
    super.initState();
    final appApi = Provider.of<AppApi>(context, listen: false);
    final bikeApi = BikeControllerApi(appApi.api);
    _bikesFuture = bikeApi.listAll();
  }

  Future<void> _refresh() async {
    final appApi = Provider.of<AppApi>(context, listen: false);
    final bikeApi = BikeControllerApi(appApi.api);
    setState(() {
      _bikesFuture = bikeApi.listAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Bicicletas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Routefly.push('/bike/create/create_page.dart');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<BikeDTO>?>(
        future: _bikesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar bicicletas: ${snapshot.error}'));
          }
          final bikes = snapshot.data ?? [];
          if (bikes.isEmpty) {
            return const Center(child: Text('Nenhuma bicicleta cadastrada.'));
          }
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: bikes.length,
              itemBuilder: (context, index) {
                final bike = bikes[index];
                return ListTile(
                  title: Text(bike.partNumber ?? 'Sem modelo'),
                  subtitle: Text(bike.description ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Implementar navegação para edição
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Implementar exclusão
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}