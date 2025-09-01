import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alertas Sonoras',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Alertas de Emergencia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  final List<Map<String, dynamic>> emergencySounds = [
    {'label': 'Alerta General', 'file': 'sonido de emergencia.mp3', 'icon': Icons.warning},
    {'label': 'Emergencia Medica', 'file': 'emergencia medica.mp3', 'icon': Icons.medical_services},
    {'label': 'Incendio', 'file': 'incendio1.mp3', 'icon': Icons.local_fire_department},
    {'label': 'Caricatura', 'file': 'caricatura.mp3', 'icon': Icons.health_and_safety},
  ];

  void _playSound(String fileName) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('audio/$fileName'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 184, 29, 163),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 125, 255),
        title: Text(widget.title, style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Selecciona una alerta',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.separated(
                itemCount: emergencySounds.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final sound = emergencySounds[index];
                  return ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 65),
                      backgroundColor: const Color.fromARGB(255, 104, 11, 141),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadowColor: Colors.black45,
                      elevation: 6,
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    icon: Icon(sound['icon'], size: 30),
                    label: Text(sound['label']),
                    onPressed: () => _playSound(sound['file']),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
