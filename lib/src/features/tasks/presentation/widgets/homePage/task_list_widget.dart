import 'package:flutter/cupertino.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/presentation/widgets/homePage/task_card.dart';

Widget TaskListWidget(List<Task> tasks){
  return SizedBox(
    height: 130,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return buildTaskListTile(task,context);
      },
    ),
  );
}