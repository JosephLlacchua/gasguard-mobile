import 'package:flutter/material.dart';
import 'package:gasguard_mobile/ui/common/app_header.dart';
import 'package:gasguard_mobile/ui/screens/devices/components/device_form.dart';

class DeviceDetailScreen extends StatefulWidget {
  final Map<String, dynamic>? device;

  const DeviceDetailScreen({
    Key? key,
    this.device,
  }) : super(key: key);

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  late final TextEditingController _deviceIdController;
  late final TextEditingController _deviceNameController;

  @override
  void initState() {
    super.initState();

    // Inicializar controladores con datos existentes o vacíos
    _deviceIdController = TextEditingController(
      text: widget.device != null ? widget.device!['id'] : '',
    );

    _deviceNameController = TextEditingController(
      text: widget.device != null ? widget.device!['name'] : '',
    );
  }

  @override
  void dispose() {
    _deviceIdController.dispose();
    _deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isNewDevice = widget.device == null;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2A),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            AppHeader(
              title: isNewDevice ? 'Add Device' : 'Device Info',
              onMenuPressed: () {},
              showBackButton: true,
            ),

            // Contenido principal
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1A2B3D),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Device information',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Formulario
                      DeviceForm(
                        deviceIdController: _deviceIdController,
                        deviceNameController: _deviceNameController,
                        isEditing: !isNewDevice,
                        onSave: _saveDevice,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para guardar o actualizar el dispositivo
  void _saveDevice() {
    // Aquí implementarías la lógica para guardar en base de datos, API, etc.
    // Por ahora, solo volvemos a la pantalla anterior
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Device saved successfully!'),
        backgroundColor: Color(0xFF4ECDC4),
      ),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pop(context);
    });
  }
}