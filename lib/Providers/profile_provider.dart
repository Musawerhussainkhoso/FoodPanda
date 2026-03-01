import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  String _name = 'Guest User';
  String _email = 'guest@example.com';
  String _phone = '';
  String? _profileImageBase64;

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String? get profileImageBase64 => _profileImageBase64;
  bool get hasProfileImage => _profileImageBase64 != null && _profileImageBase64!.isNotEmpty;

  ProfileProvider() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    _name = prefs.getString('profile_name') ?? 'Guest User';
    _email = prefs.getString('profile_email') ?? 'guest@example.com';
    _phone = prefs.getString('profile_phone') ?? '';
    _profileImageBase64 = prefs.getString('profile_image_base64');
    notifyListeners();
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    if (name != null) _name = name;
    if (email != null) _email = email;
    if (phone != null) _phone = phone;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_name', _name);
    await prefs.setString('profile_email', _email);
    await prefs.setString('profile_phone', _phone);
    notifyListeners();
  }

  Future<void> setProfileImageFromBytes(List<int> bytes) async {
    try {
      _profileImageBase64 = base64Encode(bytes);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_base64', _profileImageBase64!);
      notifyListeners();
    } catch (e) {
      debugPrint('Error saving profile image: $e');
    }
  }

  void clearProfileImage() {
    _profileImageBase64 = null;
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('profile_image_base64');
      notifyListeners();
    });
  }
}
