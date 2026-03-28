import 'package:flutter/material.dart';
import '../../Services/api_service.dart';

class ConnectivityTestScreen extends StatefulWidget {
  const ConnectivityTestScreen({super.key});

  @override
  State<ConnectivityTestScreen> createState() => _ConnectivityTestScreenState();
}

class _ConnectivityTestScreenState extends State<ConnectivityTestScreen> {
  final ApiService _api = ApiService();

  bool _loading = false;
  String _status = "Not tested yet.";

  Future<void> _test() async {
    setState(() {
      _loading = true;
      _status = "Testing...";
    });

    try {
      final data = await _api.healthCheck();
      setState(
        () => _status =
            "SUCCESS\nstatus: ${data.status}\nmessage: ${data.message}",
      );
    } catch (e) {
      setState(() => _status = "FAILED\n$e");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Phase 1: Connectivity Test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_status),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _test,
                child: _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text("Test /health"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
