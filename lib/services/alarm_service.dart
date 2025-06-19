import '../models/alarm_model.dart';
import 'storage_service.dart';
import 'notification_service.dart';

class AlarmService {
  Future<List<AlarmModel>> getAlarms() async {
    final alarmsData = await StorageService.getAlarms();
    return alarmsData.map((data) => AlarmModel.fromJson(data)).toList();
  }

  Future<void> addAlarm(AlarmModel alarm) async {
    final alarms = await getAlarms();
    alarms.add(alarm);
    await _saveAlarms(alarms);
    

    if (alarm.isEnabled) {
      await NotificationService.scheduleNotification(
        id: alarm.id.hashCode,
        title: 'Nature Sync Alarm',
        body: alarm.label.isEmpty ? 'Time to sync with nature!' : alarm.label,
        scheduledTime: alarm.dateTime,
      );
    }
  }

  Future<void> updateAlarm(AlarmModel alarm) async {
    final alarms = await getAlarms();
    final index = alarms.indexWhere((a) => a.id == alarm.id);
    
    if (index != -1) {
      alarms[index] = alarm;
      await _saveAlarms(alarms);
      
      await NotificationService.cancelNotification(alarm.id.hashCode);

      if (alarm.isEnabled) {
        await NotificationService.scheduleNotification(
          id: alarm.id.hashCode,
          title: 'Nature Sync Alarm',
          body: alarm.label.isEmpty ? 'Time to sync with nature!' : alarm.label,
          scheduledTime: alarm.dateTime,
        );
      }
    }
  }

  Future<void> deleteAlarm(String alarmId) async {
    final alarms = await getAlarms();
    final alarm = alarms.firstWhere((a) => a.id == alarmId);
    
  
    await NotificationService.cancelNotification(alarm.id.hashCode);
    
    alarms.removeWhere((a) => a.id == alarmId);
    await _saveAlarms(alarms);
  }

  Future<void> toggleAlarm(String alarmId) async {
    final alarms = await getAlarms();
    final index = alarms.indexWhere((a) => a.id == alarmId);
    
    if (index != -1) {
      final alarm = alarms[index];
      final updatedAlarm = alarm.copyWith(isEnabled: !alarm.isEnabled);
      alarms[index] = updatedAlarm;
      await _saveAlarms(alarms);
      
      if (updatedAlarm.isEnabled) {
        await NotificationService.scheduleNotification(
          id: updatedAlarm.id.hashCode,
          title: 'Nature Sync Alarm',
          body: updatedAlarm.label.isEmpty ? 'Time to sync with nature!' : updatedAlarm.label,
          scheduledTime: updatedAlarm.dateTime,
        );
      } else {
        await NotificationService.cancelNotification(updatedAlarm.id.hashCode);
      }
    }
  }

  Future<void> _saveAlarms(List<AlarmModel> alarms) async {
    final alarmsData = alarms.map((alarm) => alarm.toJson()).toList();
    await StorageService.saveAlarms(alarmsData);
  }
}