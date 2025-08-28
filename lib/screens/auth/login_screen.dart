import 'package:flutter/material.dart';
import 'package:laravel_api/screens/auth/register_screen.dart';
import 'package:laravel_api/screens/menu_screen.dart';
import 'package:laravel_api/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
    final double fontScale = screenWidth < 600
        ? 0.95
        : 1.0; // Slightly larger for mobile

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
                          backgroundColor: Color(
                            0xFFFAFAFA,
                          ).withOpacity(0.2), // Off-white
                          child: Icon(
                            Icons.restaurant_menu_rounded,
                            size: 48 * paddingScale,
                            color: Color.fromARGB(255, 6, 6, 6), // Light green
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24 * paddingScale),
                    Text(
                      "Selamat Datang di Kantin Sekolah",
                      style: TextStyle(
                        fontSize: 26 * fontScale,
                        fontWeight: FontWeight.w800, // Bolder for clarity
                        color: Color(0xFF212121), // Near-black for contrast
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
                      "Masuk untuk memesan makanan",
                      style: TextStyle(
                        fontSize: 16 * fontScale,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF212121), // Near-black for contrast
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
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: Color(0xFFFF5722), // Warm orange
                              ),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Color(0xFF424242), // Darker for clarity
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
                              color: Color(
                                0xFF212121,
                              ), // Near-black for input text
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
                                color: Color(0xFF424242), // Darker for clarity
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
                              color: Color(
                                0xFF212121,
                              ), // Near-black for input text
                            ),
                          ),
                          SizedBox(height: 28 * paddingScale),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                bool success = await _authService.login(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                if (success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => MenuScreen(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Login Gagal',
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
                                Icons.login_rounded,
                                size: 20 * fontScale,
                                color: Color.fromARGB(
                                  255,
                                  250,
                                  250,
                                  250,
                                ), // Warm orange
                              ),
                              label: Text(
                                "Masuk",
                                style: TextStyle(
                                  fontSize: 16 * fontScale,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  color: Color.fromARGB(
                                    255,
                                    253,
                                    253,
                                    252,
                                  ), // Warm orange
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  7,
                                  7,
                                  7,
                                ), // Light green
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        "Belum punya akun? Daftar di sini",
                        style: TextStyle(
                          color: Color(0xFF212121), // Near-black for contrast
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
