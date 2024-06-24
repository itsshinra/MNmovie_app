import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isOn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Align _buildBody(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/Movie_Fang.png'),
              radius: 70,
            ),
            const SizedBox(height: 8),
            const Text(
              'Sovanmakara',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: ListView(
                children: [
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.grey.withOpacity(0.3),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.person_2_rounded),
                      title: const Text('My Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.grey.withOpacity(0.3),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.lock_outline_rounded),
                      title: const Text('Security'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.grey.withOpacity(0.3),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.language_rounded),
                      title: const Text('Language'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.grey.withOpacity(0.3),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.call_outlined),
                      title: const Text('Contact Us'),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.grey.withOpacity(0.3),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(Icons.dark_mode_rounded),
                      title: const Text('Dark Mode'),
                      trailing: Switch(
                        onChanged: (bool isOn) {
                          setState(() {
                            _isOn = isOn;
                          });
                        },
                        value: _isOn,
                        activeColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.close_rounded,
          size: 32,
        ),
      ),
      title: const Text(
        'Profile',
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
