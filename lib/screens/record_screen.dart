import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'after_recording_screen.dart'; // Links to the next screen

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  bool isRecording = false;
  late final AudioRecorder _audioRecorder;

  @override
  void initState() {
    super.initState();
    _audioRecorder = AudioRecorder();
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    try {
      if (isRecording) {
        final path = await _audioRecorder.stop();
        setState(() => isRecording = false);
        
        if (mounted && path != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AfterRecordingScreen(filePath: path)),
          );
        }
      } else {
        if (await _audioRecorder.hasPermission()) {
          final Directory tempDir = await getTemporaryDirectory();
          final String filePath = '${tempDir.path}/vent_record_${DateTime.now().millisecondsSinceEpoch}.m4a';
          await _audioRecorder.start(const RecordConfig(), path: filePath);
          setState(() => isRecording = true);
        }
      }
    } catch (e) {
      print("Error recording: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: const Text("Let it out", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _toggleRecording,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isRecording ? 120 : 100,
                  height: isRecording ? 120 : 100,
                  decoration: BoxDecoration(
                    color: isRecording ? const Color(0xFFEC4899) : const Color(0xFF8B5CF6),
                    shape: BoxShape.circle,
                    boxShadow: isRecording ? [BoxShadow(color: const Color(0xFFEC4899).withOpacity(0.5), blurRadius: 20, spreadRadius: 10)] : [],
                  ),
                  child: Icon(isRecording ? Icons.stop : Icons.mic, size: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              Text(isRecording ? "I'm listening..." : "Tap to vent", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}