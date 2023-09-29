import 'package:flutter/material.dart';
import 'package:todo/screens/tasks/task_bottomSheet.dart';

import '../screens/settings/settings_tap.dart';
import '../screens/tasks/todo_list_tap.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = "Home";

  int index = 0;

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("To Do List",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
          side: BorderSide(color: Colors.white, width: 4),
        ),
        onPressed: () {
          showTaskBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(18), topLeft: Radius.circular(18)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
            iconSize: 35,
            showUnselectedLabels: false,
            currentIndex: index,
            onTap: (value) {
                index = value;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                ),
                label: "List",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: "Settings",
              ),
            ],
          ),
        ),
      ),
      body: taps[index],
    );
  }

  List<Widget> taps = [
    TodoListTap(),
    SettingsTap(),
  ];

  void showTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TaskBottomSheet(),
        );
      },
    );
  }
}
