import 'package:flutter/material.dart';
import 'models/materia.dart'; 
import 'screens/detalle_materia.dart';
void main() {
  runApp(const MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'Sistema de Notas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true, 
      ),
      home: const PantallaMaterias(),
    );
  }
}


class PantallaMaterias extends StatefulWidget {
  const PantallaMaterias({super.key});

  @override
  State<PantallaMaterias> createState() => _PantallaMateriasState();
}

class _PantallaMateriasState extends State<PantallaMaterias> {
  
  List<Materia> listaMaterias = [Materia(nombre: 'Matemáticas', creditos: 4) ..notas.addAll([4.0, 3.5,1]), 
                                Materia(nombre: 'Física', creditos: 3) ..notas.addAll([4.0, 2.5,4]),
                                Materia(nombre: 'Química', creditos: 3) ..notas.addAll([0.0, 4.0,2.5])];

  
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _creditosController = TextEditingController();

  
  void _agregarMateria() {
    if (_nombreController.text.isNotEmpty) {
      setState(() {
        
        listaMaterias.add(Materia(
          nombre: _nombreController.text,
          creditos: int.tryParse(_creditosController.text) ?? 0,
        ));
      });
      
      _nombreController.clear();
      _creditosController.clear();
      Navigator.of(context).pop();
    }
  }

  
  void _eliminarMateria(int index) {
    setState(() {
      listaMaterias.removeAt(index);
    });
  }

  
  void _mostrarDialogoRegistro() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registrar Nueva Materia'),
          content: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre de la materia'),
              ),
              TextField(
                controller: _creditosController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Créditos (Opcional)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancelar
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: _agregarMateria, // Guardar
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Materias'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      
      body: listaMaterias.isEmpty
          ? const Center(child: Text('No hay materias registradas. \nPresiona + para agregar.', textAlign: TextAlign.center))
          : ListView.builder(
              itemCount: listaMaterias.length,
              itemBuilder: (context, index) {
                final materia = listaMaterias[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(materia.nombre[0].toUpperCase()), // Primera letra
                    ),
                    title: Text(materia.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Créditos: ${materia.creditos ?? 0}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _eliminarMateria(index),
                    ),
                     
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleMateriaScreen(materia: materia),
                        ),
                      ).then((_) {
    
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarDialogoRegistro,
        child: const Icon(Icons.add),
      ),
    );
  }
}