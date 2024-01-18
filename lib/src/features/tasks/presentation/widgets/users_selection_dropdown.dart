import 'package:flutter/material.dart';
import 'package:hometasks/src/core/services/dependency_injection_container.dart';
import 'package:hometasks/src/features/auth/domain/entities/auth_user.dart';
import 'package:hometasks/src/features/auth/domain/use_cases/sream_get_users_use_case.dart';
import 'package:hometasks/src/features/tasks/domain/entities/form/form_field.dart';

class UserSelectionDropdown extends StatelessWidget {
  final FormFieldController<List<String>, List<String>> formFieldController;
  final StreamUsersUseCase streamUsersUseCase=sl.get<StreamUsersUseCase>();

  UserSelectionDropdown({
    required this.formFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<AuthUser?>>(
      stream: streamUsersUseCase.handle(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<AuthUser?> users = snapshot.data!;
          List<String> userIds = users.map((user) => user?.id ?? '').toList();

          return DropdownButtonFormField<String>(
            value: formFieldController.value.isNotEmpty
                ? formFieldController.value[0]
                : null,
            items: userIds
                .map(
                  (userId) => DropdownMenuItem<String>(
                value: userId,
                child: Text(userId),
              ),
            )
                .toList(),
            onChanged: (selectedUserId) {
              formFieldController.changeValue([selectedUserId!]);
            },
            decoration: InputDecoration(
              labelText: formFieldController.label,
              errorText:
              formFieldController.status == FieldStatus.invalid
                  ? formFieldController.errorMessage
                  : null,
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
