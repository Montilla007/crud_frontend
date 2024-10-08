// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchData() async {
  try {
    final response = await http.get(Uri.parse('https://crud-backend-inky.vercel.app/api/v1/student'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
    // return [
    //   {
    //     "name": "Mock Item 1",
    //     "value": 42
    //   },
    //   {
    //     "name": "Mock Item 2",
    //     "value": 27
    //   }
    // ];
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load data');
  }
}
