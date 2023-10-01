import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/settings/theming_bottom_sheet.dart';

import '../../shared/styles/my_theme_data.dart';
import 'language_botoom_sheet.dart';

class SettingsTap extends StatefulWidget {
  const SettingsTap({super.key});

  @override
  State<SettingsTap> createState() => _SettingTapState();
}

class _SettingTapState extends State<SettingsTap> {
  bool isEnglish = true;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Language"),
          InkWell(
            onTap: () {
              languageBottomSheet();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: MyThemeData.accentColor),
              ),
              child: Row(
                children: [
                  Text(pro.languageCode == "en" ? "English" : "Arabic"),
                  Spacer(),
                  Icon(Icons.arrow_drop_up),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text("Mode"),
          InkWell(
            onTap: () {
              themingBottomSheet();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: MyThemeData.accentColor),
              ),
              child: Row(
                children: [
                  Text(pro.modeApp == ThemeMode.light ? "Light" : "Dark"),
                  Spacer(),
                  Icon(Icons.arrow_drop_up),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  languageBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          borderSide: BorderSide(color: Colors.transparent)),
      builder: (context) => LanguageBottomSheet(),
    );
  }

  themingBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            borderSide: BorderSide(color: Colors.transparent)),
        builder: (context) => ThemingBottomSheet());
  }
}
