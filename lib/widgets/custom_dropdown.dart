import 'package:carbon_emission_app/config/theme.dart';
import 'package:carbon_emission_app/data/has_value.dart';
import 'package:flutter/material.dart';

Widget customDropdown<T extends HasValue>({
  required String labelText,
  required List<T> items,
  required T? value,
  required void Function(T?) onChanged,
  required double width,
  required double height,
}) =>
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: label(),
          ), // Text
          SizedBox(height: 8), // Add spacing between Text and Dropdown
          SizedBox(
            width: width,
            height: height * 0.06,
            child: DropdownButtonFormField<T>(
              value: value,
              items: items
                  .map(
                    (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(item.value),
                ),
              )
                  .toList(),
              onChanged: onChanged,
            ),
          ), // DropdownButtonFormField
        ],
      ),
    ); // Expanded
