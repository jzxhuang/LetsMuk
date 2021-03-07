import 'dart:async';
import 'package:letsmuk/shared/constants.dart';

import 'package:http/http.dart' as http;

class SecretMukService {
  Future<void> hackhack(String uid) async {
    print('YYY');
    http.post(Uri.https(API_URL, 'super_secret_muk',
        {'agora_uid': uid.substring(0, 10), 'google_uid': uid}));
  }
}
