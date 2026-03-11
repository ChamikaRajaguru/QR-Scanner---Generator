import 'package:flutter/material.dart';

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
          _buildActionCard(
            context,
            title: 'Scan QR Code',
            subtitle: 'Point and scan instantly',
            icon: Icons.qr_code_scanner_rounded,
            color: Theme.of(context).colorScheme.primaryContainer,
            onTap: () {
              // Navigate to Scan tab via index change or other way
              // For simplicity, we can use a callback or just tell the user to use the bottom nav
            },
          ),
          const SizedBox(height: 16),
          _buildActionCard(
            context,
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
              child: Text('No recent activities yet.', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.onSurface),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          ],
        ),
      ),
    );
  }
}
