import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = '********';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  runApp(const MaterialApp(home: PayScreen()));
}

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});
  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  String _status = 'Ready';

  Future<void> _pay() async {
    setState(() => _status = 'Working...');
    try {
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ));

      final res = await dio.post(
        'http://localhost:3000/api/payments/create-payment-intent',
        data: {'amount': 25000, 'currency': 'egp'},
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: res.data['clientSecret'],
          merchantDisplayName: 'Restaurant App',
          returnURL: 'flutterstripe://redirect',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      setState(() => _status = 'Paid');
    } on StripeException catch (e) {
      setState(() => _status = 'Stripe: ${e.error.localizedMessage}');
    } catch (e) {
      setState(() => _status = 'Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _pay, child: const Text('Pay 250 EGP')),
          ],
        ),
      ),
    );
  }
}