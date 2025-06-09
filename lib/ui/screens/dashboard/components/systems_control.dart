import 'package:flutter/material.dart';
import 'package:gasguard_mobile/ui/screens/dashboard/components/system_item.dart';

class SystemsControl extends StatelessWidget {
  final bool gasValveActive;
  final bool ventilationActive;
  final bool doorSystemActive;
  final bool lightingSystemActive;
  final bool isEmergencyMode;
  final Function(bool) onGasValveToggle;
  final Function(bool) onVentilationToggle;
  final Function(bool) onDoorSystemToggle;
  final Function(bool) onLightingToggle;

  const SystemsControl({
    Key? key,
    required this.gasValveActive,
    required this.ventilationActive,
    required this.doorSystemActive,
    required this.lightingSystemActive,
    required this.isEmergencyMode,
    required this.onGasValveToggle,
    required this.onVentilationToggle,
    required this.onDoorSystemToggle,
    required this.onLightingToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sistemas de seguridad',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SystemItem(
            title: 'Válvula de gas',
            subtitle: gasValveActive ? 'Abierta' : 'Cerrada',
            icon: Icons.gas_meter,
            isActive: gasValveActive,
            onToggle: isEmergencyMode ? null : onGasValveToggle,
          ),
          const SizedBox(height: 15),
          SystemItem(
            title: 'Sistema de ventilación',
            subtitle: ventilationActive ? 'Activo' : 'Inactivo',
            icon: Icons.air,
            isActive: ventilationActive,
            onToggle: onVentilationToggle,
          ),
          const SizedBox(height: 15),
          SystemItem(
            title: 'Sistema de puertas',
            subtitle: doorSystemActive ? 'Abiertas' : 'Cerradas',
            icon: Icons.sensor_door,
            isActive: doorSystemActive,
            onToggle: onDoorSystemToggle,
          ),
          const SizedBox(height: 15),
          SystemItem(
            title: 'Control de iluminación',
            subtitle: lightingSystemActive ? 'Automático' : 'Manual',
            icon: Icons.lightbulb,
            isActive: lightingSystemActive,
            onToggle: onLightingToggle,
          ),
        ],
      ),
    );
  }
}