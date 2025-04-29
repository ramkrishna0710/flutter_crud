import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_flutter/pages/students/StudentModal.dart';
import 'package:crud_flutter/pages/students/services/firestoreStudent.dart';
import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final FirestoreStudentService firestoreStudentService = FirestoreStudentService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreStudentService.getStudentStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List studentsList = snapshot.data!.docs;

            // Check if the list is empty
            if (studentsList.isEmpty) {
              return const Center(child: Text("No students available."));
            }

            return ListView.builder(
              itemCount: studentsList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot snapshot = studentsList[index];
                String docId = snapshot.id;
                Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

                // Fetch fields from Firestore, with fallback values for missing data
                String name = data['name']?.toString().trim() ?? '';
                String age = data['age']?.toString().trim() ?? '';
                String department = data['department']?.toString().trim() ?? '';

                // Only display the card if the data is not empty
                if (name.isEmpty || age.isEmpty || department.isEmpty) {
                  return const SizedBox.shrink(); // Empty space instead of card
                }

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Display the first letter of the name in a CircleAvatar
                        CircleAvatar(
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display the student's name
                              Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Display age and department with labels
                              Text(
                                "Age: $age  |  Dept: $department",
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      ),
                                      builder: (context) => StudentFormModal(
                                        id: snapshot.id,
                                        name: name,
                                        age: age,
                                        department: department,
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit, color: Colors.blueGrey,),
                                ),
                                IconButton(
                                    onPressed: () => firestoreStudentService.deleteStudents(docId),
                                    icon: Icon(Icons.delete, color: Colors.red,)
                                ),
                              ],
                            )
                        ),

                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading students."));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // Show bottom sheet to add a new student
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const StudentFormModal(),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: const Text(
            "Add Student",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}