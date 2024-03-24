import 'package:ad_test/ad/service/ad_service.dart';
import 'package:flutter/material.dart';
import 'ad/model/ad.dart';
import 'ad/model/ad_listener.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _statusText = "No ad status";

  void _requestAd() {
    AdService.requestAd("placementId");
  }

  @override
  void initState() {
    super.initState();
    initializeAdService();
  }

  void initializeAdService() async {
    await AdService.initialize("appKey");
    attachAdListener();
  }

  void attachAdListener() {
    AdService.setAdListener(
      AdListener(
        onAdLoadedCallback: (Ad ad) {
          logStatus("Ad loaded: ${ad.placementId}");
        },
        onAdLoadFailedCallback: (String placementId, AdError error) {
          logStatus("Ad failed to load: $placementId, ${error.message}");
        },
        onAdDisplayedCallback: (Ad ad) {
          logStatus("Ad displayed: ${ad.placementId}");
        },
        onAdDisplayFailedCallback: (Ad ad, AdError error) {
          logStatus("Ad failed to display: ${ad.placementId}, ${error.message}");
        },
      ),
    );
  }

  void logStatus(String status) {
    /// ignore: avoid_print
    print(status);

    setState(() {
      _statusText = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _statusText,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _requestAd,
        tooltip: 'Request Ad',
        child: const Icon(Icons.add),
      ),
    );
  }
}
