import 'package:flutter/material.dart';

class AIAnalysisScreen extends StatelessWidget {
  const AIAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), 
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Reflection Insights", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Sep 6, 2026", style: TextStyle(color: Colors.white54, fontSize: 14)),
              const SizedBox(height: 32),

              const Text("Emotional tone", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  bool isActive = index == 5; 
                  return CircleAvatar(
                    radius: isActive ? 8 : 4,
                    backgroundColor: isActive ? const Color(0xFFF97316) : Colors.white24, 
                  );
                }),
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Calm", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  Text("Distressed", style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 40),

              const Text("Emotions detected", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              _buildEmotionBar(Icons.sentiment_very_dissatisfied, "Frustration", 0.78, "78%"),
              const SizedBox(height: 16),
              _buildEmotionBar(Icons.sentiment_dissatisfied, "Sadness", 0.62, "62%"),
              const SizedBox(height: 16),
              _buildEmotionBar(Icons.sentiment_neutral, "Overwhelm", 0.54, "54%"),
              const SizedBox(height: 40),

              const Text("Themes", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildThemeChip(Icons.work_outline, "Work"),
                  _buildThemeChip(Icons.battery_alert_outlined, "Exhaustion"),
                  _buildThemeChip(Icons.favorite_border, "Relationships"),
                ],
              ),
              const SizedBox(height: 48),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.white54, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "This information is saved for your future reflection.",
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13, height: 1.4),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmotionBar(IconData icon, String label, double percentage, String percentText) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 24),
        const SizedBox(width: 16),
        SizedBox(width: 80, child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15))),
        const SizedBox(width: 16),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Text(percentText, style: const TextStyle(color: Colors.white54, fontSize: 14)),
      ],
    );
  }

  Widget _buildThemeChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border.all(color: Colors.white12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFFEC4899), size: 18), 
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}