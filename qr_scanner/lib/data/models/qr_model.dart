import 'package:equatable/equatable.dart';

enum QRType { text, url, phone, email, wifi, sms }

class QRModel extends Equatable {
  final String id;
  final String content;
  final QRType type;
  final DateTime createdAt;
  final bool isGenerated; // true if generated, false if scanned

  const QRModel({
    required this.id,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.isGenerated,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type.name,
      'createdAt': createdAt.toIso8601String(),
      'isGenerated': isGenerated,
    };
  }

  factory QRModel.fromJson(Map<String, dynamic> json) {
    return QRModel(
      id: json['id'],
      content: json['content'],
      type: QRType.values.byName(json['type']),
      createdAt: DateTime.parse(json['createdAt']),
      isGenerated: json['isGenerated'],
    );
  }

  @override
  List<Object?> get props => [id, content, type, createdAt, isGenerated];
}
