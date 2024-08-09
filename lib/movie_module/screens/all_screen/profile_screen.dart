import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

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
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Align _buildBody(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFe6e6dd),
                  width: 3,
                ),
              ),
              child: const CircleAvatar(
                backgroundColor: Colors.black,
                backgroundImage: AssetImage('assets/logos/me.1.JPG'),
                radius: 65,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sovanmakara',
              style: TextStyle(
                color: Color(0xFFe6e6dd),
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 500,
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.white.withOpacity(0.1),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Iconsax.profile_circle,
                        color: Color(0xFFe6e6dd),
                      ),
                      title: const Text(
                        'My Profile',
                        style: TextStyle(color: Color(0xFFe6e6dd)),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFe6e6dd),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.white.withOpacity(0.1),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Iconsax.lock,
                        color: Color(0xFFe6e6dd),
                      ),
                      title: const Text(
                        'Security',
                        style: TextStyle(color: Color(0xFFe6e6dd)),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFe6e6dd),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.white.withOpacity(0.1),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Iconsax.global,
                        color: Color(0xFFe6e6dd),
                      ),
                      title: const Text('Language',
                          style: TextStyle(color: Color(0xFFe6e6dd))),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFe6e6dd),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.white.withOpacity(0.1),
                    child: ListTile(
                      onTap: () {},
                      leading: const Icon(
                        Iconsax.call,
                        color: Color(0xFFe6e6dd),
                      ),
                      title: const Text('Contact Us',
                          style: TextStyle(color: Color(0xFFe6e6dd))),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Color(0xFFe6e6dd),
                      ),
                    ),
                  ),
                  Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    color: Colors.white.withOpacity(0.1),
                    child: ListTile(
                      leading: _isOn
                          ? const Icon(
                              Iconsax.moon5,
                              color: Color(0xFFe6e6dd),
                            )
                          : const Icon(
                              Iconsax.sun_15,
                              color: Color(0xFFe6e6dd),
                            ),
                      title: _isOn
                          ? const Text(
                              'Dark Mode',
                              style: TextStyle(
                                color: Color(0xFFe6e6dd),
                              ),
                            )
                          : const Text(
                              'Light Mode',
                              style: TextStyle(
                                color: Color(0xFFe6e6dd),
                              ),
                            ),
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
            const Text('@MovieFang 2024'),
            const Text(
              'Develop by Sovanmakara',
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.close_rounded,
          size: 32,
          color: Color(0xFFe6e6dd),
        ),
      ),
      title: const Text(
        'Profile',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xFFe6e6dd),
        ),
      ),
    );
  }
}
