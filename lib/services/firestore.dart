import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  // get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection(
    'notes',
  );

  // CREATE: ADD A NEW NOTES
  Future<void> addNote(String note) {
    return notes.add({'note': note, 'timestamp': Timestamp.now()});
  }

  // READ: GET NODES FROM DATABASE
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }

  // UPDATE: UPDATE NOTES GIVEN A DOC ID
  Future<void> updateNote(String docId, String newNote) {
    return notes.doc(docId).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: DELETE NOTES GIVEN A DOC ID
  Future<void> deleteNode(String docId) {
    return notes.doc(docId).delete();
  }
}
