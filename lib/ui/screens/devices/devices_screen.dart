import 'package:flutter/material.dart';
import 'package:gasguard_mobile/ui/common/app_header.dart';
import 'package:gasguard_mobile/ui/screens/devices/components/device_item.dart';
import 'package:gasguard_mobile/ui/screens/devices/device_detail_screen.dart';
import '../../../utils/app_router.dart';
import '../../../utils/top_menu.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({Key? key}) : super(key: key);

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  // Lista de dispositivos simulados
  final List<Map<String, dynamic>> _devices = [
    {
      'id': 'DEV0001XXXXXX',
      'name': 'Device 1',
      'isOnline': true,
      'lastSeen': '2 min ago'
    },
    {
      'id': 'DEV0002XXXXXX',
      'name': 'Device 2',
      'isOnline': true,
      'lastSeen': '5 min ago'
    },
    {
      'id': 'DEV0003XXXXXX',
      'name': 'Device 3',
      'isOnline': false,
      'lastSeen': '3 hours ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1A2A),
      body: SafeArea(
        child: Column(
          children: [
            // Header con el logo y menú
            AppHeader(
              title: 'Devices',
              onMenuPressed: () => _showTopMenu(context),
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
                        'Your devices',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Lista de dispositivos
                      Expanded(
                        child: _devices.isEmpty
                            ? _buildEmptyState()
                            : _buildDevicesList(),
                      ),

                      // Botón para añadir dispositivo
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _navigateToDeviceDetail(context, null),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4ECDC4),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Add device',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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

  // Widget para mostrar cuando no hay dispositivos
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.devices_other,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No devices found',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first device to start monitoring',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Widget para mostrar la lista de dispositivos
  Widget _buildDevicesList() {
    return ListView.builder(
      itemCount: _devices.length,
      itemBuilder: (context, index) {
        final device = _devices[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: DeviceItem(
            name: device['name'],
            id: device['id'],
            isOnline: device['isOnline'],
            lastSeen: device['lastSeen'],
            onTap: () => _navigateToDeviceDetail(context, device),
          ),
        );
      },
    );
  }

  // Navega a la pantalla de detalle del dispositivo
  void _navigateToDeviceDetail(BuildContext context, Map<String, dynamic>? device) {
    Navigator.pushNamed(
      context,
      AppRouter.deviceDetail,
      arguments: device,
    );
  }

  // Muestra el menú superior
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
}