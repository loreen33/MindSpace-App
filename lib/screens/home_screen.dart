import 'package:flutter/material.dart';
import 'record_screen.dart';
import 'reflections_screen.dart';
import 'connect_screen.dart';
import 'profile_screen.dart';
import 'write_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName; 

  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeContent(onNavigate: _onItemTapped, userName: widget.userName),
          const ReflectionsContent(),
          const ConnectContent(),
          const ProfileContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF111827),
        selectedItemColor: const Color(0xFF8B5CF6),
        unselectedItemColor: Colors.white38,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.format_list_bulleted), label: "Reflections"),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: "Connect"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}

// --- HOME DASHBOARD UI ---
class HomeContent extends StatefulWidget {
  final Function(int) onNavigate;
  final String userName; 

  const HomeContent({super.key, required this.onNavigate, required this.userName});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int? _selectedMoodIndex;

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_getGreeting()},\n${widget.userName}", 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                GestureDetector(
                  onTap: () => widget.onNavigate(3), // Jumps to Profile Tab
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),
            
            const Text("How are you feeling today?", style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMoodIcon(Icons.sentiment_very_dissatisfied, "Very sad", 0),
                _buildMoodIcon(Icons.sentiment_dissatisfied, "Sad", 1),
                _buildMoodIcon(Icons.sentiment_neutral, "Okay", 2),
                _buildMoodIcon(Icons.sentiment_satisfied, "Good", 3),
                _buildMoodIcon(Icons.sentiment_very_satisfied, "Great", 4),
              ],
            ),
            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05), 
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text("Let it out", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 8),
                  const Text("Say whatever is on your mind.\nNo advice. No judgment.", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70, height: 1.5)),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RecordScreen())),
                      icon: const Icon(Icons.mic, color: Colors.white),
                      label: const Text("Start Recording", style: TextStyle(color: Colors.white, fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  // THE FIX: Changed InkWell to GestureDetector
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WriteScreen())),
                    child: _buildSecondaryCard(Icons.edit, "Write\nyour thoughts"),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  // THE FIX: Changed InkWell to GestureDetector
                  child: GestureDetector(
                    onTap: () => widget.onNavigate(1), // Jumps to Reflections Tab
                    child: _buildSecondaryCard(Icons.book, "Reflect\non past moments"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            GestureDetector(
              onTap: () => widget.onNavigate(2), // Jumps to Connect Tab
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Connect with people", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const Icon(Icons.arrow_forward, color: Color(0xFFF97316)), 
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMoodIcon(IconData icon, String label, int index) {
    bool isSelected = _selectedMoodIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedMoodIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(color: isSelected ? const Color(0xFF8B5CF6).withOpacity(0.2) : Colors.transparent, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFEC4899) : Colors.white54, size: isSelected ? 36 : 32),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(color: isSelected ? const Color(0xFFEC4899) : Colors.white54, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildSecondaryCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFFEC4899)),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.3)),
        ],
      ),
    );
  }
}