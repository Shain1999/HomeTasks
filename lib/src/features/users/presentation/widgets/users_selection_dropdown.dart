import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hometasks/src/core/services/dependency_injection_container.dart';
import 'package:hometasks/src/features/users/domain/entities/user_entity.dart';
import 'package:hometasks/src/features/users/presentation/bloc/getUsers/get_users_bloc.dart';
import 'package:hometasks/src/features/users/presentation/bloc/getUsers/get_users_event.dart';
import 'package:hometasks/src/features/users/presentation/bloc/getUsers/get_users_state.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class UserSelectionDropdown extends StatelessWidget {
  final void Function(List<String>)? onChangeHandler;

  const UserSelectionDropdown({Key? key, this.onChangeHandler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MultiSelectController _controller = MultiSelectController();

    return BlocProvider(
      create: (context) => sl.get<GetUsersBloc>(),
      child: Row(
        children: [
          Text("Assigned To "),
          Gap(5),
          Expanded(
            child: BlocBuilder<GetUsersBloc, GetUsersState>(
              builder: (context, state) {
                if (state.status == GetUsersStatus.initial) {
                  context.read<GetUsersBloc>().add(OnGetUsers());
                  return CircularProgressIndicator();
                }
                if (state.status == GetUsersStatus.loading) {
                  return CircularProgressIndicator();
                }
                if (state.status == GetUsersStatus.failure) {
                  return Text("An error accourd while fetching the users");
                }
                if (state.status == GetUsersStatus.success) {
                  final List<UserEntity> usersList = state.users ?? [];
            
                  return MultiSelectDropDown(
                    controller: _controller,
                    showClearIcon: true,
                    onOptionSelected: (options) {
                      List<String> selectedUsersUidList = options.map((option) =>
                          option.value.toString()).toList();
                      onChangeHandler!(selectedUsersUidList);
                    },
                    onOptionRemoved: (number,item){
                      List<String> selectedUsersUidList = _controller.selectedOptions.map((option) =>
                          option.value.toString()).toList();
                      onChangeHandler!(selectedUsersUidList);
                    },
                    borderWidth: 1,
                    options: usersList.map((user) =>
                        ValueItem<String>(label: user.name!, value: user.id))
                        .toList(),
                    maxItems: 4,
                    selectionType: SelectionType.multi,
                    chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                    dropdownHeight: 200,
                    hint: "Select User To assign",
                    optionTextStyle: const TextStyle(fontSize: 16),
                    selectedOptionIcon: const Icon(Icons.check_circle),
                  );
                }
                return Center();
              },
            ),
          ),
        ],
      ),
    );
  }
}
