import 'package:flutter/material.dart';
import 'sms_service.dart';
import 'subscription_service.dart';

class SubscriptionGate extends StatefulWidget {
  final Widget child;
  final String featureName;

  const SubscriptionGate({
    super.key,
    required this.child,
    required this.featureName,
  });

  @override
  State<SubscriptionGate> createState() => _SubscriptionGateState();
}

class _SubscriptionGateState extends State<SubscriptionGate> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isOtpSent = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _phoneNumber;

  Future<void> _requestOtp() async {
    if (_phoneController.text.isEmpty) {
      setState(() => _errorMessage = 'Please enter your phone number');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final phone = 'tel:+88${_phoneController.text.replaceAll(RegExp(r'[^\d]'), '')}';
    final result = await SubscriptionService.requestOtp(phone);

    setState(() {
      _isLoading = false;
    });

    if (result != null && result['statusCode'] == 'S1000') {
      setState(() {
        _isOtpSent = true;
        _phoneNumber = phone;
      });

      // Send welcome SMS
      SmsService.sendSms(
        message: 'Welcome to Amplify! Your OTP has been sent. Features unlocked after verification.',
        destinationAddresses: [phone],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP sent to your phone!')),
      );
    } else {
      setState(() => _errorMessage = 'Failed to send OTP. Please try again.');
    }
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 6) {
      setState(() => _errorMessage = 'Enter valid 6-digit OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final result = await SubscriptionService.verifyOtp(_otpController.text);

    setState(() {
      _isLoading = false;
    });

    if (result != null) {
      Navigator.of(context).pop(); // Close dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Subscription successful! Welcome to Amplify!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() => _errorMessage = 'Invalid OTP. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSubscribed = SubscriptionService.isSubscribed;

    if (isSubscribed) return widget.child;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Column(
        children: [
          Icon(Icons.lock_outline, size: 64, color: Colors.orange.shade400),
          const SizedBox(height: 16),
          Text(
            'Subscribe to ${widget.featureName}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Subscribe to unlock all premium features',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            if (!_isOtpSent) ...[
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number (01XXXXXXXX)',
                  prefixText: '+88 ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  errorText: _errorMessage,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _requestOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Send OTP', style: TextStyle(fontSize: 16)),
                ),
              ),
            ] else ...[
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: 'Enter 6-digit OTP',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  errorText: _errorMessage,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Verify & Subscribe', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Maybe Later'),
            ),
          ],
        ),
      ),
    );
  }
}
