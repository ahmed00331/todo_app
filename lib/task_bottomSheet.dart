import 'package:flutter/material.dart';

class TaskBottomSheet extends StatefulWidget {
  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .60,
        child: Padding(
          padding: const EdgeInsets.all(21.0),
          child: Form(
            key: formKey,
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
                    controller: titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This Filled is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Add Task",
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: const Color(0xffA9A9A9))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This Filled is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Add description ",
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
                    showDate();
                    setState(() {});
                  },
                  child: Text(
                    selectedDate.toString().substring(0, 10),
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
                      setState(() {
                        if (formKey.currentState!.validate()) {
                          return;
                        }
                      });
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
  }

  void showDate() async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365 * 500)));

    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;
    setState(() {});
  }
}
