//Desarrollo de Ejercicio 01
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo de Pensión',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false, // Quitar el banner de "debug"
      home: PensionCalculator(),
    );
  }
}

class PensionCalculator extends StatefulWidget {
  @override
  _PensionCalculatorState createState() => _PensionCalculatorState();
}

class _PensionCalculatorState extends State<PensionCalculator> {
  String _selectedCategory = 'A';
  double _averageGrade = 0.0;
  double _pension = 550.0;
  double _discountPercentage = 0.0;
  double _finalPension = 550.0;

  void _calculatePension() {
    // Asigna la pensión base según la categoría seleccionada
    switch (_selectedCategory) {
      case 'A':
        _pension = 550.0;
        break;
      case 'B':
        _pension = 500.0;
        break;
      case 'C':
        _pension = 460.0;
        break;
      case 'D':
        _pension = 400.0;
        break;
    }

    // Determina el porcentaje de descuento según el promedio
    if (_averageGrade >= 18.0) {
      _discountPercentage = 15.0;
    } else if (_averageGrade >= 16.0) {
      _discountPercentage = 12.0;
    } else if (_averageGrade >= 14.0) {
      _discountPercentage = 10.0;
    } else {
      _discountPercentage = 0.0;
    }

    // Calcula la pensión final con el descuento aplicado
    double discountAmount = _pension * (_discountPercentage / 100);
    _finalPension = _pension - discountAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Cálculo de Pensión',
            style: TextStyle(color: Colors.white), // Título en rojo
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'Seleccione su categoría'),
              items: ['A', 'B', 'C', 'D']
                  .map((category) => DropdownMenuItem<String>(
                        value: category,
                        child: Text('Categoría $category'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Ingrese su promedio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _averageGrade = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _calculatePension();
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.green, // Texto del botón en verde
              ),
              child: Text('Calcular Pensión'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Pensión Actual: S/. ${_pension.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Descuento: $_discountPercentage%',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Nueva Pensión: S/. ${_finalPension.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
