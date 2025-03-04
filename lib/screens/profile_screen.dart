import 'package:flutter/material.dart';
import 'package:menu_app_flutter/screens/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String? _activityLevel;
  double _caloricNeeds = 0.0;
  bool _isButtonEnabled = false;

  final List<String> activityLevels = [
    "Sedentario",
    "Ligero (ejercicio 1-3 días)",
    "Moderado (ejercicio 4-5 días)",
    "Activo (ejercicio 6-7 días)",
    "Muy Activo (entrenamiento intenso)"
  ];

  void _validateInputs() {
    setState(() {
      _isButtonEnabled = _ageController.text.isNotEmpty &&
          _weightController.text.isNotEmpty &&
          _heightController.text.isNotEmpty &&
          _activityLevel != null &&
          _caloricNeeds > 0;
    });
  }

  void _calculateCalories() {
    if (_ageController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _activityLevel != null) {
      int age = int.parse(_ageController.text);
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);

      double bmr = 10 * weight + 6.25 * height - 5 * age + 5;
      double multiplier = {
        "Sedentario": 1.2,
        "Ligero (ejercicio 1-3 días)": 1.375,
        "Moderado (ejercicio 4-5 días)": 1.55,
        "Activo (ejercicio 6-7 días)": 1.725,
        "Muy Activo (entrenamiento intenso)": 1.9,
      }[_activityLevel] ?? 1.2;

      setState(() {
        _caloricNeeds = bmr * multiplier;
        _validateInputs();
      });
    }
  }

  void _goToHomeScreen() {
    if (!_isButtonEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Debes ingresar todos los datos antes de continuar."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(caloricNeeds: _caloricNeeds),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil del Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Edad (años)"),
              onChanged: (value) => _validateInputs(),
            ),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Peso (kg)"),
              onChanged: (value) => _validateInputs(),
            ),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Estatura (cm)"),
              onChanged: (value) => _validateInputs(),
            ),
            DropdownButtonFormField<String>(
              value: _activityLevel,
              decoration: const InputDecoration(labelText: "Nivel de actividad"),
              items: activityLevels.map((level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _activityLevel = value;
                  _validateInputs();
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateCalories,
              child: const Text("Calcular Calorías"),
            ),
            if (_caloricNeeds > 0)
              Text("Requerimiento calórico: ${_caloricNeeds.toStringAsFixed(0)} kcal"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isButtonEnabled ? _goToHomeScreen : null,
              child: const Text("Guardar y Continuar"),
            ),
          ],
        ),
      ),
    );
  }
}
