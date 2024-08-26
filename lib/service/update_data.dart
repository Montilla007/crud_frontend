import 'dart:convert';

import 'package:http/http.dart' as http;

Future<void> updateItem(String id, Map<String, dynamic> updatedItem) async {
  final response = await http.put(
    Uri.parse('https://crud-backend-inky.vercel.app/api/v1/student/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(updatedItem),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update student');
  }
}
