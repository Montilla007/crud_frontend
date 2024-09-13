import 'package:flutter/material.dart';

import '../service/delete_data.dart';
import '../service/update_data.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DetailsScreen({super.key, required this.item});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _courseController;
  String? _selectedYear;
  bool _isEnrolled = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.item['firstName']);
    _lastNameController = TextEditingController(text: widget.item['lastName']);
    _courseController = TextEditingController(text: widget.item['course']);
    _selectedYear = widget.item['year'];
    _isEnrolled = widget.item['enrolled'];
  }

  void _updateItem() async {
    final updatedItem = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'course': _courseController.text,
      'year': _selectedYear,
      'enrolled': _isEnrolled,
    };

    await updateItem(widget.item['_id'], updatedItem);
    Navigator.of(context).pop(true);  // Return true to indicate the update was successful
  }

  void _deleteItem() async {
    await deleteItem(widget.item['_id']);
    Navigator.of(context).pop(true);  // Return true to indicate the deletion was successful
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
            SwitchListTile(
              title: const Text('Enrolled'),
              value: _isEnrolled,
              onChanged: (bool newValue) {
                setState(() {
                  _isEnrolled = newValue;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: _deleteItem,
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.update),
                  label: const Text('Update'),
                  onPressed: _updateItem,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
