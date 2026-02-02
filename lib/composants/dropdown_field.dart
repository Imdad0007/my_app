import 'package:flutter/material.dart';
import 'package:app/composants/colors.dart';

class DropdownField extends StatelessWidget {
  const DropdownField({
    super.key,
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      // 🔴 OBLIGATOIRE
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.clearGrey,
          borderRadius: BorderRadius.circular(35),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            hint: Text(
              label,
              style: TextStyle(
                color: AppColors.grey[800],
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            isExpanded: true,
            borderRadius: BorderRadius.circular(20),
            icon: const Icon(Icons.keyboard_arrow_down),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(color: AppColors.black),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
