abstract class CryptoI {
  Future<Map<String, String>> generateRSAKeyPairInIsolate();
  String privateKeyToString(dynamic privateKey);
  String publicKeyToString(dynamic publicKey);
  String derivePublicKeyFromPrivate(String privateKeyPem);
}
