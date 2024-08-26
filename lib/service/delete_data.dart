import 'package:http/http.dart' as http;

Future<void> deleteItem(String id) async {
  final response = await http.delete(
    Uri.parse('http://192.168.1.172:5001/data/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to delete student');
  }
}
