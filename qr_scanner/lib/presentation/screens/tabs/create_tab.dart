import 'package:flutter/material.dart';
import '../create_qr_screen.dart'; // We'll create this

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
        _buildCreateCard(context, Icons.text_fields_rounded, 'Text', 'Create QR for text'),
        _buildCreateCard(context, Icons.link_rounded, 'Website', 'Create QR for URL'),
        _buildCreateCard(context, Icons.phone_rounded, 'Phone', 'Create QR for phone'),
        _buildCreateCard(context, Icons.email_rounded, 'Email', 'Create QR for email'),
        _buildCreateCard(context, Icons.wifi_rounded, 'WiFi', 'Create QR for WiFi'),
        _buildCreateCard(context, Icons.sms_rounded, 'SMS', 'Create QR for SMS'),
      ],
    );
  }

  Widget _buildCreateCard(BuildContext context, IconData icon, String title, String subtitle) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateQRScreen(title: title),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
