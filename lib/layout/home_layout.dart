import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/authentication/login_screen.dart';
import 'package:todo/screens/tasks/task_bottomSheet.dart';

import '../providers/test.dart';
import '../screens/settings/settings_tap.dart';
import '../screens/tasks/todo_list_tap.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = "Home";

  HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      builder: (context, child) {
        var pro = Provider.of<NavigationProvider>(context);
        var provider = Provider.of<MyProvider>(context);
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            toolbarHeight: 80,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.routeName, (route) => false);
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 30,
                      color: Colors.white,
                    )),
              )
            ],
            title: Text(
                "${AppLocalizations.of(context)!.appTitle}, ${provider.userModel?.name}",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white, fontSize: 20)),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: const StadiumBorder(
              side: BorderSide(color: Colors.white, width: 4),
            ),
            onPressed: () {
              showTaskBottomSheet(context);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18)),
            child: BottomAppBar(
              color: provider.modeApp == ThemeMode.light
                  ? Colors.white
                  : Color(0xff141922),
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: BottomNavigationBar(
                iconSize: 35,
                showUnselectedLabels: false,
                currentIndex: pro.index,
                onTap: (value) {
                  pro.onTap(value);
                },
                items: [
                  BottomNavigationBarItem(
                    tooltip: "List",
                    icon: Icon(
                      Icons.list,
                    ),
                    label: AppLocalizations.of(context)!.list,
                  ),
                  BottomNavigationBarItem(
                    tooltip: "Settings",
                    icon: Icon(
                      Icons.settings_outlined,
                    ),
                    label: AppLocalizations.of(context)!.settings,
                  ),
                ],
              ),
            ),
          ),
          body: taps[pro.index],
        );
      },
    );
  }

  List<Widget> taps = [
    const TodoListTap(),
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
