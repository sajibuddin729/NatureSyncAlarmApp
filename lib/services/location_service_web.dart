
class LocationService {
  static Future<MockPosition> getCurrentLocation() async {
    await Future.delayed(Duration(seconds: 1));
    return MockPosition(latitude: 51.5074, longitude: -0.1278);
  }

  static Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    await Future.delayed(Duration(milliseconds: 500));
    return '79 Regent\'s Park Rd, London\nNW1 8UY, United Kingdom';
  }
}

class MockPosition {
  final double latitude;
  final double longitude;
  
  MockPosition({required this.latitude, required this.longitude});
}