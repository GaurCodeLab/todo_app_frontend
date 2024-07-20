class ToDo {
  final int id;
  final String title;
  final String description;
  bool isCompleted;

  ToDo({
    required this.id,
    required this.description,
    required this.title,
    required this.isCompleted,
  });

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': isCompleted,
    };
  }
}
