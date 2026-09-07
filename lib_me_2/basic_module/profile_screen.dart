import 'package:flutter/material.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool dark = context.watch<ThemeProvider>().dark;
    return Scaffold(
      // backgroundColor: _dark ? Colors.grey : Colors.white,
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 48,
                child: Icon(Icons.person, size: 56),
              ),
              const SizedBox(height: 20),
              Text(
                "Welcome to your profile",
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Manage your personal information and choose how the application looks.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const ListTile(
                leading: Icon(Icons.badge_outlined),
                title: Text("Name"),
                subtitle: Text("Your name"),
              ),
              const ListTile(
                leading: Icon(Icons.email_outlined),
                title: Text("Email"),
                subtitle: Text("your.email@example.com"),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(dark ? "Switch to light mode" : "Switch to dark mode"),
                  IconButton(
                    onPressed: () {
                      //remote controller
                      context.read<ThemeProvider>().toggleDark();
                    },
                    icon: Icon(dark ? Icons.light_mode : Icons.dark_mode),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


