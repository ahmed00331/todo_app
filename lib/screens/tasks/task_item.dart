import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/tasks/edit_screen.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';

import '../../shared/styles/colors.dart';

class TaskItem extends StatefulWidget {
  TaskModel task;

  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var pro = Provider.of<MyProvider>(context);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 33, vertical: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Colors.teal,
              Color(0xffEC4B4B),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.5, 0.5],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Slidable(
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) {
                  Navigator.pushNamed(context, EditScreen.routeName,
                      arguments: widget.task);
                },
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) {
                  FirebaseFunctions.deleteTask(widget.task.id);
                },
                backgroundColor: const Color(0xffEC4B4B),
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            width: mediaQuery.width,
            height: 115,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Stack(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 5,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: widget.task.isDone
                          ? const Color(0xff61E757)
                          : theme.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.title,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: widget.task.isDone
                                ? const Color(0xFF61E757)
                                : accentColor,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(widget.task.description,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 15,
                                    color: pro.isLight()
                                        ? Colors.grey
                                        : Colors.white,
                                  )),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (widget.task.isDone)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.task.isDone = false;
                            FirebaseFunctions.updateTask(widget.task);
                          });
                        },
                        child: const Text(
                          "Done!",
                          style: TextStyle(color: Color(0xFF61E757)),
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () {
                        setState(() {
                          widget.task.isDone = !widget.task.isDone;
                          FirebaseFunctions.updateTask(widget.task);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: accentColor),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ]),
          ),
        ));
  }
}
