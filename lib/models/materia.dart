
class Materia {

  String nombre;
  int? creditos; 
  List<double> notas = []; 
  
  Materia({required this.nombre, this.creditos});

  
  void agregarNota(double nota) {
    if (nota >= 0.0 && nota <= 5.0) {
      notas.add(nota);
      print('Nota $nota agregada a $nombre.');
    } else {
      print('Error: La nota debe estar entre 0.0 y 5.0');
    }
 
  }


  double calcularPromedio() {
    if (notas.isEmpty) return 0.0;
    double suma = 0;
    for (double nota in notas) {
      suma += nota;
    }
    return suma / notas.length;
  }

  
  bool estaAprobada() {
    return calcularPromedio() >= 3.0;
  }
  
  void reiniciarNotas(){
      notas.clear();
    }
}