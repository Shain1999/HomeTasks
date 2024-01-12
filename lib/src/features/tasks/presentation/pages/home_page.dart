import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_category.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_entity.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_priority.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_recurring.dart';
import 'package:hometasks/src/features/tasks/domain/entities/task_reminders.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_event.dart';
import 'package:hometasks/src/features/tasks/presentation/bloc/task_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Title"),actions: [ElevatedButton(onPressed:(){_showAddTaskForm(context);}, child: Icon(Icons.add))],),
      body: BlocConsumer<TaskViewBloc, TasksViewState>(
        builder: (context, state) {
          if (state.status == TasksViewStatus.initial) {
            return const Center(child: Text("Initial"));
          }
          if (state.status == TasksViewStatus.loading) {
            return const Center(child: const CircularProgressIndicator());
          }
          if(state.status==TasksViewStatus.failure){
            return Center(child: Text(state.errorMessage!),);
          }
          if (state.status == TasksViewStatus.success) {
            final tasks = state.tasks ?? [];

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return _buildTaskListTile(task);
              },
            );
          }
          return Container(); // Placeholder for other states if needed
        },
        listener: (context, state) {
          if (state.status == TasksViewStatus.success) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Operation Success")));
          }

        },
      ),
    );
  }

  Widget _buildTaskListTile(Task task) {
    // Implement your custom list tile widget
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.isCompleted ? "Completed" : "Ongoing"),
      // Add more widgets as needed
    );
  }
  void _showAddTaskForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Task Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a task title.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    const Task testTask = Task(id: '15re32##489',
                        title: 'task3',
                        priority: TaskPriority.medium,
                        reminders: TaskReminders.daily,
                        category: TaskCategory.shopping,
                        reccuring: TaskReccuring.mountly);
                    context
                        .read<TaskViewBloc>()
                        .add(const OnAddTask(testTask));
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}