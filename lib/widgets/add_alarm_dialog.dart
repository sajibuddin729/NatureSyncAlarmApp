import 'package:flutter/material.dart';
import '../models/alarm_model.dart';

class AddAlarmDialog extends StatefulWidget {
  final Function(AlarmModel) onAlarmAdded;

  const AddAlarmDialog({
    Key? key,
    required this.onAlarmAdded,
  }) : super(key: key);

  @override
  _AddAlarmDialogState createState() => _AddAlarmDialogState();
}

class _AddAlarmDialogState extends State<AddAlarmDialog> {
  DateTime _selectedDateTime = DateTime.now().add(Duration(minutes: 1));
  final TextEditingController _labelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xFF2A2A2A),
      title: Text(
        'Add New Alarm',
        style: TextStyle(color: Colors.white),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _labelController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Label (optional)',
              labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF6B73FF)),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                'Date & Time:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  '${_selectedDateTime.day}/${_selectedDateTime.month}/${_selectedDateTime.year}',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  '${_selectedDateTime.hour.toString().padLeft(2, '0')}:${_selectedDateTime.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _selectDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B73FF),
                  ),
                  child: Text('Select Date', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _selectTime,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B73FF),
                  ),
                  child: Text('Select Time', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ),
        ElevatedButton(
          onPressed: _addAlarm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6B73FF),
          ),
          child: Text('Add Alarm', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF6B73FF),
              onPrimary: Colors.white,
              surface: Color(0xFF2A2A2A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _selectedDateTime.hour,
          _selectedDateTime.minute,
        );
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Color(0xFF6B73FF),
              onPrimary: Colors.white,
              surface: Color(0xFF2A2A2A),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime.year,
          _selectedDateTime.month,
          _selectedDateTime.day,
          picked.hour,
          picked.minute,
        );
      });
    }
  }

  void _addAlarm() {
    if (_selectedDateTime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a future date and time'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final alarm = AlarmModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      dateTime: _selectedDateTime,
      isEnabled: true,
      label: _labelController.text.trim(),
    );

    widget.onAlarmAdded(alarm);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }
}