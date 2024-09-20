import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> addItem(String firstName, String lastName, String course, String year, bool enrolled) async {
  final response = await http.post(
    Uri.parse('https://crud-backend-inky.vercel.app/api/v1/student'),
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
