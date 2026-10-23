import 'dart:convert';
import 'package:http/http.dart' as http;

class GifRepository {
  final http.Client _client;
  final bool _ownsClient;
  final String apiKey;
  GifRepository(
      {http.Client? client,
      this.apiKey = const String.fromEnvironment('GIPHY_API_KEY')})
      : _client = client ?? http.Client(),
        _ownsClient = client == null;

  Future<Map<String, dynamic>> fetch({String? search, int offset = 0}) async {
    if (apiKey.isEmpty) throw StateError('Configure GIPHY_API_KEY.');
    if (offset < 0) throw ArgumentError.value(offset, 'offset');
    final uri = Uri.https('api.giphy.com',
        search == null ? '/v1/gifs/trending' : '/v1/gifs/search', {
      'api_key': apiKey,
      'limit': '19',
      'rating': 'g',
      'lang': 'pt',
      if (search != null) 'q': search,
      if (search != null) 'offset': '$offset',
    });
    final response = await _client.get(uri);
    if (response.statusCode != 200)
      throw StateError('Falha ao consultar GIFs (${response.statusCode}).');
    final body = jsonDecode(response.body);
    if (body is! Map<String, dynamic> || body['data'] is! List) {
      throw const FormatException('Resposta de GIFs inválida.');
    }
    return body;
  }

  void close() {
    if (_ownsClient) _client.close();
  }
}
