import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<StatefulWidget> createState() => _ContactForm();
}

class _ContactForm extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores originales
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();

  // CAMBIO 
  // identificación del estudiante y contacto válido
  final studentIdController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    studentIdController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) return "Campo obligatorio";
    if (value.length < 6) return "Mínimo 6 caracteres";
    return null;
  }

  // CAMBIO  Validación de ID para asegurar la identificación correcta
  String? _validateStudentId(String? value) {
    if (value == null || value.isEmpty) return "La matrícula es obligatoria";
    if (value.length < 5) return "ID demasiado corto";
    return null;
  }

  // CAMBIO Validación de Email para asegurar "datos de contacto válidos"
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "El correo es obligatorio";
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Ingrese un correo electrónico válido";
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Campo obligatorio";
    if (int.tryParse(value) == null) return "Solo números permitidos";
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Si el formulario es válido, se procesa la información
      print("Estudiante registrado con éxito");
    }
  }

  void _clearForm() {
    fullNameController.clear();
    phoneController.clear();
    studentIdController.clear();
    emailController.clear();
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro de Estudiantes")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(
                    labelText: "Nombre Completo", border: OutlineInputBorder()),
                validator: _validateFullName,
              ),
              const SizedBox(height: 16),
              // NUEVO  Identificación
              TextFormField(
                controller: studentIdController,
                decoration: const InputDecoration(
                    labelText: "Matrícula / ID", border: OutlineInputBorder()),
                validator: _validateStudentId,
              ),
              const SizedBox(height: 16),
              // NUEVO CAMPO: Contacto Válido
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    labelText: "Correo Institucional",
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                    labelText: "Teléfono", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: _validatePhone,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text("Registrar"))),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _clearForm,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey),
                      child: const Text("Limpiar",
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
