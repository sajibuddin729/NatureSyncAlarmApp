class AlarmModel {
  final String id;
  final DateTime dateTime;
  final bool isEnabled;
  final String label;

  AlarmModel({
    required this.id,
    required this.dateTime,
    required this.isEnabled,
    this.label = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'isEnabled': isEnabled,
      'label': label,
    };
  }

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      id: json['id'],
      dateTime: DateTime.parse(json['dateTime']),
      isEnabled: json['isEnabled'],
      label: json['label'] ?? '',
    );
  }

  AlarmModel copyWith({
    String? id,
    DateTime? dateTime,
    bool? isEnabled,
    String? label,
  }) {
    return AlarmModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      isEnabled: isEnabled ?? this.isEnabled,
      label: label ?? this.label,
    );
  }
}