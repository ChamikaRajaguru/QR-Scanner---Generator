import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/qr_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ScanResultScreen extends StatelessWidget {
  final QRModel qr;

  const ScanResultScreen({super.key, required this.qr});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Icon(
                    _getIcon(qr.type),
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    qr.type.name.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SelectableText(
                    qr.content,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Scanned on ${DateFormat('MMM dd, yyyy HH:mm').format(qr.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.copy_rounded,
                    label: 'Copy',
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: qr.content));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied to clipboard')),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.share_rounded,
                    label: 'Share',
                    onTap: () {
                      Share.share(qr.content);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (qr.type == QRType.url)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(qr.content);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                  icon: const Icon(Icons.open_in_browser_rounded),
                  label: const Text('Open Link'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline.withAlpha(51)),
          borderRadius: BorderRadius.circular(16),
        ),

        child: Column(
          children: [
            Icon(icon),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(QRType type) {
    switch (type) {
      case QRType.url:
        return Icons.link_rounded;
      case QRType.phone:
        return Icons.phone_rounded;
      case QRType.email:
        return Icons.email_rounded;
      case QRType.wifi:
        return Icons.wifi_rounded;
      case QRType.sms:
        return Icons.sms_rounded;
      default:
        return Icons.text_fields_rounded;
    }
  }
}
