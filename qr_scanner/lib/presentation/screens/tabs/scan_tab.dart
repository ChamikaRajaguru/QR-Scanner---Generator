import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/qr_bloc.dart';
import '../../screens/scan_result_screen.dart';
import '../../../data/models/qr_model.dart';
import 'package:uuid/uuid.dart';

class ScanTab extends StatefulWidget {
  const ScanTab({super.key});

  @override
  State<ScanTab> createState() => _ScanTabState();
}

class _ScanTabState extends State<ScanTab> {
  final MobileScannerController controller = MobileScannerController();
  bool _isScanned = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && !_isScanned) {
                _isScanned = true;
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  _onDetect(code);
                }
              }
            },
          ),
          _buildOverlay(context),

        ],
      ),
    );
  }

  void _onDetect(String code) {
    final qr = QRModel(
      id: const Uuid().v4(),
      content: code,
      type: _parseType(code),
      createdAt: DateTime.now(),
      isGenerated: false,
    );

    context.read<QRBloc>().add(SaveQR(qr));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScanResultScreen(qr: qr),
      ),
    ).then((_) => _isScanned = false);
  }

  QRType _parseType(String code) {
    if (code.startsWith('http')) return QRType.url;
    if (code.startsWith('tel:')) return QRType.phone;
    if (code.startsWith('mailto:')) return QRType.email;
    if (code.startsWith('WIFI:')) return QRType.wifi;
    if (code.startsWith('SMSTO:')) return QRType.sms;
    return QRType.text;
  }

  Widget _buildOverlay(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: QrScannerOverlayShape(
          borderColor: Theme.of(context).colorScheme.primary,
          borderRadius: 24,
          borderLength: 40,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.7,
        ),
      ),
    );
  }

}

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  const QrScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 10,
    this.borderRadius = 0,
    this.borderLength = 40,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(Rect.fromLTWH(
          rect.left, rect.top, rect.width, rect.height));
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..addRect(Rect.fromLTWH(
          rect.left, rect.top, rect.width, rect.height));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final width = rect.width;
    final height = rect.height;

    final paint = Paint()
      ..color = Colors.black.withAlpha(128)
      ..style = PaintingStyle.fill;

    final cutOutRect = Rect.fromCenter(
      center: Offset(width / 2, height / 2),
      width: cutOutSize,
      height: cutOutSize,
    );

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(rect),
        Path()..addRRect(RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius))),
      ),
      paint,
    );

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth
      ..strokeCap = StrokeCap.round;

    final borderPath = Path();

    // Top left
    borderPath.moveTo(cutOutRect.left, cutOutRect.top + borderLength);
    borderPath.lineTo(cutOutRect.left, cutOutRect.top + borderRadius);
    borderPath.arcToPoint(Offset(cutOutRect.left + borderRadius, cutOutRect.top),
        radius: Radius.circular(borderRadius));
    borderPath.lineTo(cutOutRect.left + borderLength, cutOutRect.top);

    // Top right
    borderPath.moveTo(cutOutRect.right - borderLength, cutOutRect.top);
    borderPath.lineTo(cutOutRect.right - borderRadius, cutOutRect.top);
    borderPath.arcToPoint(Offset(cutOutRect.right, cutOutRect.top + borderRadius),
        radius: Radius.circular(borderRadius));
    borderPath.lineTo(cutOutRect.right, cutOutRect.top + borderLength);

    // Bottom right
    borderPath.moveTo(cutOutRect.right, cutOutRect.bottom - borderLength);
    borderPath.lineTo(cutOutRect.right, cutOutRect.bottom - borderRadius);
    borderPath.arcToPoint(Offset(cutOutRect.right - borderRadius, cutOutRect.bottom),
        radius: Radius.circular(borderRadius), clockwise: true);
    borderPath.lineTo(cutOutRect.right - borderLength, cutOutRect.bottom);

    // Bottom left
    borderPath.moveTo(cutOutRect.left + borderLength, cutOutRect.bottom);
    borderPath.lineTo(cutOutRect.left + borderRadius, cutOutRect.bottom);
    borderPath.arcToPoint(Offset(cutOutRect.left, cutOutRect.bottom - borderRadius),
        radius: Radius.circular(borderRadius));
    borderPath.lineTo(cutOutRect.left, cutOutRect.bottom - borderLength);

    canvas.drawPath(borderPath, borderPaint);
  }

  @override
  ShapeBorder scale(double t) => QrScannerOverlayShape(
        borderColor: borderColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        borderLength: borderLength,
        cutOutSize: cutOutSize,
      );
}
