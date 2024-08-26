import 'dart:convert';

import 'package:http/http.dart' as http;

// Function to add a new item to the backend
Future<void> addItem(String firstName, String lastName, String course, String year, bool enrolled) async {
  // Replace with your actual backend URL
  final response = await http.post(
    Uri.parse('http://192.168.1.172:5001/data'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'course': course,
      'year': year,
      'enrolled': enrolled,
    }),
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to add item');
  }
}
