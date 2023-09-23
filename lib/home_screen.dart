import 'package:flutter/material.dart';
import 'package:todo/taps/settings_tap.dart';
import 'package:todo/taps/todo_list_tap.dart';
import 'package:todo/task_bottomSheet.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = "Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(bottom: 50, left: 40),
          child:
              Text("To Do List", style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder(
          side: BorderSide(color: Colors.white, width: 4),
        ),
        onPressed: () {
          showTaskBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: index,
          onTap: (value){
            index = value;
            setState(() {

            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 32,
              ),
              label: "List",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 32,
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
      body: taps[index],
    );
  }
  List<Widget> taps = [
    SettingsTap(),
    TodoListTap()
  ];

  void showTaskBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context) {
      return TaskBottomSheet();
    },
    );
  }
}
