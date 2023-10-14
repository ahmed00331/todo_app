import 'package:flutter/material.dart';

class TaskBottomSheetProvider extends ChangeNotifier {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();

  void showDate(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                //OK/Cancel button text color
                primaryColor: const Color(0xFF4A5BF6), //Head background
                hintColor: const Color(0xFF4A5BF6) //selection color
                //dialogBackgroundColor: Colors.white,//Background color
                ),
            child: child!,
          );
        },
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
