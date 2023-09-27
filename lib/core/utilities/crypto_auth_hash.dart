import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

String _rsaKey =
    "-----BEGIN PUBLIC KEY-----\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDr/Wj9Qwsu/e5rqh0V4M909gPjKN5/woboOVD/jtlfEwAbUke/giXEyT9onqlsMYQeFgO5f9z1Z2Ce7WKCdZawi+p0fohzULrPcxGlsOC4GjBOHinsP5L/axUj3hX0mtVJ6TsWNIyKT02A+fJ9xBy62qS3Xo2773Cppt5APQYv8wIDAQAB";

class CryptoAuthHash {
  Encrypted? encryptRSA(String md5Password) {
    final publicKey = RSAKeyParser().parse(_rsaKey) as RSAPublicKey;
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encrypter.encrypt(md5Password);
    return encrypted;
  }
}
