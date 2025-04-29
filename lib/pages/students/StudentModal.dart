import 'package:crud_flutter/pages/students/services/firestoreStudent.dart';
import 'package:flutter/material.dart';

class StudentFormModal extends StatefulWidget {
  final String? id;
  final String? name;
  final String? age;
  final String? department;

  const StudentFormModal({
    super.key,
    this.id,
    this.name,
    this.age,
    this.department,
  });

  @override
  State<StudentFormModal> createState() => _StudentFormModalState();
}

class _StudentFormModalState extends State<StudentFormModal> {
  final FirestoreStudentService firestoreStudentService = FirestoreStudentService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name ?? '';
    _ageController.text = widget.age ?? '';
    _departmentController.text = widget.department ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.id == null ? 'Enter Student Details' : 'Update Student Details',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter age';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: _departmentController,
                      decoration: InputDecoration(
                        labelText: 'Department',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter department';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (widget.id == null) {
                              firestoreStudentService.addStudent(
                                _nameController.text,
                                _ageController.text,
                                _departmentController.text,
                              );
                            } else {
                              firestoreStudentService.updateStudents(
                                widget.id!,
                                _nameController.text,
                                _ageController.text,
                                _departmentController.text,
                              );
                            }

                            _nameController.clear();
                            _ageController.clear();
                            _departmentController.clear();

                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          child: Text(
                            widget.id == null ? 'Submit' : 'Update',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}