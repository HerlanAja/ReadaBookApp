// lib/models/book_model.dart
class Book {
  final String id;
  final String name;
  final String author;
  final String description;
  final String imagePath;

  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.description,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'description': description,
      'imagePath': imagePath,
    };
  }
}
