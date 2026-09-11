import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top App Bar / Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Profile",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.white54),
                  onPressed: () {
                    print("Open main settings");
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),

            // User Info Section
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  child: const Icon(Icons.person, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Loreen",
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "27 reflections • 8 connections",
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),

            // My Interests Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Interests",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white54, size: 18),
                  onPressed: () {},
                )
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildInterestChip("Books", Icons.menu_book),
                _buildInterestChip("Art", Icons.palette),
                _buildInterestChip("Tech", Icons.code),
                // The '+' Add button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white24, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.add, color: Colors.white54, size: 18),
                )
              ],
            ),
            const SizedBox(height: 40),

            // Settings Menu List
            _buildSettingsTile(Icons.lock_outline, "Privacy"),
            _buildSettingsTile(Icons.notifications_none, "Notifications"),
            _buildSettingsTile(Icons.auto_awesome, "AI & Reflection Settings", iconColor: const Color(0xFFF97316)), // Sunset Orange for AI
            _buildSettingsTile(Icons.people_outline, "Connection Settings"),
            _buildSettingsTile(Icons.help_outline, "Help & Safety"),
            _buildSettingsTile(Icons.manage_accounts_outlined, "Account Settings"),
            
            const SizedBox(height: 40),
            
            // Log Out Button
            Center(
              child: TextButton(
                onPressed: () {
                  print("Log out clicked");
                },
                child: const Text(
                  "Log Out", 
                  style: TextStyle(color: Color(0xFFEC4899), fontSize: 16, fontWeight: FontWeight.bold) // Twilight Pink
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper widget for interest tags
  Widget _buildInterestChip(String label, IconData icon) {
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
          Icon(icon, color: const Color(0xFF8B5CF6), size: 18), // Violet
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  // Helper widget for setting list items
  Widget _buildSettingsTile(IconData icon, String title, {Color? iconColor}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: iconColor ?? Colors.white54),
      title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
      trailing: const Icon(Icons.chevron_right, color: Colors.white24),
      onTap: () {
        print("$title clicked");
      },
    );
  }
}