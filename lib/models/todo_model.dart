class ToDo {
  final int id;
  final String title;
  final String description;
  bool isCompleted;
  DateTime? dueDate;

  ToDo(
      {required this.id,
      required this.description,
      required this.title,
      required this.isCompleted,
      required this.dueDate});

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isCompleted: json['completed'] ?? false,
      dueDate:
          json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': isCompleted,
      'dueDate': dueDate?.toIso8601String() 
    };
  }
}
