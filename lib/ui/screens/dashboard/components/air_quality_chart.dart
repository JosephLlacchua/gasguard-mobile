import 'package:flutter/material.dart';

import '../../../widgets/gasLevel_chart_painter .dart';

class AirQualityChart extends StatelessWidget {
  final List<double> gasLevelData;
  final bool isEmergencyMode;

  const AirQualityChart({
    Key? key,
    required this.gasLevelData,
    required this.isEmergencyMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1B2A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF2A3B4D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Concentración de gas en tiempo real',  // Título actualizado
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: CustomPaint(
              size: const Size(double.infinity, 120),
              painter: GasLevelChartPainter(
                gasLevelData,
                isEmergency: isEmergencyMode,
              ),
            ),
          ),
          // Añadir leyenda
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('0%', style: TextStyle(color: Colors.white54, fontSize: 12)),
                Text(
                  'Nivel de alerta: 70%', 
                  style: TextStyle(
                    color: isEmergencyMode ? Colors.red : Colors.white54, 
                    fontSize: 12
                  )
                ),
                const Text('100%', style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}