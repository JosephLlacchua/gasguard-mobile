import 'package:flutter/material.dart';

class DeviceItem extends StatelessWidget {
  final String name;
  final String id;
  final bool isOnline;
  final String lastSeen;
  final VoidCallback onTap;

  const DeviceItem({
    Key? key,
    required this.name,
    required this.id,
    required this.isOnline,
    required this.lastSeen,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F1B2A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF2A3B4D),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                // Indicador de estado (online/offline)
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isOnline ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(width: 16),
                // Información del dispositivo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Last seen: $lastSeen',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                // Ícono de flecha
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white54,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}