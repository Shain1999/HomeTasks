
// Widget example for the product name form field
import 'package:flutter/material.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';

Widget stringFormField<String, ReturnType>({required FormFieldController<String, ReturnType>? formField}) {
  return StreamBuilder<FormFieldModel<ReturnType>>(
    stream: formField?.valueStream,
    builder: (context, snapshot) {
      return TextField(
        decoration: InputDecoration(
          labelText: formField?.label,
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
        ),
        onChanged:(value)=> formField?.changeValue(value as String?),

      );
    },
  );
}