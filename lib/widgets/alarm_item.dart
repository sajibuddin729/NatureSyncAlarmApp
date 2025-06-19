import 'package:flutter/material.dart';
import '../models/alarm_model.dart';
import 'package:intl/intl.dart';

class AlarmItem extends StatelessWidget {
  final AlarmModel alarm;
  final Function(AlarmModel) onToggle;
  final Function(AlarmModel) onDelete;

  const AlarmItem({
    Key? key,
    required this.alarm,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('h:mm a').format(alarm.dateTime),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  DateFormat('EEE dd MMM yyyy').format(alarm.dateTime),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                  ),
                ),
                if (alarm.label.isNotEmpty) ...[
                  SizedBox(height: 4),
                  Text(
                    alarm.label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Row(
            children: [
              Switch(
                value: alarm.isEnabled,
                onChanged: (_) => onToggle(alarm),
                activeColor: Color(0xFF6B73FF),
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.grey.withOpacity(0.3),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () => onDelete(alarm),
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red.withOpacity(0.7),
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}