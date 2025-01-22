import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:frontend/sql/database_helper.dart';
import 'package:frontend/models/book_model.dart';
import 'package:frontend/utils/image_helper.dart';
import 'package:frontend/utils/constants.dart';  

class AddItemPage extends StatefulWidget {
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final TextEditingController _bookIdController = TextEditingController();
  final TextEditingController _bookNameController = TextEditingController();
  final TextEditingController _authorNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _addBook() async {
    if (_bookIdController.text.isNotEmpty && _bookNameController.text.isNotEmpty) {
      Book newBook = Book(
        id: _bookIdController.text,
        name: _bookNameController.text,
        author: _authorNameController.text,
        description: _descriptionController.text,
        imagePath: _imageFile?.path ?? '',
      );

      await _databaseHelper.insertBook(newBook.toMap());
      _clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book added successfully!')),
      );

      // Kembalikan data buku yang baru ditambahkan ke halaman sebelumnya
      Navigator.pop(context, newBook);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  // Metode lainnya tetap sama...

  void _clearFields() {
    _bookIdController.clear();
    _bookNameController.clear();
    _authorNameController.clear();
    _descriptionController.clear();
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appName)),
      body: Padding(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            TextField(
              controller: _bookIdController,
              decoration: InputDecoration(labelText: 'Book ID'),
            ),
            TextField(
              controller: _bookNameController,
              decoration: InputDecoration(labelText: 'Book Name'),
            ),
            TextField(
              controller: _authorNameController,
              decoration: InputDecoration(labelText: 'Author Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: smallPadding),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            if (_imageFile != null)
              Image.file(_imageFile!, height: 100, width: 100),
            SizedBox(height: smallPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _addBook,
                  child: Text('Add Book'),
                ),
                // Tombol lainnya tetap sama...
              ],
            ),
          ],
        ),
      ),
    );
  }
}
