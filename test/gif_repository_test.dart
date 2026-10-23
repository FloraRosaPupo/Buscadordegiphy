import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_application_5/features/gifs/data/gif_repository.dart';

void main() {
  test('codifica busca e paginação sem modificar o termo', () async {
    final client = MockClient((request) async {
      expect(request.url.path, '/v1/gifs/search');
      expect(request.url.queryParameters['q'], 'gato & café');
      expect(request.url.queryParameters['offset'], '19');
      return http.Response('{"data":[]}', 200);
    });
    addTearDown(client.close);
    expect(
        await GifRepository(client: client, apiKey: 'test')
            .fetch(search: 'gato & café', offset: 19),
        {'data': []});
  });
  test('falha HTTP é propagada e resposta inválida é rejeitada', () async {
    final failed = MockClient((_) async => http.Response('', 503));
    final invalid =
        MockClient((_) async => http.Response('{"data":null}', 200));
    addTearDown(failed.close);
    addTearDown(invalid.close);
    await expectLater(GifRepository(client: failed, apiKey: 'test').fetch(),
        throwsStateError);
    await expectLater(GifRepository(client: invalid, apiKey: 'test').fetch(),
        throwsFormatException);
  });
}
