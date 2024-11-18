import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  final String clientId = 'c78c6e9431a84790bd4affe04258d00d';
  final String clientSecret = 'e35f48f9f2844ff5a10a46dd1a8efa94';
  final String redirectUri = 'http://localhost:5173/callback';

  Future<String?> exchangeToken(String code) async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      print('Error exchanging token: ${response.body}');
      return null;
    }
  }
}
