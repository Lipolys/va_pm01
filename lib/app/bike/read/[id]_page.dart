import 'package:bikeapi/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';

import '../../../main.dart';

class BikeDetailPage extends StatefulWidget {
  const BikeDetailPage({super.key});

  @override
  State<BikeDetailPage> createState() => _BikeDetailPageState();
}

class _BikeDetailPageState extends State<BikeDetailPage> {
  BikeDTO? _bike;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchBike();
  }

  Future<void> _fetchBike() async {
    final appApi = Provider.of<AppApi>(context, listen: false);
    final bikeApi = BikeControllerApi(appApi.api);
    final idParam = Routefly.query['id'];
    final int? id = idParam is int ? idParam : int.tryParse(idParam?.toString() ?? '');
    if (id == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid ID.')),
        );
        Routefly.pop(context);
      }
      return;
    }
    final bike = await bikeApi.getById(id);
    if (bike == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bike not found.')),
        );
        Routefly.pop(context);
      }
      return;
    }
    setState(() {
      _bike = bike;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Bike Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _bike == null
            ? const Text('Bike not found.')
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Model Number: ${_bike!.partNumber}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Description: ${_bike!.description ?? ""}'),
            const SizedBox(height: 8),
            Text('Frame Size: ${_bike!.sizeFrame ?? ""}'),
            const SizedBox(height: 8),
            Text('Wheel Size: ${_bike!.sizeWheel ?? ""}'),
            const SizedBox(height: 8),
            Text('Mountain Bike: ${_bike!.isMTB == true ? "Yes" : "No"}'),
            const SizedBox(height: 8),
            Text('Manufacture Date: ${_bike!.manufacturedDate?.toIso8601String().split("T").first ?? ""}'),
          ],
        ),
      ),
    );
  }
}