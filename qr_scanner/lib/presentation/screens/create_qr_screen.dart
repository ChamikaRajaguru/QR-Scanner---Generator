import 'package:flutter/material.dart';
import '../../data/models/qr_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/qr_bloc.dart';
import 'qr_view_screen.dart';

class CreateQRScreen extends StatefulWidget {
  final String title;

  const CreateQRScreen({super.key, required this.title});

  @override
  State<CreateQRScreen> createState() => _CreateQRScreenState();
}

class _CreateQRScreenState extends State<CreateQRScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create ${widget.title} QR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                maxLines: widget.title == 'Text' ? 5 : 1,
                decoration: InputDecoration(
                  labelText: _getLabel(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some content';
                  }
                  return null;
                },
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _generateQR,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text('Generate QR Code'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getLabel() {
    switch (widget.title) {
      case 'Website': return 'Enter URL (e.g., https://example.com)';
      case 'Phone': return 'Enter Phone Number';
      case 'Email': return 'Enter Email Address';
      case 'WiFi': return 'Enter WiFi Details (SSID, Password)';
      case 'SMS': return 'Enter SMS Content';
      default: return 'Enter Text';
    }
  }

  void _generateQR() {
    if (_formKey.currentState!.validate()) {
      final qr = QRModel(
        id: const Uuid().v4(),
        content: _controller.text,
        type: _getType(),
        createdAt: DateTime.now(),
        isGenerated: true,
      );

      context.read<QRBloc>().add(SaveQR(qr));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QRViewScreen(qr: qr),
        ),
      );
    }
  }

  QRType _getType() {
    switch (widget.title) {
      case 'Website': return QRType.url;
      case 'Phone': return QRType.phone;
      case 'Email': return QRType.email;
      case 'WiFi': return QRType.wifi;
      case 'SMS': return QRType.sms;
      default: return QRType.text;
    }
  }
}
