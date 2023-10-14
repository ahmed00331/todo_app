import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/colors.dart';

import '../../providers/task_bottom_sheet_provider.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "Edit";

  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as TaskModel;
    return ChangeNotifierProvider(
      create: (context) => TaskBottomSheetProvider(),
      builder: (context, _) {
        var pro = Provider.of<TaskBottomSheetProvider>(context);
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              title: const Text("Edit Task"),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 20,
                      child: Container(
                        color: accentColor,
                      ),
                    ),
                    Expanded(
                      flex: 83,
                      child: Container(
                        color: Color(0xffDFECDB),
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 15,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Padding(
                    padding: const EdgeInsets.all(21.0),
                    child: Form(
                      key: pro.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "pleas add your task title";
                                }
                                return null;
                              },
                              initialValue: args.title,
                              onChanged: (value) {
                                args.title = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "Title",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: const Color(0xffA9A9A9))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "pleas add your task description";
                                }
                                return null;
                              },
                              initialValue: args.description,
                              onChanged: (value) {
                                args.description = value;
                              },
                              decoration: InputDecoration(
                                  hintText: "Task Description ",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: const Color(0xffA9A9A9))),
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
                              DateFormat.yMMMMd().format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      args.date)),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: const Color(0xffA9A9A9)),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: accentColor,
                                  fixedSize: const Size.fromHeight(50)),
                              onPressed: () {
                                if (pro.formKey.currentState!.validate()) {
                                  TaskModel task = TaskModel(
                                      id: args.id,
                                      title: args.title,
                                      description: args.description,
                                      date: DateUtils.dateOnly(pro.selectedDate)
                                          .millisecondsSinceEpoch,
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid);
                                  FirebaseFunctions.updateTask(task);
                                  Navigator.pop(context);
                                }
                              },
                              child: Text(
                                "Save Changes",
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
              ],
            ));
      },
    );
  }
}
