class TodoItemClass{
  String title;
  bool isDone = false;
  int id = DateTime.now().millisecondsSinceEpoch;


  TodoItemClass({required this.title});

  TodoItemClass.fromJson(Map<String, dynamic> json)
    : title = json['title'],
      isDone = json['isDone'],
      id = json['id'];

  Map<String, dynamic> toJson() => {
    'title': title,
    'isDone': isDone,
    'id': id
  };

}