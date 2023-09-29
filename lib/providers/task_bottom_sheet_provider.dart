import 'package:flutter/material.dart';

class TaskBottomSheetProvider extends ChangeNotifier {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();

  void showDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 500)));

    if (chosenDate == null) {
      return;
    }
    selectedDate = chosenDate;
    notifyListeners();
  }
}
