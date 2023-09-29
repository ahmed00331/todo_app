import 'package:flutter/material.dart';

import '../../shared/styles/my_theme_data.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
                child: VerticalDivider(
                  width: 30,
                  thickness: 5,
                  color: MyThemeData.accentColor,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task One",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: MyThemeData.accentColor, fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("Description",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 15)),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: MyThemeData.accentColor),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check),
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
