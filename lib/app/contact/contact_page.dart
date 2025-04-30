import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  final List<Map<String, String>> creators = const [
    {
      'name': 'Marcos Antônio Barbosa de Souza',
      'email': 'desouza.marcos@outlook.com.br',
      'phone': '+55 (62) 99208-9474',
    },
    {
      'name': 'Luiz Felipe de Almeida e Silva',
      'email': 'luizfelipedn57@gmail.com',
      'phone': '+55 (62) 99688-5739',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Criadores:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: creators.length,
                itemBuilder: (context, index) {
                  final creator = creators[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            creator['name'] ?? '',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 8),
                          Text('Email: ${creator['email']}'),
                          Text('Telefone: ${creator['phone']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}