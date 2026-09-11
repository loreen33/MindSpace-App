import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ConnectContent extends StatefulWidget {
  const ConnectContent({super.key});

  @override
  State<ConnectContent> createState() => _ConnectContentState();
}

class _ConnectContentState extends State<ConnectContent> {
  final List<String> _selectedInterests = ['Coding', 'Art']; 
  
  // 1. STATE MANAGEMENT: This Set remembers who you are already friends with.
  // I added 'Alex' here by default since you mentioned he is already your friend!
  final Set<String> _connectedUsers = {'Alex'}; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Connect", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            const Text("Find people you might connect with.", style: TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.white54),
                  hintText: "Search interests...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildInterestChip("Books", Icons.menu_book),
                _buildInterestChip("Music", Icons.music_note),
                _buildInterestChip("Coding", Icons.code),
                _buildInterestChip("Art", Icons.palette),
                _buildInterestChip("Travel", Icons.flight),
                _buildInterestChip("Gaming", Icons.videogame_asset),
              ],
            ),
            const SizedBox(height: 40),

            const Text("People with similar interests", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            _buildUserRow("Alex", "Music • Books", "A"),
            const SizedBox(height: 16),
            _buildUserRow("Maya", "Art • Photography", "M"),
            const SizedBox(height: 16),
            _buildUserRow("Daniel", "Tech • Gaming", "D"),
            const SizedBox(height: 16),
            _buildUserRow("Sofia", "Travel • Nature", "S"),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestChip(String label, IconData icon) {
    bool isSelected = _selectedInterests.contains(label);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected ? _selectedInterests.remove(label) : _selectedInterests.add(label);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF8B5CF6).withOpacity(0.2) : Colors.white.withOpacity(0.05),
          border: Border.all(color: isSelected ? const Color(0xFF8B5CF6) : Colors.white12),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFEC4899) : Colors.white54, size: 18), 
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow(String name, String interests, String initial) {
    // 2. CHECK STATUS: Are we connected to this user?
    bool isConnected = _connectedUsers.contains(name);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.02), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          // 3. PROFILE VIEW: Wrapping the avatar and name in a GestureDetector
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _showUserProfile(name, interests, initial, isConnected),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: Text(initial, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(interests, style: const TextStyle(color: Colors.white54, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // 4. DYNAMIC BUTTON: Changes based on the 'isConnected' status
          isConnected
              ? OutlinedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(userName: name, userInitial: initial)));
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF8B5CF6)), // Violet outline
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text("Message", style: TextStyle(color: Color(0xFF8B5CF6), fontSize: 14)),
                )
              : ElevatedButton(
                  onPressed: () {
                    // Update state to remember the connection
                    setState(() => _connectedUsers.add(name));
                    
                    // Show a little success pop-up
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("You are now connected with $name!"), 
                        backgroundColor: const Color(0xFF8B5CF6),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: const Text("Connect", style: TextStyle(color: Colors.white, fontSize: 14)),
                ),
        ],
      ),
    );
  }

  // 5. THE BOTTOM SHEET: Shows full user details when you tap their name
  void _showUserProfile(String name, String interests, String initial, bool isConnected) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF111827),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white.withOpacity(0.1),
                child: Text(initial, style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Text(name, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(interests, style: const TextStyle(color: Color(0xFFEC4899), fontSize: 16)), // Twilight Pink tags
              const SizedBox(height: 24),
              const Text(
                "Bio: Just looking for a safe space to share thoughts. No advice needed, just hoping to connect with people who get it.", 
                textAlign: TextAlign.center, 
                style: TextStyle(color: Colors.white70, height: 1.5)
              ),
              const SizedBox(height: 32),
              
              SizedBox(
                width: double.infinity,
                child: isConnected
                    ? ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context); // Close the sheet
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(userName: name, userInitial: initial)));
                        },
                        icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
                        label: const Text("Message", style: TextStyle(color: Colors.white, fontSize: 16)),
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          setState(() => _connectedUsers.add(name));
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                        child: const Text("Connect", style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}