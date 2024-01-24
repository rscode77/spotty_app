import 'package:encrypt_decrypt_plus/cipher/cipher.dart';
import 'package:spotty_app/services/firebase_config_service.dart';

class EncryptionService {
  final FirebaseRemoteConfigService _remoteConfig = FirebaseRemoteConfigService();

  EncryptionService();

  String decryptData(String encryptedTxt) {
    Cipher cipher = Cipher(secretKey: _remoteConfig.encryptionKey);
    return cipher.xorDecode(encryptedTxt);
  }

  String encrypt(String message) {
    Cipher cipher = Cipher(secretKey: _remoteConfig.encryptionKey);
    return cipher.xorEncode(message);
  }
}
