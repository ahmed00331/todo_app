import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/providers/task_bottom_sheet_provider.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/colors.dart';

class TaskBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskBottomSheetProvider(),
      builder: (context, _) {
        var pro = Provider.of<TaskBottomSheetProvider>(context);
        var provider = Provider.of<MyProvider>(context);
        return SingleChildScrollView(
          child: Container(
            color: provider.isLight()
                ? const Color(0xffffffff)
                : const Color(0xff141922),
            height: MediaQuery.of(context).size.height * .57,
            child: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Form(
                key: pro.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Add Task",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: pro.titleController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "pleas add your task title";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Add Task Title",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: const Color(0xffA9A9A9))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: pro.descriptionController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "pleas add your task description";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Add Task Description ",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: const Color(0xffA9A9A9))),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        "Select Date",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        pro.showDate(context);
                      },
                      child: Text(
                        pro.selectedDate.toString().substring(0, 10),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: const Color(0xffA9A9A9)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: accentColor,
                            fixedSize: Size.fromHeight(50)),
                        onPressed: () {
                          if (pro.formKey.currentState!.validate()) {
                            TaskModel taskModel = TaskModel(
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                title: pro.titleController.text,
                                description: pro.descriptionController.text,
                                date: DateUtils.dateOnly(pro.selectedDate)
                                    .millisecondsSinceEpoch);
                            FirebaseFunctions.addTask(taskModel);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Add",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
