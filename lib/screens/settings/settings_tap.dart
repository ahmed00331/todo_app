import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';
import 'package:todo/screens/settings/theming_bottom_sheet.dart';

import '../../shared/styles/colors.dart';
import 'language_botoom_sheet.dart';

class SettingsTap extends StatefulWidget {
  const SettingsTap({super.key});

  @override
  State<SettingsTap> createState() => _SettingTapState();
}

class _SettingTapState extends State<SettingsTap> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.lang),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              languageBottomSheet();
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accentColor),
              ),
              child: Row(
                children: [
                  Text(
                    pro.languageCode == "en"
                        ? AppLocalizations.of(context)!.eng
                        : AppLocalizations.of(context)!.arab,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: accentColor,
                        ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_drop_up,
                    color: pro.isLight() ? Colors.black54 : accentColor,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(AppLocalizations.of(context)!.mode),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              themingBottomSheet();
            },
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 18),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: accentColor),
              ),
              child: Row(
                children: [
                  Text(
                    pro.isLight()
                        ? AppLocalizations.of(context)!.light
                        : AppLocalizations.of(context)!.dark,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: accentColor,
                        ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_drop_up,
                    color: pro.isLight() ? Colors.black54 : accentColor,
                  ),
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
