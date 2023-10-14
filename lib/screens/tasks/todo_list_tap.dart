import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/tasks/task_item.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/colors.dart';

class TodoListTap extends StatefulWidget {
  const TodoListTap({super.key});

  @override
  State<TodoListTap> createState() => _TodoListTapState();
}

class _TodoListTapState extends State<TodoListTap> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    var theme = Theme.of(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: accentColor,
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.secondary.withOpacity(0.3),
                theme.colorScheme.background,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: CalendarTimeline(
            initialDate: date,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (newDate) {
              if (date != newDate) {
                setState(() {
                  date = newDate;
                });
              }
            },
            leftMargin: 20,
            monthColor: Colors.grey,
            dayColor: Colors.grey,
            activeDayColor: theme.primaryColor,
            dotsColor: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Divider(
          color: accentColor,
          thickness: 4,
          indent: 30,
          endIndent: 30,
        ),
        const SizedBox(
          height: 30,
        ),
        StreamBuilder(
          stream: FirebaseFunctions.getTasks(date),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }
            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            if (tasks.isEmpty) {
              return const Center(child: Text("No Tasks Yet"));
            }

            return Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemBuilder: (context, index) {
                  return TaskItem(
                    task: tasks[index],
                  );
                },
                itemCount: tasks.length,
              ),
            );
          },
        )
      ],
    );
  }
}
