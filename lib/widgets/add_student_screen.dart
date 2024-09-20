import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  final Function(String, String, String, String, bool) onAddStudent;

  const AddStudentScreen({super.key, required this.onAddStudent});

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
      title: const Text('Add New Student', style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(_firstNameController, 'First Name'),
            const SizedBox(height: 10),
            _buildTextField(_lastNameController, 'Last Name'),
            const SizedBox(height: 10),
            _buildTextField(_courseController, 'Course'),
            const SizedBox(height: 10),
            _buildDropdown(),
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Enrolled', style: TextStyle(fontWeight: FontWeight.w500)),
              value: _isEnrolled,
              onChanged: (bool newValue) {
                setState(() {
                  _isEnrolled = newValue;
                });
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Add', style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () {
            final String firstName = _firstNameController.text;
            final String lastName = _lastNameController.text;
            final String course = _courseController.text;

            if (firstName.isNotEmpty &&
                lastName.isNotEmpty &&
                course.isNotEmpty &&
                _selectedYear != null) {
              widget.onAddStudent(firstName, lastName, course, _selectedYear!, _isEnrolled);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Select Year',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
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
    );
  }
}
