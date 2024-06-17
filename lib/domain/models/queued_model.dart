// infraestructure/models/queued_operation.dart

enum OperationType { create, update, delete }

class QueuedOperation {
  final OperationType type;
  final Map<String, dynamic> data;

  QueuedOperation({
    required this.type,
    required this.data,
  });

  Map<String, dynamic> toJson() => {
    'type': type.toString(),
    'data': data,
  };

  factory QueuedOperation.fromJson(Map<String, dynamic> json) {
    return QueuedOperation(
      type: OperationType.values.firstWhere((e) => e.toString() == json['type']),
      data: Map<String, dynamic>.from(json['data']),
    );
  }
}
