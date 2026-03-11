import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../data/models/qr_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../core/constants/app_colors.dart';

class QRViewScreen extends StatefulWidget {

  final QRModel qr;

  const QRViewScreen({super.key, required this.qr});

  @override
  State<QRViewScreen> createState() => _QRViewScreenState();
}

class _QRViewScreenState extends State<QRViewScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();
  Color _qrColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generated QR'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Screenshot(
              controller: _screenshotController,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: QrImageView(
                  data: widget.qr.content,
                  version: QrVersions.auto,
                  size: 250.0,
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: _qrColor,
                  ),
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: _qrColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Customize QR Color'),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: AppColors.qrColors.length,
                itemBuilder: (context, index) {
                  final color = AppColors.qrColors[index];
                  return GestureDetector(
                    onTap: () {
                      if (index != 0) {
                        // Reward ad mock or unlock premium
                        _showPremiumDialog(color);
                      } else {
                        setState(() => _qrColor = color);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: _qrColor == color
                            ? Border.all(color: Theme.of(context).colorScheme.primary, width: 3)
                            : null,
                      ),
                      child: index != 0 ? const Icon(Icons.lock_outline, size: 16, color: Colors.white) : null,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _shareQR,
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Share QR'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _saveToGallery,
                    icon: const Icon(Icons.download_rounded),
                    label: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _shareQR() async {
    final image = await _screenshotController.capture();
    if (image != null) {
      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/qr.png').create();
      await imagePath.writeAsBytes(image);
      await Share.shareXFiles([XFile(imagePath.path)]);
    }
  }

  void _saveToGallery() async {
    final image = await _screenshotController.capture();
    if (image != null) {
      // Mock saving logic as plugin dependency failed
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code saved to gallery (Mock)')),
      );
    }
  }



  void _showPremiumDialog(Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Premium Feature'),
        content: const Text('Watch a short video to unlock premium colors for this session.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _qrColor = color);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Premium color unlocked!')),
              );
            },
            child: const Text('Watch Ad'),
          ),
        ],
      ),
    );
  }
}
