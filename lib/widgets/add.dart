import 'dart:convert';

import 'package:http/http.dart' as http;

class TodoService {
  static Future<List?> fetchTodo() async {
    // setState(() {
    //   isLoading = true;
    // });
    final url = "https://api.nstack.in/v1/todos?page=1&limit=15";
    final uri = Uri.parse(url);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;
      return result;
    } else
      return null;
  }
}
