import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:intl/intl.dart';

Widget buildTaskListTile(Task task,BuildContext context) {
  final screenWidth = MediaQuery
      .of(context)
      .size
      .width;
  final tileWidth = screenWidth * 2 / 3;
  // Implement your custom list tile widget
  return GestureDetector(
    onTap: (){
      GoRouter.of(context).goNamed('task', extra: task);
    },
    child: SizedBox(
      height: 110,
      width: tileWidth,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(task.category.icon),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _buildTextWidgetForCard(
                        value: task.title.value, label: 'Title'),
                    _buildStatusWidgetForCard(
                        isCompleted: task.isCompleted, label: "Status"),
                    _buildTextWidgetForCard(
                        value: task.description.value, label: 'Description'),
                    _buildDateWidgetForCard(
                        value: task.dueDate!, label: 'DueDate'),
                    _buildTextWidgetForCard(
                        value: task.priority.name, label: 'Priority'),
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    ),
  );
}
Widget _buildTextWidgetForCard({required String value,required String label}){
  return _buildRowWidgetForCard(value: value,label: label);
}
Widget _buildStatusWidgetForCard({required bool isCompleted,required String label}){
  final status= isCompleted?"Finished":"Ongoing";
  return _buildRowWidgetForCard(value: status,label: label);
}
Widget _buildDateWidgetForCard({required DateTime value,required String label}){
  final formattedValue =DateFormat('dd/MM/yyyy').format(value);
  return _buildRowWidgetForCard(value: formattedValue,label: label);
}
Widget _buildRowWidgetForCard({required dynamic value,required String label}){
  return Row(
    children: [
      Text(label),
      Gap(5),
      Text(value.toString()),
    ],
  );
}