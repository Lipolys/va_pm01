import 'package:bikeapi/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart';

import '../../../main.dart';

class UpdateBikePage extends StatefulWidget {
  const UpdateBikePage({super.key});

  @override
  State<UpdateBikePage> createState() => _UpdateBikePageState();
}

class _UpdateBikePageState extends State<UpdateBikePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _modelNumberController;
  late TextEditingController _descriptionController;
  late TextEditingController _manufactureDateController;
  bool _isMountainBike = false;
  double? _selectedWheelSize;
  double? _selectedFrameSize;

  final List<double> _mountainBikeWheelSizes = [26, 27.5, 29];
  final List<double> _mountainBikeFrameSizes = [14.5, 15, 15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20, 20.5, 21];
  final List<double> _speedBikeWheelSizes = [29];
  final List<double> _speedBikeFrameSizes = [46, 48, 50, 52, 54, 56, 58, 59];

  List<double> get _currentWheelSizes =>
      _isMountainBike ? _mountainBikeWheelSizes : _speedBikeWheelSizes;

  List<double> get _currentFrameSizes =>
      _isMountainBike ? _mountainBikeFrameSizes : _speedBikeFrameSizes;

  bool _loading = true;
  BikeDTO? _bike;

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
          const SnackBar(content: Text('ID da bicicleta inválido.')),
        );
        Routefly.pop(context);
      }
      return;
    }
    final bike = await bikeApi.getById(id);
    if (bike == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bicicleta não encontrada.')),
        );
        Routefly.pop(context);
      }
      return;
    }
    _bike = bike;
    _modelNumberController = TextEditingController(text: bike.partNumber ?? '');
    _descriptionController = TextEditingController(text: bike.description ?? '');
    _manufactureDateController = TextEditingController(
      text: bike.manufacturedDate?.toIso8601String().split('T').first ?? '',
    );
    _isMountainBike = bike.isMTB ?? false;
    _selectedWheelSize = bike.sizeWheel;
    _selectedFrameSize = bike.sizeFrame;
    setState(() {
      _loading = false;
    });
  }

  @override
  void dispose() {
    _modelNumberController.dispose();
    _descriptionController.dispose();
    _manufactureDateController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final appApi = Provider.of<AppApi>(context, listen: false);
      final bikeApi = BikeControllerApi(appApi.api);

      final existingBikes = await bikeApi.listAll() ?? [];
      final modelNumber = _modelNumberController.text;
      final isDuplicate = existingBikes.any((bike) =>
      bike.partNumber == modelNumber && bike.id != _bike!.id);

      if (isDuplicate) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Já existe uma bicicleta com este número de modelo.')),
          );
        }
        return;
      }

      final updateDto = UpdateBikeDTO(
        partNumber: modelNumber,
        description: _descriptionController.text,
        sizeFrame: _selectedFrameSize,
        sizeWheel: _selectedWheelSize,
        isMTB: _isMountainBike,
        manufacturedDate: DateTime.tryParse(_manufactureDateController.text),
      );

      try {
        final updatedBike = await bikeApi.update(_bike!.id!, updateDto);
        if (updatedBike != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bicicleta atualizada com sucesso!')),
          );
          Routefly.pop(context);
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Falha ao atualizar a bicicleta.')),
          );
        }
      } on ApiException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro na API: ${e.message}')),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro inesperado: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atualizar Bicicleta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _modelNumberController,
                  decoration: const InputDecoration(labelText: 'Número do Modelo (Número da Peça)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o número do modelo.';
                    }
                    final numericRegex = RegExp(r'^\d+$');
                    if (!numericRegex.hasMatch(value)) {
                      return 'O número do modelo deve conter apenas números.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                  maxLength: 500,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a descrição.';
                    }
                    if (value.length > 500) {
                      return 'A descrição não pode exceder 500 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _manufactureDateController,
                  decoration: const InputDecoration(
                    labelText: 'Data de Fabricação (AAAA-MM-DD)',
                    hintText: 'Ex: 2023-10-27',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data de fabricação.';
                    }
                    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                    if (!dateRegex.hasMatch(value)) {
                      return 'Formato inválido. Use AAAA-MM-DD.';
                    }
                    final date = DateTime.tryParse(value);
                    if (date == null) {
                      return 'Data inválida.';
                    }
                    return null;
                  },
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.tryParse(_manufactureDateController.text) ?? DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());

                    String formattedDate = "${pickedDate?.year.toString().padLeft(4, '0')}-${pickedDate?.month.toString().padLeft(2, '0')}-${pickedDate?.day.toString().padLeft(2, '0')}";
                    setState(() {
                      _manufactureDateController.text = formattedDate;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('É uma Mountain Bike?'),
                    Switch(
                      value: _isMountainBike,
                      onChanged: (value) {
                        setState(() {
                          _isMountainBike = value;
                          _selectedWheelSize = _currentWheelSizes.contains(_selectedWheelSize) ? _selectedWheelSize : null;
                          _selectedFrameSize = _currentFrameSizes.contains(_selectedFrameSize) ? _selectedFrameSize : null;
                          if (!_currentWheelSizes.contains(_selectedWheelSize)) _selectedWheelSize = null;
                          if (!_currentFrameSizes.contains(_selectedFrameSize)) _selectedFrameSize = null;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<double>(
                  value: _selectedWheelSize,
                  items: _currentWheelSizes
                      .map((size) => DropdownMenuItem(
                    value: size,
                    child: Text('$size"'),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedWheelSize = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Tamanho da Roda'),
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione o tamanho da roda.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<double>(
                  value: _selectedFrameSize,
                  items: _currentFrameSizes
                      .map((size) => DropdownMenuItem(
                    value: size,
                    child: Text('$size'),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedFrameSize = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Tamanho do Quadro'),
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor, selecione o tamanho do quadro.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Routefly.pop(context);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}