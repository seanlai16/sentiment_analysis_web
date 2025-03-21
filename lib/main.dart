import 'package:flutter/material.dart';
import 'package:sentiment_analysis_web/services/sentiment_analysis_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String _statusMessage = '';
  final SentimentAnalysisService _sentimentService = SentimentAnalysisService();

  void _handleSubmit() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });

    SentimentAnalysisResult result = await _sentimentService.analyze(
      _controller.text,
    );

    setState(() {
      _isLoading = false;
      _statusMessage =
          'Result: ${result.sentiment} (Confidence: ${result.confidence})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sentiment Analysis')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              _isLoading
                  ? CircularProgressIndicator()
                  : TextButton(onPressed: _handleSubmit, child: Text('Submit')),
              SizedBox(height: 16),
              Text(
                _statusMessage,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
