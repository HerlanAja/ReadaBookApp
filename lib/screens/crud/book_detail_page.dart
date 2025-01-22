// lib/screens/crud/book_detail_page.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:frontend/models/book_model.dart';
import 'package:frontend/sql/database_helper.dart';
import 'dart:io';

class BookDetailPage extends StatelessWidget {
  final Book book;
  late final DatabaseHelper _databaseHelper;

  BookDetailPage({Key? key, required this.book}) : super(key: key) {
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tampilkan gambar buku
              book.imagePath.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(book.imagePath),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Text(
                'Author: ${book.author}',
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Description:',
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                book.description,
                style: GoogleFonts.poppins(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Tombol Update dan Delete
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await _showUpdateDialog(context);
                        },
                        child: Text('Update'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await _confirmDelete(context);
                      },
                      child: Text('Delete'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showUpdateDialog(BuildContext context) async {
    final TextEditingController nameController = TextEditingController(text: book.name);
    final TextEditingController authorController = TextEditingController(text: book.author);
    final TextEditingController descriptionController = TextEditingController(text: book.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Book', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: authorController,
                  decoration: InputDecoration(labelText: 'Author'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                // Update buku
                final updatedBook = {
                  'id': book.id,
                  'name': nameController.text,
                  'author': authorController.text,
                  'description': descriptionController.text,
                  'imagePath': book.imagePath,
                };
                await _databaseHelper.updateBook(updatedBook);
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Update', style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to delete this book?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (shouldDelete == true) {
      try {
        await _databaseHelper.deleteBook(book.id);
        print('Book with ID ${book.id} deleted successfully');
        Navigator.of(context).pop(); // Tutup halaman detail
      } catch (e) {
        print('Error deleting book: $e');
      }
    }
  }
}
