import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/my_provider.dart';
import '../../shared/styles/my_theme_data.dart';

class ThemingBottomSheet extends StatelessWidget {
  const ThemingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              pro.changeTheme(ThemeMode.light);
            },
            child: Row(
              children: [
                Text(
                  "Light",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: pro.modeApp == ThemeMode.light
                          ? MyThemeData.accentColor
                          : Colors.black54),
                ),
                const Spacer(),
                pro.modeApp == ThemeMode.light
                    ? Icon(
                        Icons.check,
                        size: 30,
                        color: pro.modeApp == ThemeMode.light
                            ? MyThemeData.accentColor
                            : Colors.black54,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
          InkWell(
            onTap: () {
              pro.changeTheme(ThemeMode.dark);
            },
            child: Row(
              children: [
                Text("Dark",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: pro.modeApp == ThemeMode.dark
                            ? MyThemeData.accentColor
                            : Colors.black54)),
                const Spacer(),
                pro.modeApp == ThemeMode.light
                    ? const SizedBox.shrink()
                    : Icon(
                        Icons.check,
                        size: 30,
                        color: pro.modeApp == ThemeMode.dark
                            ? MyThemeData.accentColor
                            : Colors.black54,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
