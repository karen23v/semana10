//Ejercicio 02

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ventas de Libretas Militares',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _edadController = TextEditingController();
  String _nivelSeleccionado = '1'; // Nivel inicial
  String _resultado = '';

  // Lista de niveles para el dropdown
  List<String> _niveles = ['1', '2', '3'];

  void _calcularPrecio() {
    // Obtener la edad
    int edad = int.tryParse(_edadController.text) ?? 0;

    if (edad <= 0) {
      setState(() {
        _resultado = 'Por favor, ingrese una edad válida.';
      });
      return;
    }

    int nivel = int.tryParse(_nivelSeleccionado) ?? 1; // Convertir el nivel a entero

    // Validar el nivel (aunque se selecciona del dropdown, es bueno confirmar)
    if (nivel < 1 || nivel > 3) {
      setState(() {
        _resultado = 'El nivel debe estar entre 1 y 3.';
      });
      return;
    }

    double precioBase = edad >= 18 ? 350 : 200;
    double descuento = 0;

    // Calcular descuento
    if (edad >= 18) {
      if (nivel == 1) {
        descuento = 0.40;
      } else if (nivel == 2) {
        descuento = 0.30;
      } else if (nivel == 3) {
        descuento = 0.15;
      }
    } else {
      if (nivel == 1) {
        descuento = 0.60;
      } else if (nivel == 2) {
        descuento = 0.40;
      } else if (nivel == 3) {
        descuento = 0.20;
      }
    }

    // Calcular el precio final después del descuento
    double precioFinal = precioBase - (precioBase * descuento);

    // Mostrar el resultado
    setState(() {
      _resultado = 'Descuento aplicado: ${(descuento * 100).toStringAsFixed(0)}%\n'
                   'Precio final: S/. ${precioFinal.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas de Libretas Militares'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Jornada de Ventas',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              TextField(
                controller: _edadController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Edad del joven',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _nivelSeleccionado,
                onChanged: (String? newValue) {
                  setState(() {
                    _nivelSeleccionado = newValue!;
                  });
                },
                items: _niveles.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('Nivel $value'),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularPrecio,
                child: Text('Calcular Precio'),
              ),
              SizedBox(height: 20),
              if (_resultado.isNotEmpty)
                Text(
                  _resultado,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
