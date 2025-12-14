import 'package:flutter/material.dart';
import '../models/materia.dart'; 

class DetalleMateriaScreen extends StatefulWidget {
  final Materia materia; 

  const DetalleMateriaScreen({super.key, required this.materia});

  @override
  State<DetalleMateriaScreen> createState() => _DetalleMateriaScreenState();
}

class _DetalleMateriaScreenState extends State<DetalleMateriaScreen> {
  final TextEditingController _notaController = TextEditingController();
  String? _mensajeError;

  void _guardarNota() {
    
    double? valorNota = double.tryParse(_notaController.text);

    setState(() {
      if (valorNota == null) {
        _mensajeError = "Por favor ingresa un número válido";
      } else if (valorNota < 0.0 || valorNota > 5.0) {
        
        _mensajeError = "La nota debe estar entre 0.0 y 5.0";
      } else {
        
        widget.materia.agregarNota(valorNota);
        _notaController.clear();
        _mensajeError = null; 
      }
    });
  }

  void _borrarNotas() {
    setState(() {
      widget.materia.reiniciarNotas();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    double promedio = widget.materia.calcularPromedio();
    bool aprobado = widget.materia.estaAprobada();
    
    
    Color colorEstado = aprobado ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.materia.nombre),
        backgroundColor: colorEstado, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text("Promedio Actual", style: TextStyle(fontSize: 18)),
                    Text(
                      promedio.toStringAsFixed(2),
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: colorEstado),
                    ),
                    Text(
                      aprobado ? "APROBADA " : "REPROBADA ",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colorEstado),
                    ),
                    const SizedBox(height: 10),
                    Text("Notas registradas: ${widget.materia.notas.length} (Mínimo 3 sugerido)"),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),

           
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _notaController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Ingresar Nota (0.0 - 5.0)',
                      errorText: _mensajeError, // Muestra error rojo si existe
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _guardarNota,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  ),
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),
            
           
            const Text("Historial de Notas", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: widget.materia.notas.isEmpty
                  ? const Center(child: Text("No hay notas ingresadas aún."))
                  : ListView.builder(
                      itemCount: widget.materia.notas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.grade),
                          title: Text("Nota ${index + 1}:  ${widget.materia.notas[index]}"),
                        );
                      },
                    ),
            ),
            
            
            TextButton.icon(
              onPressed: _borrarNotas, 
              icon: const Icon(Icons.refresh, color: Colors.grey),
              label: const Text("Reiniciar Notas", style: TextStyle(color: Colors.grey)),
            )
          ],
        ),
      ),
    );
  }
}