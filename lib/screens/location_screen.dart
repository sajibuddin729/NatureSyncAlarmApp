import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../services/location_service.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _isLoading = false;
  String? _locationText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                'Welcome! Your Personalized Alarm',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Allow us to sync your sunset alarm based on your location',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              SizedBox(height: 60),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color(0xFF6B73FF), width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF9A8B), Color(0xFFA8E6CF)],
                        ),
                      ),
                      child: Icon(
                        Icons.location_on,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                    if (_locationText != null) ...[
                      SizedBox(height: 20),
                      Text(
                        _locationText!,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _requestLocation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6B73FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on, color: Colors.white),
                            SizedBox(width: 8),
                            Text(
                              'Use Current Location',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Home',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _requestLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (kIsWeb) {
        setState(() {
          _locationText = '79 Regent\'s Park Rd, London\nNW1 8UY, United Kingdom';
          _isLoading = false;
        });
      } else {
        final position = await LocationService.getCurrentLocation();
        final address = await LocationService.getAddressFromCoordinates(
          position.latitude,
          position.longitude,
        );

        setState(() {
          _locationText = address;
          _isLoading = false;
        });
      }
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get location: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}