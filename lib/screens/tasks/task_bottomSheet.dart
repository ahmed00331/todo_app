import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_bottom_sheet_provider.dart';

class TaskBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskBottomSheetProvider(),
      builder: (context, _) {
        var pro = Provider.of<TaskBottomSheetProvider>(context);
        return SingleChildScrollView(
          child: SizedBox(
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
                        "Add Task",
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
                        onPressed: () {
                          if (pro.formKey.currentState!.validate()) {
                            return;
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
