import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:new_university_communication/service/crypto/crypto_i.dart';
import 'package:pointycastle/export.dart';
import 'dart:typed_data';

class Crypto implements CryptoI {
  Crypto() {}

  factory Crypto.defaultInstance() {
    return Crypto();
  }

  @override
  String derivePublicKeyFromPrivate(String privateKeyPem) {
    String cleanPrivateKey;
    if (!privateKeyPem.contains("-----BEGIN PRIVATE KEY-----")) {
      cleanPrivateKey = "-----BEGIN PRIVATE KEY-----\n" +
          privateKeyPem.replaceAll(RegExp(r'\s+'), '') +
          "\n-----END PRIVATE KEY-----";
    } else {
      cleanPrivateKey = privateKeyPem;
    }
    final privateKey = CryptoUtils.rsaPrivateKeyFromPem(cleanPrivateKey);

    final publicKey = RSAPublicKey(privateKey.n!, privateKey.exponent!);

    final convertKey = CryptoUtils.encodeRSAPublicKeyToPem(publicKey);
    String cleanPublicKey = convertKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .replaceAll("\n", "")
        .trim();
    return cleanPublicKey;
  }

  @override
  Future<Map<String, String>> generateRSAKeyPairInIsolate() async {
    return await compute(_generateRSAKeyPair, null);
  }

  Map<String, String> _generateRSAKeyPair(dynamic _) {
    final secureRandom = FortunaRandom();
    secureRandom.seed(KeyParameter(Uint8List.fromList(List.generate(
      32,
      (_) => DateTime.now().millisecondsSinceEpoch % 256,
    ))));

    final keyGen = RSAKeyGenerator()
      ..init(ParametersWithRandom(
        RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 12),
        secureRandom,
      ));

    final generetKeys = keyGen.generateKeyPair();

    final privateKey = generetKeys.privateKey as RSAPrivateKey;

    final formatPrivetKey = this.privateKeyToString(privateKey);
    final formatPublicKey = this.derivePublicKeyFromPrivate(formatPrivetKey);
    String cleanPrivateKey = formatPrivetKey
        .replaceAll('-----BEGIN PRIVATE KEY-----', '')
        .replaceAll('-----END PRIVATE KEY-----', '')
        .trim();

    String cleanPublicKey = formatPublicKey
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '')
        .trim();
    return {
      "privateKey": cleanPrivateKey.replaceAll("\n", "").trim(),
      "publicKey": cleanPublicKey.replaceAll("\n", "").trim()
    };
  }

  @override
  String privateKeyToString(privateKey) {
    final formatkey = privateKey as RSAPrivateKey;

    return CryptoUtils.encodeRSAPrivateKeyToPem(formatkey);
  }

  @override
  String publicKeyToString(publicKey) {
    final formatkey = publicKey as RSAPublicKey;
    return CryptoUtils.encodeRSAPublicKeyToPem(formatkey);
  }
}
