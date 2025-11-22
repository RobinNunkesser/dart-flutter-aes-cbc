import 'dart:convert';

import 'package:encrypter_plus/encrypter_plus.dart';
import 'package:test/test.dart';
import 'dart:typed_data';

void main() {
  test('Encryption and decryption', () {
    final plainText =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
    final messageAuthenticationCode = 'flutter is awesome';

    final key = Key.fromSecureRandom(32);
    final iv = IV.fromSecureRandom(16);
    final macValue = Uint8List.fromList(utf8.encode(messageAuthenticationCode));

    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));

    final encrypted = encrypter.encrypt(
      plainText,
      iv: iv,
      associatedData: macValue,
    );
    final decrypted = encrypter.decrypt(
      encrypted,
      iv: iv,
      associatedData: macValue,
    );

    print(decrypted);
    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);

    expect(decrypted, plainText);
  });
}
