import 'dart:io';

Future<bool> HAS_INTERNET() async {
  try {
    // Lookup a highly available global domain
    final result = await InternetAddress.lookup('google.com');
    
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true; // Internet is working
    }
  } on SocketException catch (_) {
    return false; // No internet or DNS lookup failed
  }
  return false;
}