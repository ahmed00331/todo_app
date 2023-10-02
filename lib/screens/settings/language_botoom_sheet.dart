import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/my_provider.dart';

import '../../shared/styles/my_theme_data.dart';

class LanguageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      color: pro.modeApp == ThemeMode.light
          ? const Color(0xffffffff)
          : const Color(0xff141922),
      height: MediaQuery.of(context).size.height * .2,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pro.changeLanguage("en");
            },
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.eng,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: pro.languageCode == "en"
                          ? MyThemeData.accentColor
                          : Colors.grey),
                ),
                const Spacer(),
                pro.languageCode == "en"
                    ? Icon(
                  Icons.check,
                  size: 30,
                  color: pro.languageCode == "en"
                      ? MyThemeData.accentColor
                      : Colors.black54,
                )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          InkWell(
            onTap: () {
              pro.changeLanguage("ar");
            },
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.arab,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: pro.languageCode == "ar"
                            ? MyThemeData.accentColor
                            : Colors.grey)),
                const Spacer(),
                pro.languageCode == "en"
                    ? const SizedBox.shrink()
                    : Icon(
                        Icons.check,
                        size: 30,
                        color: pro.languageCode == "ar"
                            ? MyThemeData.accentColor
                            : Colors.black54,
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
