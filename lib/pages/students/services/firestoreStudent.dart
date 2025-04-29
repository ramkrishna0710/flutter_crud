import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreStudentService {
  // get collection of notes
  final CollectionReference students = FirebaseFirestore.instance.collection(
    'students',
  );

  // CREATE: ADD A NEW STUDENTS
  Future<void> addStudent(String name, String age, String department) {
    return students.add({'name': name, 'age': age, 'department': department, 'timestamp': Timestamp.now()});
  }

  // READ: GET STUDENTS FROM DATABASE
  Stream<QuerySnapshot> getStudentStream() {
    final studentsStream =
    students.orderBy('timestamp', descending: true).snapshots();

    return studentsStream;
  }

  // UPDATE: UPDATE STUDENTS GIVEN A DOC ID
  Future<void> updateStudents(String docId, String name, String age, String department) {
    return students.doc(docId).update({
      'name': name, 'age': age, 'department': department,
      'timestamp': Timestamp.now(),
    });
  }

  // DELETE: DELETE STUDENTS GIVEN A DOC ID
  Future<void> deleteStudents(String docId) {
    return students.doc(docId).delete();
  }
}
