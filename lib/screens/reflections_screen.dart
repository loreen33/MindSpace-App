import 'package:flutter/material.dart';
import 'ai_analysis_screen.dart'; // Using this as the Reflection Detail view
import '../services/api_service.dart';

class ReflectionsContent extends StatefulWidget {
  const ReflectionsContent({super.key});

  @override
  State<ReflectionsContent> createState() => _ReflectionsContentState();
}

class _ReflectionsContentState extends State<ReflectionsContent> {
  DateTime _selectedDate = DateTime.now();
  
  // NEW: State variables to hold database data
  bool _isLoading = true;
  List<dynamic> _reflections = [];

  @override
  void initState() {
    super.initState();
    _loadReflections(); // Fetch data the moment the screen opens
  }

  // NEW: Function to grab data from the backend
  Future<void> _loadReflections() async {
    final data = await ApiService.getReflections();
    if (mounted) {
      setState(() {
        _reflections = data;
        _isLoading = false;
      });
    }
  }

  // The Native Date Picker Function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8B5CF6),
              onPrimary: Colors.white,
              surface: Color(0xFF111827),
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFFEC4899),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Filtering reflections for ${picked.month}/${picked.day}/${picked.year}..."),
          backgroundColor: const Color(0xFF8B5CF6),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  // Helper to format Supabase dates (e.g., "2026-09-10" -> "Sep 10")
  String _formatDate(String isoString) {
    final DateTime date = DateTime.parse(isoString).toLocal();
    final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${months[date.month - 1]} ${date.day}";
  }

  // Helper to format Supabase time (e.g., "14:05")
  String _formatTime(String isoString) {
    final DateTime date = DateTime.parse(isoString).toLocal();
    return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "My Reflections",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 24),

            // Search Bar with Clickable Calendar Icon
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Colors.white54),
                  hintText: "Search your reflections...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.white54, size: 20),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Date Header
            const Text(
              "Recent Entries",
              style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Dynamic List of Reflections from Supabase
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF8B5CF6)))
                  : _reflections.isEmpty
                      ? const Center(
                          child: Text(
                            "No reflections found. Time to let it out!",
                            style: TextStyle(color: Colors.white54, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _reflections.length,
                          itemBuilder: (context, index) {
                            final ref = _reflections[index];
                            
                            // Map simple mock data until we connect AI
                            final bool isAudio = ref['file_name'] != null && ref['file_name'].toString().isNotEmpty;
                            final String snippet = ref['transcription'] ?? "New journal entry...";
                            
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: _buildReflectionCard(
                                context,
                                date: _formatDate(ref['created_at']),
                                time: _formatTime(ref['created_at']),
                                isAudio: isAudio,
                                snippet: snippet,
                                moodIcons: [Icons.sentiment_neutral], 
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReflectionCard(
    BuildContext context, {
    required String date,
    required String time,
    required bool isAudio,
    required String snippet,
    required List<IconData> moodIcons,
  }) {
    // Note: Replaced InkWell with GestureDetector to remove the ghost shadow!
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AIAnalysisScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(date, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(width: 12),
                    Icon(isAudio ? Icons.mic : Icons.edit, color: const Color(0xFF8B5CF6), size: 16),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
                Row(
                  children: moodIcons.map((icon) => Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(icon, color: Colors.white54, size: 20),
                  )).toList(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              snippet,
              style: const TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}