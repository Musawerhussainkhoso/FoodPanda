import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodpanda_app/Screens/Login_Screen.dart';
import 'package:foodpanda_app/utils/app_theme.dart';
import 'package:foodpanda_app/widgets/food_express_app_bar.dart';

/// App settings similar to food-delivery apps: account links, notifications,
/// regional preferences, legal, and account actions.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _orderUpdates = true;
  bool _promoNotifications = true;
  bool _emailDigest = false;
  String _language = 'English';
  String _region = 'United States';

  Future<void> _pickLanguage() async {
    final chosen = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'App language',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            ...['English', 'Español', 'Français', 'العربية'].map(
              (lang) => ListTile(
                title: Text(lang),
                trailing: _language == lang
                    ? Icon(Icons.check_rounded, color: AppTheme.primaryColor)
                    : null,
                onTap: () => Navigator.pop(ctx, lang),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (chosen != null) setState(() => _language = chosen);
  }

  Future<void> _pickRegion() async {
    final chosen = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Country / region',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            ...[
              'United States',
              'United Kingdom',
              'Canada',
              'Pakistan',
            ].map(
              (r) => ListTile(
                title: Text(r),
                trailing: _region == r
                    ? Icon(Icons.check_rounded, color: AppTheme.primaryColor)
                    : null,
                onTap: () => Navigator.pop(ctx, r),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (chosen != null) setState(() => _region = chosen);
  }

  void _showLegalSheet(String title, String body) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.65,
        minChildSize: 0.4,
        maxChildSize: 0.92,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Text(
                  body,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.grey[600],
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _settingsCard(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(children: children),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: const FoodExpressAppBar(title: 'Settings'),
      body: ListView(
        children: [
          _sectionLabel('ACCOUNT & DELIVERY'),
          _settingsCard([
            _linkTile(
              Icons.person_outline_rounded,
              'My profile',
              'Name, email, photo',
              () {
                final nav = Navigator.of(context);
                nav.pop();
                nav.pushNamed('/profile');
              },
            ),
            _divider(),
            _linkTile(
              Icons.location_on_outlined,
              'Saved addresses',
              'Home, work, and more',
              () {
                final nav = Navigator.of(context);
                nav.pop();
                nav.pushNamed('/addresses');
              },
            ),
            _divider(),
            _linkTile(
              Icons.payment_rounded,
              'Payment methods',
              'Cards and wallets',
              () {
                final nav = Navigator.of(context);
                nav.pop();
                nav.pushNamed('/payments');
              },
            ),
          ]),
          _sectionLabel('NOTIFICATIONS'),
          _settingsCard([
            SwitchListTile.adaptive(
              secondary: Icon(
                Icons.notifications_active_outlined,
                color: AppTheme.primaryColor,
              ),
              title: const Text('Order updates'),
              subtitle: const Text('Status of your active orders'),
              value: _orderUpdates,
              activeTrackColor: AppTheme.primaryColor.withOpacity(0.45),
              activeThumbColor: Colors.white,
              onChanged: (v) => setState(() => _orderUpdates = v),
            ),
            _divider(),
            SwitchListTile.adaptive(
              secondary: Icon(
                Icons.local_offer_outlined,
                color: AppTheme.primaryColor,
              ),
              title: const Text('Offers & deals'),
              subtitle: const Text('Discounts and restaurant promos'),
              value: _promoNotifications,
              activeTrackColor: AppTheme.primaryColor.withOpacity(0.45),
              activeThumbColor: Colors.white,
              onChanged: (v) => setState(() => _promoNotifications = v),
            ),
            _divider(),
            SwitchListTile.adaptive(
              secondary: Icon(
                Icons.mark_email_read_outlined,
                color: AppTheme.primaryColor,
              ),
              title: const Text('Email summary'),
              subtitle: const Text('Weekly recommendations'),
              value: _emailDigest,
              activeTrackColor: AppTheme.primaryColor.withOpacity(0.45),
              activeThumbColor: Colors.white,
              onChanged: (v) => setState(() => _emailDigest = v),
            ),
          ]),
          _sectionLabel('REGIONAL'),
          _settingsCard([
            ListTile(
              leading: Icon(Icons.language_rounded, color: AppTheme.primaryColor),
              title: const Text('Language'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _language,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
                ],
              ),
              onTap: _pickLanguage,
            ),
            _divider(),
            ListTile(
              leading: Icon(Icons.public_rounded, color: AppTheme.primaryColor),
              title: const Text('Country / region'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      _region,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
                ],
              ),
              onTap: _pickRegion,
            ),
          ]),
          _sectionLabel('LEGAL'),
          _settingsCard([
            ListTile(
              leading: Icon(Icons.description_outlined, color: Colors.grey[700]),
              title: const Text('Terms of use'),
              trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
              onTap: () => _showLegalSheet(
                'Terms of use',
                'By using Food Express you agree to our terms of service. '
                'We provide a platform to discover restaurants and place orders. '
                'Restaurants are responsible for food quality and preparation. '
                'Delivery times are estimates and may vary. '
                'Fees, promotions, and availability are subject to change.\n\n'
                'This is demo text for illustration only.',
              ),
            ),
            _divider(),
            ListTile(
              leading: Icon(Icons.privacy_tip_outlined, color: Colors.grey[700]),
              title: const Text('Privacy policy'),
              trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
              onTap: () => _showLegalSheet(
                'Privacy policy',
                'We collect information you provide (account, addresses, orders) '
                'to run the service. We use data to personalize offers and improve '
                'the app. You can manage notifications in Settings. '
                'We do not sell your personal data to third parties for their marketing.\n\n'
                'This is demo text for illustration only.',
              ),
            ),
          ]),
          _sectionLabel('ABOUT'),
          _settingsCard([
            ListTile(
              leading: Icon(Icons.info_outline_rounded, color: Colors.grey[700]),
              title: const Text('App version'),
              trailing: Text(
                '1.0.0',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
            _divider(),
            ListTile(
              leading: Icon(Icons.cleaning_services_outlined, color: Colors.grey[700]),
              title: const Text('Clear cache'),
              subtitle: const Text('Free up local storage'),
              trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
              onTap: () {
                Fluttertoast.showToast(
                  msg: 'Cache cleared',
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                );
              },
            ),
            _divider(),
            ListTile(
              leading: Icon(Icons.star_outline_rounded, color: Colors.grey[700]),
              title: const Text('Rate the app'),
              trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
              onTap: () {
                Fluttertoast.showToast(
                  msg: 'Thanks! (Store link would open here)',
                  backgroundColor: AppTheme.primaryColor,
                  textColor: Colors.white,
                );
              },
            ),
          ]),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: OutlinedButton.icon(
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Log out?'),
                    content: const Text(
                      'You will need to sign in again to place orders.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (_) => false,
                          );
                        },
                        child: Text(
                          'Log out',
                          style: TextStyle(color: Colors.red[700]),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout_rounded, color: AppTheme.primaryColor),
              label: const Text(
                'Log out',
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppTheme.primaryColor.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _divider() => Divider(height: 1, indent: 56, color: Colors.grey[200]);

  Widget _linkTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(title),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: Colors.grey[400]),
      onTap: onTap,
    );
  }
}
