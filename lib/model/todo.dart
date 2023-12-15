class Todo {
  final String uid;
  final String title;
  final String description;
  final bool isComplete;

  Todo({
    required this.uid,
    required this.title,
    required this.description,
    required this.isComplete,
  });

  // Membuat objek Todo dari Map (misalnya, data dari Firestore)
  factory Todo.fromMap(Map<String, dynamic> data, String documentId) {
    return Todo(
      uid: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isComplete: data['isComplete'] ?? false,
    );
  }

  // Mengonversi objek Todo ke Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isComplete': isComplete,
    };
  }
}
