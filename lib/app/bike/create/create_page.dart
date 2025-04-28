import 'package:bikeapi/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routefly/routefly.dart'; // Importar Routefly

import '../../../main.dart';


class CreateBikePage extends StatefulWidget {
  const CreateBikePage({super.key});

  @override
  State<CreateBikePage> createState() => _CreateBikePageState();
}

class _CreateBikePageState extends State<CreateBikePage> {
  final _formKey = GlobalKey<FormState>();
  final _modelNumberController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _manufactureDateController = TextEditingController();
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

      // Verifica se o número do modelo já existe
      final existingBikes = await bikeApi.listAll() ?? [];
      final modelNumber = _modelNumberController.text;
      final isDuplicate = existingBikes.any((bike) => bike.partNumber == modelNumber);

      if (isDuplicate) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Já existe uma bicicleta com este número de modelo.')),
          );
        }
        return; // Não prossegue com o cadastro
      }

      final createDto = CreateBikeDTO(
        partNumber: modelNumber,
        description: _descriptionController.text,
        sizeFrame: _selectedFrameSize,
        sizeWheel: _selectedWheelSize,
        isMTB: _isMountainBike,
        manufacturedDate: DateTime.tryParse(_manufactureDateController.text),
      );

      try {
        final createdBike = await bikeApi.create(createDto);
        if (createdBike != null && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bike criada com sucesso!')),
          );
          Routefly.pop(context);
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Falha ao criar a bike.')),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Bike'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView( // Adicionado para evitar overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _modelNumberController,
                  decoration: const InputDecoration(labelText: 'Model Number (Part Number)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the model number';
                    }
                    final numericRegex = RegExp(r'^\d+$');
                    if (!numericRegex.hasMatch(value)) {
                      return 'Model number must contain only numbers';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLength: 500,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    if (value.length > 500) {
                      return 'Description cannot exceed 500 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _manufactureDateController,
                  decoration: const InputDecoration(
                    labelText: 'Manufacture Date (YYYY-MM-DD)',
                    hintText: 'Ex: 2023-10-27',
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the manufacture date';
                    }
                    // Regex simples para validar o formato YYYY-MM-DD
                    final dateRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                    if (!dateRegex.hasMatch(value)) {
                      return 'Invalid format. Use YYYY-MM-DD';
                    }
                    final date = DateTime.tryParse(value);
                    if (date == null) {
                      return 'Invalid date';
                    }
                    return null;
                  },
                  onTap: () async {
                    // Ocultar teclado ao abrir o date picker
                    FocusScope.of(context).requestFocus(FocusNode());
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      String formattedDate = "${pickedDate.year.toString().padLeft(4, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                      setState(() {
                        _manufactureDateController.text = formattedDate;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Is Mountain Bike?'),
                    Switch(
                      value: _isMountainBike,
                      onChanged: (value) {
                        setState(() {
                          _isMountainBike = value;
                          // Resetar seleções ao mudar o tipo
                          _selectedWheelSize = _currentWheelSizes.contains(_selectedWheelSize) ? _selectedWheelSize : null;
                          _selectedFrameSize = _currentFrameSizes.contains(_selectedFrameSize) ? _selectedFrameSize : null;
                          // Se o tamanho de roda/quadro atual não existir na nova lista, reseta
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
                    child: Text('$size"'), // Adicionado " para polegadas
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedWheelSize = value;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Wheel Size'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a wheel size';
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
                  decoration: const InputDecoration(labelText: 'Frame Size'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a frame size';
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
                        Routefly.pop(context); // Usar Routefly para voltar
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm, // Chamar a função de submit
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text('Create'),
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