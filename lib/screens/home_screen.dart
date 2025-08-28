import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
                    // Canteen-themed icon with fade-in animation
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Hero(
                        tag: 'logo',
                        child: CircleAvatar(
                          radius: 48 * paddingScale,
                          backgroundColor: Color(0xFF212121), // Black
                          child: Icon(
                            Icons.restaurant_rounded,
                            size: 48 * paddingScale,
                            color: Color(0xFFFAFAFA), // Off-white
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24 * paddingScale),
                    Text(
                      "Selamat Datang di Kantin Sekolah",
                      style: TextStyle(
                        fontSize: 26 * fontScale,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 247, 248, 247), // Dark green
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
                    SizedBox(height: 12 * paddingScale),
                    Text(
                      "Pesan makanan favoritmu sekarang",
                      style: TextStyle(
                        fontSize: 16 * fontScale,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 250, 251, 250), // Dark green
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
                    SizedBox(height: 36 * paddingScale),
                    // Content Card
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
                          Text(
                            "Nikmati kemudahan memesan makanan di kantin sekolah dengan aplikasi kami!",
                            style: TextStyle(
                              fontSize: 16 * fontScale,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2E7D32), // Dark green
                              fontFamily: 'Poppins',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20 * paddingScale),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/order',
                                );
                              },
                              child: Text(
                                "Mulai Memesan",
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
