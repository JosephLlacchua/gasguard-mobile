import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget {
  final VoidCallback onLogout;

  const BottomMenu({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A2B3D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/logo_gasguard.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'GasGuard',
                    style: TextStyle(
                      color: Color(0xFF4ECDC4),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
          const Divider(color: Color(0xFF2A3B4D)),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Color(0xFF4ECDC4)),
            title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.device_hub, color: Color(0xFF4ECDC4)),
            title: const Text('Devices', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(color: Color(0xFF2A3B4D)),
          ListTile(
            leading: const Icon(Icons.logout, color: Color(0xFF4ECDC4)),
            title: const Text('Logout', style: TextStyle(color: Colors.white)),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}