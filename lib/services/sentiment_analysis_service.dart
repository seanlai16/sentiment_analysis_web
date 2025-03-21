import 'package:http/http.dart' as http;
import 'dart:convert';

class SentimentAnalysisResult {
  final String sentiment;
  final double confidence;

  SentimentAnalysisResult({required this.sentiment, required this.confidence});
}

class SentimentAnalysisService {
  Future<SentimentAnalysisResult> analyze(String text) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://sentiment-analysis-api-805594711544.us-central1.run.app/predict',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SentimentAnalysisResult(
          sentiment: data['sentiment'] ?? 'Unknown',
          confidence: (data['confidence'] ?? 0.0).toDouble(),
        );
      } else {
        return SentimentAnalysisResult(sentiment: 'Error', confidence: 0.0);
      }
    } catch (e) {
      print(e);
      return SentimentAnalysisResult(sentiment: 'Error', confidence: 0.0);
    }
  }
}
