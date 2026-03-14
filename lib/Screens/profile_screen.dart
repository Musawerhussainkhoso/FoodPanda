import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:foodpanda_app/Screens/delivery_addresses_screen.dart';
import 'package:foodpanda_app/Screens/payment_methods_screen.dart';
import 'package:foodpanda_app/Screens/Login_Screen.dart';
import 'package:foodpanda_app/Providers/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profile, _) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile Header Card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(24, 0, 24, 32),
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      // Profile Photo with Upload
                      GestureDetector(
                        onTap: () => _showImagePickerOptions(context, profile),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.white,
                                backgroundImage: profile.hasProfileImage
                                    ? MemoryImage(base64Decode(profile.profileImageBase64!))
                                    : null,
                                child: !profile.hasProfileImage
                                    ? Icon(
                                        Icons.person,
                                        size: 50,
                                        color: AppTheme.primaryColor.withOpacity(0.5),
                                      )
                                    : null,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 20,
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        profile.name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        profile.email,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      if (profile.phone.isNotEmpty) ...[
                        SizedBox(height: 4),
                        Text(
                          profile.phone,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                      SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: () => _showEditProfileDialog(context, profile),
                        icon: Icon(Icons.edit, size: 18, color: Colors.white),
                        label: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white, width: 1.5),
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ),

                // Account Section
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildProfileCard(
                        context,
                        children: [
                          _buildListTile(
                            icon: Icons.location_on_outlined,
                            title: 'Delivery addresses',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DeliveryAddressesScreen(),
                                ),
                              );
                            },
                          ),
                          Divider(height: 1),
                          _buildListTile(
                            icon: Icons.payment_outlined,
                            title: 'Payment methods',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const PaymentMethodsScreen(),
                                ),
                              );
                            },
                          ),
                          Divider(height: 1),
                          _buildListTile(
                            icon: Icons.notifications_outlined,
                            title: 'Notifications',
                            trailing: Switch(
                              value: true,
                              onChanged: (v) {},
                              activeThumbColor: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Support',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildProfileCard(
                        context,
                        children: [
                          _buildListTile(
                            icon: Icons.help_outline,
                            title: 'Help Center',
                            onTap: () {},
                          ),
                          Divider(height: 1),
                          _buildListTile(
                            icon: Icons.privacy_tip_outlined,
                            title: 'Privacy Policy',
                            onTap: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (route) => false,
                            );
                          },
                          icon: Icon(Icons.logout, size: 20),
                          label: Text('Logout'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: BorderSide(color: Colors.red),
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor, size: 22),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      trailing: trailing ?? Icon(Icons.chevron_right, color: Colors.grey[400]),
      onTap: onTap,
    );
  }

  void _showImagePickerOptions(BuildContext context, ProfileProvider profile) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Profile Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                  child: Icon(Icons.camera_alt, color: AppTheme.primaryColor),
                ),
                title: Text('Take Photo'),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    profile.setProfileImageFromBytes(bytes);
                  }
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                  child: Icon(Icons.photo_library, color: AppTheme.primaryColor),
                ),
                title: Text('Choose from Gallery'),
                onTap: () async {
                  Navigator.pop(context);
                  final picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    final bytes = await image.readAsBytes();
                    profile.setProfileImageFromBytes(bytes);
                  }
                },
              ),
              if (profile.hasProfileImage)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red.withOpacity(0.2),
                    child: Icon(Icons.delete, color: Colors.red),
                  ),
                  title: Text('Remove Photo', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(context);
                    profile.clearProfileImage();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, ProfileProvider profile) {
    final nameController = TextEditingController(text: profile.name);
    final emailController = TextEditingController(text: profile.email);
    final phoneController = TextEditingController(text: profile.phone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      profile.updateProfile(
                        name: nameController.text.trim().isEmpty ? null : nameController.text.trim(),
                        email: emailController.text.trim().isEmpty ? null : emailController.text.trim(),
                        phone: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
