import 'package:flutter/material.dart';
import 'package:laravel_api/screens/auth/login_screen.dart';
import 'package:laravel_api/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final AuthService _authService = AuthService();
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
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

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF5722), // Warm orange
              Color(0xFFFFF176), // Soft yellow
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Canteen-themed logo with fade-in animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Hero(
                        tag: 'logo',
                        child: CircleAvatar(
                          radius: 48 * paddingScale,
                          backgroundColor: Color(0xFF212121), // Black
                          child: Icon(
                            Icons.person_add_rounded,
                            size: 48 * paddingScale,
                            color: Color(0xFFFAFAFA), // Off-white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24 * paddingScale),
                    Text(
                      "Daftar di Kantin Sekolah",
                      style: TextStyle(
                        fontSize: 26 * fontScale,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF212121), // Near-black
                        letterSpacing: 1.1,
                        fontFamily: 'Poppins',
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Buat akun untuk memesan makanan",
                      style: TextStyle(
                        fontSize: 16 * fontScale,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF212121), // Near-black
                        fontFamily: 'Poppins',
                        shadows: [
                          Shadow(
                            color: Colors.white.withOpacity(0.5),
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36 * paddingScale),

                    // Form Card
                    Container(
                      padding: EdgeInsets.all(24 * paddingScale),
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA), // Off-white
                        borderRadius: BorderRadius.circular(20),
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
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_rounded,
                                color: Color(0xFFFF5722), // Warm orange
                              ),
                              labelText: 'Nama Lengkap',
                              labelStyle: TextStyle(
                                color: Color(0xFF424242), // Dark gray
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              filled: true,
                              fillColor: Color(
                                0xFFFFF176,
                              ).withOpacity(0.3), // Soft yellow
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey[200]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFA5D6A7), // Light green
                                  width: 2,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF212121), // Near-black
                            ),
                          ),
                          SizedBox(height: 20 * paddingScale),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: Color(0xFFFF5722), // Warm orange
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Color(0xFF424242), // Dark gray
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              filled: true,
                              fillColor: Color(
                                0xFFFFF176,
                              ).withOpacity(0.3), // Soft yellow
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey[200]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFA5D6A7), // Light green
                                  width: 2,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF212121), // Near-black
                            ),
                          ),
                          SizedBox(height: 20 * paddingScale),
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_rounded,
                                color: Color(0xFFFF5722), // Warm orange
                              ),
                              labelText: 'Kata Sandi',
                              labelStyle: TextStyle(
                                color: Color(0xFF424242), // Dark gray
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              filled: true,
                              fillColor: Color(
                                0xFFFFF176,
                              ).withOpacity(0.3), // Soft yellow
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey[200]!,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Color(0xFFA5D6A7), // Light green
                                  width: 2,
                                ),
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF212121), // Near-black
                            ),
                          ),
                          SizedBox(height: 28 * paddingScale),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                bool success = await _authService.register(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                );
                                if (success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Registrasi Gagal',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFFFAFAFA),
                                        ),
                                      ),
                                      backgroundColor: Colors.redAccent,
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                }
                              },
                              icon: Icon(
                                Icons.app_registration_rounded,
                                size: 20 * fontScale,
                                color: Color(0xFFFAFAFA), // Off-white
                              ),
                              label: Text(
                                "Daftar",
                                style: TextStyle(
                                  fontSize: 16 * fontScale,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color(0xFFFAFAFA), // Off-white
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF212121), // Black
                                minimumSize: Size(
                                  double.infinity,
                                  56 * paddingScale,
                                ),
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

                    SizedBox(height: 24 * paddingScale),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sudah punya akun? Masuk di sini",
                        style: TextStyle(
                          color: Color(0xFF212121), // Near-black
                          fontSize: 15 * fontScale,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          shadows: [
                            Shadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 2,
                              offset: Offset(1, 1),
                            ),
                          ],
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
}
