import 'package:bikeapi/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';
import 'app_drawer.dart';

import '../main.dart';

class BikeListPage extends StatefulWidget {
  const BikeListPage({super.key});

  @override
  State<BikeListPage> createState() => _BikeListPageState();
}

class _BikeListPageState extends State<BikeListPage> {
  late Future<List<BikeDTO>?> _bikesFuture;
  int _currentPage = 0;
  static const int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _loadBikes();
  }

  void _loadBikes() {
    final appApi = Provider.of<AppApi>(context, listen: false);
    final bikeApi = BikeControllerApi(appApi.api);
    _bikesFuture = bikeApi.listAll();
  }

  Future<void> _refresh() async {
    setState(() {
      _currentPage = 0;
      _loadBikes();
    });
  }

  void _goToPage(int page, int totalPages) {
    if (page >= 0 && page < totalPages) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Bicicletas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Routefly.push('/bike/create');
              _refresh();
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
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
            return const Center(child: Text('Sem registro de bicicletas.'));
          }

          final totalPages = (bikes.length / _pageSize).ceil();
          final start = _currentPage * _pageSize;
          final end = (start + _pageSize) > bikes.length ? bikes.length : (start + _pageSize);
          final bikesPage = bikes.sublist(start, end);

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: bikesPage.length,
                    itemBuilder: (context, index) {
                      final bike = bikesPage[index];
                      return ListTile(
                        onTap: () async {
                          await Routefly.push('/bike/read/${bike.id}');
                        },
                        title: Text(bike.partNumber ?? 'Sem modelo'),
                        subtitle: Text(bike.description ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                await Routefly.push('/bike/update/${bike.id}');
                                _refresh();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Confirmar exclusão'),
                                    content: const Text('Tem certeza que deseja excluir esta bicicleta?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  ),
                                );
                                if (confirmed == true) {
                                  // Chame aqui a função de exclusão da bike
                                  // Exemplo:
                                  final appApi = Provider.of<AppApi>(context, listen: false);
                                  final bikeApi = BikeControllerApi(appApi.api);
                                  try {
                                    await bikeApi.remove(bike.id!);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Bicicleta excluída com sucesso!')),
                                      );
                                    }
                                    _refresh(); // Atualiza a lista
                                  } catch (e) {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Erro ao excluir: $e')),
                                      );
                                    }
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _currentPage > 0
                        ? () => _goToPage(_currentPage - 1, totalPages)
                        : null,
                  ),
                  Text('Page ${_currentPage + 1} of $totalPages'),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _currentPage < totalPages - 1
                        ? () => _goToPage(_currentPage + 1, totalPages)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          );
        },
      ),
    );
  }
}