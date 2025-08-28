import 'package:flutter/material.dart';
import 'package:laravel_api/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic>? _user;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
    _loadProfile();
  }

  void _loadProfile() async {
    final user = await AuthService().getProfile();
    setState(() => _user = user);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double paddingScale = screenWidth < 600
        ? 0.8
        : screenWidth < 900
        ? 1.0
        : 1.2;
    final double fontScale = screenWidth < 600 ? 0.95 : 1.0;

    if (_user == null) {
      return Center(child: CircularProgressIndicator(color: Color(0xFFA5D6A7)));
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFA5D6A7), // Light green
              Color(0xFF4CAF50), // Darker green
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0 * paddingScale,
                vertical: 36.0 * paddingScale,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar with fade-in animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Hero(
                        tag: 'logo',
                        child: CircleAvatar(
                          radius: 50 * paddingScale,
                          backgroundColor: Color(0xFF212121), // Black
                          child: Icon(
                            Icons.person_rounded,
                            size: 60 * paddingScale,
                            color: Color(0xFFFAFAFA), // Off-white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16 * paddingScale),
                    Text(
                      "Profil Kantin Sekolah",
                      style: TextStyle(
                        fontSize: 26 * fontScale,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2E7D32), // Dark green
                        letterSpacing: 1.1,
                        fontFamily: 'Poppins',
                        shadows: [
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(1, 1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(-1, -1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(1, -1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(-1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8 * paddingScale),
                    Text(
                      _user!['name'],
                      style: TextStyle(
                        fontSize: 22 * fontScale,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E7D32), // Dark green
                        fontFamily: 'Poppins',
                        shadows: [
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(1, 1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(-1, -1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(1, -1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(-1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      _user!['email'],
                      style: TextStyle(
                        fontSize: 16 * fontScale,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF2E7D32), // Dark green
                        fontFamily: 'Poppins',
                        shadows: [
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(1, 1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(-1, -1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(1, -1),
                          ),
                          Shadow(
                            color: Color(0xFF000000), // Black outline
                            blurRadius: 0,
                            offset: Offset(-1, 1),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30 * paddingScale),
                    // Info Card
                    Container(
                      padding: EdgeInsets.all(20 * paddingScale),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA), // Off-white
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _infoTile("Email", _user!['email'], fontScale),
                          Divider(color: Color(0xFFA5D6A7)), // Light green
                          _infoTile(
                            "Tanggal Daftar",
                            _user!['created_at'].substring(0, 10),
                            fontScale,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40 * paddingScale),
                    // Logout Button
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await AuthService().logout();
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                          size: 20 * fontScale,
                          color: Color(0xFFFAFAFA), // Off-white
                        ),
                        label: Text(
                          "Keluar",
                          style: TextStyle(
                            fontSize: 16 * fontScale,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Color(0xFFFAFAFA), // Off-white
                            shadows: [
                              Shadow(
                                color: Color(0xFF000000), // Black outline
                                blurRadius: 0,
                                offset: Offset(1, 1),
                              ),
                              Shadow(
                                color: Color(0xFF000000), // Black outline
                                blurRadius: 0,
                                offset: Offset(-1, -1),
                              ),
                              Shadow(
                                color: Color(0xFF000000), // Black outline
                                blurRadius: 0,
                                offset: Offset(1, -1),
                              ),
                              Shadow(
                                color: Color(0xFF000000), // Black outline
                                blurRadius: 0,
                                offset: Offset(-1, 1),
                              ),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF212121), // Black
                          minimumSize: Size(double.infinity, 56 * paddingScale),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 3,
                          shadowColor: Colors.black12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value, double fontScale) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16 * fontScale,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2E7D32), // Dark green
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16 * fontScale,
              fontWeight: FontWeight.w400,
              color: Color(0xFF2E7D32), // Dark green
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
