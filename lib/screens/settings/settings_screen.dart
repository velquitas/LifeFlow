import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),

          const ListTile(
            leading: Icon(Icons.person),
            title: Text("Account"),
            subtitle: Text("Coming Soon"),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text("Export Backup"),
            subtitle: const Text("Save all LifeFlow data"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Export coming next sprint",
                  ),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.download),
            title: const Text("Import Backup"),
            subtitle: const Text("Restore LifeFlow data"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    "Import coming next sprint",
                  ),
                ),
              );
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
            subtitle: Text("Coming Soon"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text("Appearance"),
            subtitle: Text("Coming Soon"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About LifeFlow"),
            subtitle: Text("Version 1.0 MVP"),
          ),
        ],
      ),
    );
  }
}