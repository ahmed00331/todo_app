class TaskModel {
  String id;
  String title;
  String description;
  String userId;
  int date;
  bool isDone;

  TaskModel(
      {this.id = "",
      required this.title,
      required this.description,
      required this.date,
      required this.userId,
      this.isDone = false});

  TaskModel.fromJason(Map<String, dynamic> jason)
      : this(
            title: jason["title"],
            description: jason["description"],
            date: jason["date"],
            id: jason["id"],
            userId: jason["userId"],
            isDone: jason["isDone"]);

  Map<String, dynamic> toJason() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "id": id,
      "userId": userId,
      "isDone": isDone
    };
  }
}
