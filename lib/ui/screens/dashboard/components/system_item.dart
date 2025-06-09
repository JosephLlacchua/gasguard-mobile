import 'package:flutter/material.dart';

class SystemItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isActive;
  final Function(bool)? onToggle;

  const SystemItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isActive,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onToggle == null;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1B2A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive ? const Color(0xFF2A3B4D) : const Color(0xFF2A3B4D).withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Ícono del sistema
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF4ECDC4) : Colors.grey,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          // Información del sistema
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: isActive ? const Color(0xFF4ECDC4) : Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Switch
          Switch(
            value: isActive,
            onChanged: isDisabled ? null : onToggle,
            activeColor: const Color(0xFF4ECDC4),
            activeTrackColor: const Color(0xFF4ECDC4).withOpacity(0.3),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}