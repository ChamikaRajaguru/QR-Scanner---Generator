import 'package:flutter/material.dart';
import '../../../core/widgets/action_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to QuickQR',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          const Text('What would you like to do today?'),
          const SizedBox(height: 32),
          ActionCard(
            title: 'Scan QR Code',
            subtitle: 'Point and scan instantly',
            icon: Icons.qr_code_scanner_rounded,
            color: Theme.of(context).colorScheme.primaryContainer,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          ActionCard(
            title: 'Create QR Code',
            subtitle: 'Generate for URL, WiFi, etc.',
            icon: Icons.add_circle_outline_rounded,
            color: Theme.of(context).colorScheme.secondaryContainer,
            onTap: () {},
          ),
          const SizedBox(height: 32),
          Text(
            'Recent Activities',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'No recent activities yet.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

