import 'package:flutter/material.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium Plans'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.stars_rounded, size: 80, color: Colors.orange),
            const SizedBox(height: 24),
            Text(
              'Go Premium',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Unlock all features and remove ads'),
            const SizedBox(height: 48),
            _buildFeatureRow(context, Icons.color_lens_rounded, 'Custom QR Colors'),
            _buildFeatureRow(context, Icons.block_rounded, 'No Advertisements'),
            _buildFeatureRow(context, Icons.cloud_upload_rounded, 'Cloud Sync (Coming Soon)'),
            _buildFeatureRow(context, Icons.support_agent_rounded, 'Priority Support'),
            const SizedBox(height: 48),
            _buildPlanCard(
              context,
              title: 'Monthly Plan',
              price: '\$1.99 / month',
              description: 'Billed monthly. Cancel anytime.',
              isPopular: false,
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              context,
              title: 'Yearly Plan',
              price: '\$14.99 / year',
              description: 'Save 40% with annual billing.',
              isPopular: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required String price,
    required String description,
    required bool isPopular,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isPopular
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.surfaceContainerHighest,

        borderRadius: BorderRadius.circular(24),
        border: isPopular ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'MOST POPULAR',
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(price, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const SizedBox(height: 8),
          Text(description, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isPopular ? Theme.of(context).colorScheme.primary : null,
                foregroundColor: isPopular ? Colors.white : null,
              ),
              child: const Text('Choose Plan'),
            ),
          ),
        ],
      ),
    );
  }
}
