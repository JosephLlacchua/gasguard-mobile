import 'package:flutter/material.dart';

class AirQualityStatus extends StatelessWidget {
  final double gasLevel;
  final bool isEmergencyMode;
  final VoidCallback onEmergencyToggle;

  const AirQualityStatus({
    Key? key,
    required this.gasLevel,
    required this.isEmergencyMode,
    required this.onEmergencyToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // LÓGICA INVERTIDA: Ahora valores bajos son buenos, altos son peligrosos
    final isGood = !isEmergencyMode && gasLevel < 30; // Umbral invertido
    final statusText = isEmergencyMode ? 'Emergencia detectada' : 
                      isGood ? 'Nivel seguro' : 'Nivel elevado';
                      
    final statusIcon = isEmergencyMode ? Icons.warning_amber_rounded : 
                      isGood ? Icons.check_circle : Icons.info;
                      
    final statusColor = isEmergencyMode ? Colors.red : 
                        isGood ? Colors.green : Colors.orange;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Concentración de gas',  // Texto actualizado
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            ElevatedButton(
              onPressed: onEmergencyToggle,
              style: ElevatedButton.styleFrom(
                backgroundColor: isEmergencyMode ? Colors.red : Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(isEmergencyMode ? Icons.cancel : Icons.science, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    isEmergencyMode ? 'Cancelar simulación' : 'Simular fuga',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              '${gasLevel.toStringAsFixed(2)}%',
              style: TextStyle(
                // Color dinámico basado en el nivel
                color: gasLevel > 70 ? Colors.red : 
                      gasLevel > 30 ? Colors.orange : Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                statusIcon,
                color: statusColor,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          statusText,
          style: TextStyle(
            color: isEmergencyMode ? Colors.red : Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}