import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todos/model/todo.dart';
import 'package:todos/service/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodosApp(),
    );
  }
}

class TodosApp extends StatefulWidget {
  @override
  _TodosAppState createState() => _TodosAppState();
}

class _TodosAppState extends State<TodosApp> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<Todo> notes = [];

  CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('to-do');

  @override
  void initState() {
    super.initState();
    _getNotes();
  }

  Future<void> _getNotes() async {
    QuerySnapshot querySnapshot = await notesCollection.get();
    setState(() {
      notes = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Todo(
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          isComplete: data['isComplete'] ?? '',
          uid: '',
        );
      }).toList();
    });
  }

  Future<void> _searchNotes(String query) async {
    try {
      QuerySnapshot querySnapshot = await notesCollection
          .where('title', isGreaterThanOrEqualTo: query)
          .get();

      setState(() {
        notes = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Todo(
            title: data['title'] ?? '',
            description: data['description'] ?? '',
            isComplete: data['isComplete'] ?? '',
            uid: '',
          );
        }).toList();
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addData() async {
    try {
      final id = notesCollection.doc().id;
      await notesCollection.doc(id).set({
        'title': 'Belajar Flutter',
        'description': 'Belajar Flutter di Bengkel Koding',
        'isComplete': id,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveNote() async {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title.isNotEmpty || description.isNotEmpty) {
      await notesCollection.add({
        'title': title,
        'description': description,
        'isComplete': false, // atau sesuaikan dengan kebutuhan Anda
      });
      titleController.clear();
      descriptionController.clear();
      _getNotes();
    }
  }

  Future<void> _deleteNote(bool isComplete) async {
    await notesCollection.doc(isComplete.toString()).delete();
    _getNotes();
  }

  Future<void> _updateNote(bool isComplete) async {
    String title = titleController.text;
    String description = descriptionController.text;

    if (title.isNotEmpty || description.isNotEmpty) {
      await notesCollection.doc(isComplete.toString()).update({
        'title': title,
        'description': description,
      });
      titleController.clear();
      descriptionController.clear();
      _getNotes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplikasi Catatan'),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Judul Catatan'),
            ),
          ),
          ListTile(
            title: TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Isi Catatan'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    titleController.clear();
                    descriptionController.clear();
                  });
                },
                icon: Icon(Icons.delete, color: Colors.black54),
                label: Text('Clear', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Update data dengan menggunakan isComplete terakhir
                  if (notes.isNotEmpty) {
                    _updateNote(notes.last.isComplete);
                  }
                },
                icon: Icon(Icons.save, color: Colors.black54),
                label: Text('Update', style: TextStyle(color: Colors.black)),
              ),
              SizedBox(width: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Delete data dengan menggunakan isComplete terakhir
                  if (notes.isNotEmpty) {
                    _deleteNote(notes.last.isComplete);
                  }
                },
                icon: Icon(Icons.delete, color: Colors.black54),
                label: Text('Delete', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 25.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(30.0), // Border circular bulat
              color: Colors.grey[300],
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.black54), // Logo 'search'
                SizedBox(width: 10.0), // Ruang antara logo dan TextField
                Expanded(
                  child: TextField(
                    onChanged: _searchNotes,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: addData,
                child: Text('Tambah Data (add)'),
              ),
              SizedBox(width: 20),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteNote(note.isComplete),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
