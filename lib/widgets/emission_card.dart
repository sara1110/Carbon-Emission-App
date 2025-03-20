import 'package:flutter/material.dart';
import 'package:carbon_emission_app/config/theme.dart';


Container emissionCard({
  required double height,
  required double width,
  required double co2eGm,
  required double co2eLb,
  required double co2eKg,
  required double co2eMt,
  required IconData icon,
  required Color iconColor,
}) =>
    Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            spreadRadius: 1,
          ),
        ],
      ),
      width: width, // Let parent handle width
      constraints: BoxConstraints(maxWidth: 350), // Prevents excessive widening
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 70,
          ),
          const SizedBox(height: 6),
          Text(
            co2eGm.toStringAsFixed(2),
            style: displayLarge(), // Ensure this is defined in theme.dart
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Co2e/gm",
            style: normal(), // Ensure this is defined in theme.dart
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),

          // Prevents horizontal overflow by allowing scrolling
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildEmissionColumn(co2eLb, "Co2e/lb"),
                _buildEmissionColumn(co2eKg, "Co2e/kg"),
                _buildEmissionColumn(co2eMt, "Co2e/mt"),
              ],
            ),
          ),
        ],
      ),
    );

Widget _buildEmissionColumn(double value, String unit) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Column(
      children: [
        Text(
          value.toStringAsFixed(2),
          style: displayMedium(), // Ensure this is defined
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          unit,
          style: normal(),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
