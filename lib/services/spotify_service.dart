import 'dart:convert';
import 'package:http/http.dart' as http;

class SpotifyService {
  final String clientId = '809e9a055f604342a727aa3961f343d2';
  final String clientSecret = '6aa9ae2264094650a6af77b3eef14903';
  final String redirectUri = 'https://dapper-swan-46f09f.netlify.app';

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
