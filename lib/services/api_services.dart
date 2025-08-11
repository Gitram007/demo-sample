import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://127.0.0.1:8000/api/notes/';

Future<List<dynamic>> fetchNotes() async {
  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load notes');
  }
}

Future<void> createNote(String title, String content) async {
  final response = await http.post(
    Uri.parse(baseUrl),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'title': title, 'content': content}),
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to create note');
  }
}
