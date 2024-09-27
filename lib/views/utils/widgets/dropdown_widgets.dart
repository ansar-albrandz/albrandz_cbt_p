import 'package:flutter/material.dart';

class DropdownWidgets {
  static Widget appDropDownView(List<String> items,
      {required void Function(dynamic)? onChanged,String? hintText}) {
    return DropdownButtonFormField(
      // validator: (text)=>text!.isEmpty?"This field is required":null,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(),
        )
      ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged);
  }
}
