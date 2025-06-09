import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:gasguard_mobile/ui/screens/dashboard/components/air_quality_status.dart';
import 'package:gasguard_mobile/ui/screens/dashboard/components/air_quality_chart.dart';
import 'package:gasguard_mobile/ui/screens/dashboard/components/systems_control.dart';

import '../../../utils/app_router.dart';
import '../../../utils/top_menu.dart';
import '../../common/app_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  // Estado de los actuadores
  bool gasValveActive = true;
  bool ventilationActive = false;
  bool doorSystemActive = false;
  bool lightingSystemActive = true;

  double gasLevel = 20.0; // Nivel inicial seguro
  List<double> gasLevelData = [];
  bool isEmergencyMode = false;
  Timer? _monitoringTimer; // Timer para monitoreo continuo

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Generar datos iniciales
    _initialGasLevelData();

    // Iniciar monitoreo continuo
    _startGasMonitoring();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _monitoringTimer?.cancel(); // Cancelar timer al salir
    super.dispose();
  }

  // Método para generar datos iniciales seguros
  void _initialGasLevelData() {
    gasLevelData.clear();
    final random = math.Random();

    // Generar datos iniciales seguros
    for (int i = 0; i < 20; i++) {
      gasLevelData.add(10.0 + random.nextDouble() * 15.0); // Entre 10% y 25% (seguro)
    }

    gasLevel = gasLevelData.last;
  }

  // Método para generar datos simulados (usado solo en _toggleEmergencyMode)
  void _generateGasLevelData() {
    gasLevelData.clear();
    final random = math.Random();

    if (isEmergencyMode) {
      // En modo emergencia, generar valores peligrosos
      for (int i = 0; i < 20; i++) {
        // Simular aumento progresivo hasta nivel peligroso
        double value = 30.0 + (i * 3.5);
        if (value > 100) value = 100;
        gasLevelData.add(value);
      }
    } else {
      // En modo normal, generar valores seguros
      for (int i = 0; i < 20; i++) {
        gasLevelData.add(10.0 + random.nextDouble() * 15.0); // Entre 10% y 25%
      }
    }

    gasLevel = gasLevelData.last;
  }

  // Método para monitoreo continuo
  void _startGasMonitoring() {
    // Cancelar timer existente si hay
    _monitoringTimer?.cancel();

    // Crear nuevo timer para actualización periódica
    _monitoringTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) return;

      setState(() {
        // Obtener nueva lectura simulada
        double newReading;

        if (isEmergencyMode) {
          // En modo emergencia, generar valores altos (peligrosos)
          newReading = 70.0 + math.Random().nextDouble() * 25.0; // Entre 70% y 95%
        } else {
          // En modo normal, generar valores bajos (seguros)
          newReading = 10.0 + math.Random().nextDouble() * 15.0; // Entre 10% y 25%

          // Pequeña probabilidad de una lectura ligeramente elevada
          if (math.Random().nextInt(100) < 5) { // 5% de probabilidad
            newReading = 25.0 + math.Random().nextDouble() * 20.0; // Entre 25% y 45%
          }
        }

        gasLevel = newReading;

        // Añadir a la gráfica y mantener tamaño
        gasLevelData.add(newReading);
        if (gasLevelData.length > 20) {
          gasLevelData.removeAt(0);
        }

        // Activación automática de emergencia (para demostración)
        if (newReading > 70 && !isEmergencyMode && math.Random().nextInt(100) < 2) {
          isEmergencyMode = true;
          gasValveActive = false;
          ventilationActive = true;
          doorSystemActive = true;
          _showEmergencyAlert();
        }
      });
    });
  }

  void _toggleEmergencyMode() {
    _monitoringTimer?.cancel(); // Detener actualización automática temporalmente

    setState(() {
      isEmergencyMode = !isEmergencyMode;

      if (isEmergencyMode) {
        // Activar protocolos de emergencia
        gasValveActive = false;
        ventilationActive = true;
        doorSystemActive = true;

        // Generar datos de simulación de emergencia
        gasLevelData.clear();
        for (int i = 0; i < 20; i++) {
          // Simular aumento progresivo hasta nivel peligroso
          double value = 30.0 + (i * 3.5);
          if (value > 100) value = 100;
          gasLevelData.add(value);
        }

        gasLevel = gasLevelData.last;
        _showEmergencyAlert();
      } else {
        // Volver a modo normal
        gasValveActive = true;
        doorSystemActive = false;

        // Generar datos seguros
        gasLevelData.clear();
        for (int i = 0; i < 20; i++) {
          gasLevelData.add(10.0 + math.Random().nextDouble() * 15.0);
        }

        gasLevel = gasLevelData.last;
      }
    });

    // Reanudar monitoreo automático
    _startGasMonitoring();
  }

  void _showEmergencyAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A2B3D),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
            const SizedBox(width: 10),
            const Text(
              'ALERTA DE GAS',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Niveles de gas peligrosos: ${gasLevel.toStringAsFixed(2)}%',
              style: const TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Protocolo de seguridad activado:',
              style: TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            _buildProtocolItem('Corte de suministro de gas'),
            _buildProtocolItem('Apertura de puertas y ventanas'),
            _buildProtocolItem('Activación de sistema de ventilación'),
            _buildProtocolItem('Notificación a servicios de emergencia'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
                'ENTENDIDO', style: TextStyle(color: Color(0xFF4ECDC4))),
          ),
        ],
      ),
    );
  }

  Widget _buildProtocolItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Color(0xFF4ECDC4), size: 16),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2A),
      body: SafeArea(
        child: Column(
          children: [
            AppHeader(
              onMenuPressed: () => _showTopMenu(context),
            ),
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
                  child: ListView( // Cambiado a ListView para permitir scroll
                    children: [
                      // Estado de la calidad del aire
                      AirQualityStatus(
                        gasLevel: gasLevel,
                        isEmergencyMode: isEmergencyMode,
                        onEmergencyToggle: _toggleEmergencyMode,
                      ),
                      const SizedBox(height: 20),

                      // Gráfica de tiempo real
                      AirQualityChart(
                        gasLevelData: gasLevelData,
                        isEmergencyMode: isEmergencyMode,
                      ),
                      const SizedBox(height: 20),

                      // Título para sistemas de seguridad
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Sistemas de seguridad',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      // Controles de sistemas
                      SystemsControl(
                        gasValveActive: gasValveActive,
                        ventilationActive: ventilationActive,
                        doorSystemActive: doorSystemActive,
                        lightingSystemActive: lightingSystemActive,
                        isEmergencyMode: isEmergencyMode,
                        onGasValveToggle: (value) {
                          setState(() {
                            gasValveActive = value;
                          });
                        },
                        onVentilationToggle: (value) {
                          setState(() {
                            ventilationActive = value;
                          });
                        },
                        onDoorSystemToggle: (value) {
                          setState(() {
                            doorSystemActive = value;
                          });
                        },
                        onLightingToggle: (value) {
                          setState(() {
                            lightingSystemActive = value;
                          });
                        },
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

  void _showTopMenu(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => TopMenu(
        onLogout: () {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, AppRouter.auth);
        },
      ),
    );
  }

  // Método opcional para generar lecturas simuladas con más control
  double _getGasReading() {
    if (isEmergencyMode) {
      return 70.0 + math.Random().nextDouble() * 25.0; // Entre 70% y 95%
    } else {
      // Generar valor bajo con pequeña probabilidad de anomalía
      final isAnomaly = math.Random().nextInt(100) < 5; // 5% de probabilidad
      if (isAnomaly) {
        return 25.0 + math.Random().nextDouble() * 20.0; // Entre 25% y 45%
      } else {
        return 10.0 + math.Random().nextDouble() * 15.0; // Entre 10% y 25%
      }
    }
  }
}