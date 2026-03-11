import 'package:flutter/material.dart';
import '../create_qr_screen.dart';
import '../../../core/widgets/action_card.dart';

class CreateTab extends StatelessWidget {
  const CreateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(24),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        ActionCard(
          isLarge: false,
          title: 'Text',
          subtitle: 'Create QR for text',
          icon: Icons.text_fields_rounded,
          onTap: () => _navigateToCreate(context, 'Text'),
        ),
        ActionCard(
          isLarge: false,
          title: 'Website',
          subtitle: 'Create QR for URL',
          icon: Icons.link_rounded,
          onTap: () => _navigateToCreate(context, 'Website'),
        ),
        ActionCard(
          isLarge: false,
          title: 'Phone',
          subtitle: 'Create QR for phone',
          icon: Icons.phone_rounded,
          onTap: () => _navigateToCreate(context, 'Phone'),
        ),
        ActionCard(
          isLarge: false,
          title: 'Email',
          subtitle: 'Create QR for email',
          icon: Icons.email_rounded,
          onTap: () => _navigateToCreate(context, 'Email'),
        ),
        ActionCard(
          isLarge: false,
          title: 'WiFi',
          subtitle: 'Create QR for WiFi',
          icon: Icons.wifi_rounded,
          onTap: () => _navigateToCreate(context, 'WiFi'),
        ),
        ActionCard(
          isLarge: false,
          title: 'SMS',
          subtitle: 'Create QR for SMS',
          icon: Icons.sms_rounded,
          onTap: () => _navigateToCreate(context, 'SMS'),
        ),
      ],
    );
  }

  void _navigateToCreate(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateQRScreen(title: title),
      ),
    );
  }
}

