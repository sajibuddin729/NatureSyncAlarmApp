import 'package:flutter/material.dart';
import '../models/alarm_model.dart';
import '../services/alarm_service.dart';
import '../widgets/alarm_item.dart';
import '../widgets/add_alarm_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AlarmModel> _alarms = [];
  final AlarmService _alarmService = AlarmService();

  @override
  void initState() {
    super.initState();
    _loadAlarms();
  }

  Future<void> _loadAlarms() async {
    final alarms = await _alarmService.getAlarms();
    setState(() {
      _alarms = alarms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '12:30',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 18),
          SizedBox(width: 4),
          Icon(Icons.wifi, color: Colors.white, size: 18),
          SizedBox(width: 4),
          Icon(Icons.battery_full, color: Colors.white, size: 18),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Location',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '79 Regent\'s Park Rd, London',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'NW1 8UY, United Kingdom',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _showAddAlarmDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6B73FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Add Alarm',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Alarms',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _alarms.isEmpty
                  ? Center(
                      child: Text(
                        'No alarms set',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _alarms.length,
                      itemBuilder: (context, index) {
                        return AlarmItem(
                          alarm: _alarms[index],
                          onToggle: (alarm) => _toggleAlarm(alarm),
                          onDelete: (alarm) => _deleteAlarm(alarm),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddAlarmDialog() {
    showDialog(
      context: context,
      builder: (context) => AddAlarmDialog(
        onAlarmAdded: (alarm) {
          _alarmService.addAlarm(alarm);
          _loadAlarms();
        },
      ),
    );
  }

  void _toggleAlarm(AlarmModel alarm) {
    _alarmService.toggleAlarm(alarm.id);
    _loadAlarms();
  }

  void _deleteAlarm(AlarmModel alarm) {
    _alarmService.deleteAlarm(alarm.id);
    _loadAlarms();
  }
}