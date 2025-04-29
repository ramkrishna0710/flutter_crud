import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // firestore
  final FireStoreService fireStoreService = FireStoreService();

  // text controller
  final TextEditingController textEditingController = TextEditingController();

  // open a dialog box to add a note
  void openNoteBox({String? docId}) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(controller: textEditingController),
            actions: [
              //button to save
              ElevatedButton(
                onPressed: () {
                  // add a new node
                  if (docId == null) {
                    fireStoreService.addNote(textEditingController.text);
                  } else {
                    fireStoreService.updateNote(
                      docId,
                      textEditingController.text,
                    );
                  }

                  //clear the text controller
                  textEditingController.clear();

                  // close the box
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getNotesStream(),
        builder: (context, snapshot) {
          // if we have data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // display as a list
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // get the individual doc
                DocumentSnapshot documentSnapshot = notesList[index];
                String docId = documentSnapshot.id;

                // get note from each doc
                Map<String, dynamic> data =
                    documentSnapshot.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // display as a list title
                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => openNoteBox(docId: docId),
                        icon: Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () => fireStoreService.deleteNode(docId),
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text("No Notes...");
          }
        },
      ),
    );
  }
}
