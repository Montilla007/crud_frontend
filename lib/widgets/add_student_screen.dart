import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  final Function(String, String, String, String, bool) onAddStudent;

  AddStudentScreen({required this.onAddStudent});

  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  String? _selectedYear;
  bool _isEnrolled = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Student'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(labelText: 'First Name'),
          ),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(labelText: 'Last Name'),
          ),
          TextField(
            controller: _courseController,
            decoration: const InputDecoration(labelText: 'Course'),
          ),
          DropdownButton<String>(
            hint: const Text('Select Year'),
            value: _selectedYear,
            onChanged: (String? newValue) {
              setState(() {
                _selectedYear = newValue;
              });
            },
            items: <String>[
              'First Year',
              'Second Year',
              'Third Year',
              'Fourth Year',
              'Fifth Year'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          CheckboxListTile(
            title: const Text('Enrolled'),
            value: _isEnrolled,
            onChanged: (bool? newValue) {
              setState(() {
                _isEnrolled = newValue ?? false;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            final String firstName = _firstNameController.text;
            final String lastName = _lastNameController.text;
            final String course = _courseController.text;

            if (firstName.isNotEmpty &&
                lastName.isNotEmpty &&
                course.isNotEmpty &&
                _selectedYear != null) {
              widget.onAddStudent(firstName, lastName, course, _selectedYear!, _isEnrolled);
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
