import 'package:flutter/material.dart';
import 'package:gasguard_mobile/utils/app_router.dart';

class TopMenu extends StatelessWidget {
  final VoidCallback onLogout;

  const TopMenu({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Envuelve todo el contenido con Material
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 60.0, left: 16.0, right: 16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF1A2B3D),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/logo_gasguard.png',
                              width: 30,
                              height: 30,
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
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close, color: Color(0xFF4ECDC4)),
                      ),
                    ],
                  ),
                  const Divider(color: Color(0xFF2A3B4D), height: 1),
                  _buildMenuItem(
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, AppRouter.dashboard);
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.device_hub,
                    title: 'Devices',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, AppRouter.devices);
                    },
                  ),
                  const Divider(color: Color(0xFF2A3B4D), height: 1),
                  _buildMenuItem(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: onLogout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4ECDC4)),
      title: Text(title, style: const TextStyle(color: Color(0xFF4ECDC4))),
      onTap: onTap,
    );
  }
}