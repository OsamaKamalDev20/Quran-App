// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_ui/Quran%20App/utils/colors.dart';

import 'quran_onboarding_screen.dart';

class QuranWelcomeScreen extends StatefulWidget {
  const QuranWelcomeScreen({super.key});

  @override
  State<QuranWelcomeScreen> createState() => _QuranWelcomeScreenState();
}

class _QuranWelcomeScreenState extends State<QuranWelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    // Define animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A1A), Color(0xFF2D2D2D), Color(0xFF1A1A1A)],
          ),
        ),
        child: Stack(
          children: [
            // Background image with overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(
                      "assets/images/quran/welcome_screen.jpg",
                    ),
                    fit: .cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5),
                      .darken,
                    ),
                  ),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Padding(
                padding: const .symmetric(horizontal: 24),
                child: Column(
                  children: [
                    // App logo/Icon with animation
                    const SizedBox(height: 80),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Icon(
                          FlutterIslamicIcons.quran2,
                          size: 110,
                          color: textColor,
                        ),
                      ),
                    ),

                    // Main heading with slide animation
                    const SizedBox(height: 30),
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          "ٱلْقُرْآنُ ٱلْكَرِيمُ",
                          textAlign: .center,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 50,
                            fontWeight: .w700,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                offset: const Offset(0, 2),
                                blurRadius: 8,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Description with slide animation
                    const SizedBox(height: 20),
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          padding: const .all(15),
                          decoration: BoxDecoration(
                            color: textColor.withOpacity(0.1),
                            borderRadius: .circular(8),
                            border: .all(color: accentGold, width: 1),
                          ),
                          child: Column(
                            mainAxisAlignment: .center,
                            crossAxisAlignment: .center,
                            children: [
                              Text(
                                "كِتَابٌ أَنزَلْنَاهُ إِلَيْكَ مُبَارَكٌ",
                                textAlign: .center,
                                style: TextStyle(
                                  fontSize: 24,
                                  color: textColor,
                                  height: 1.5,
                                  fontWeight: .w600,
                                ),
                              ),
                              Text(
                                "A Book We have sent down to you, blessed",
                                textAlign: .center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: textColor,
                                  fontWeight: .w500,
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: .centerRight,
                                child: Text(
                                  'Surah Sad 38:29',
                                  textAlign: .end,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: accentGold,
                                    fontWeight: .w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Get Started button with animation
                    // Get Started button with animation
                    const SizedBox(height: 40),
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          width: .infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [accentGold, accentGold.withOpacity(0.8)],
                              begin: .centerLeft,
                              end: .centerRight,
                            ),
                            borderRadius: .circular(50),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => QuranOnboardingScreen(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Row(
                                  spacing: 8,
                                  mainAxisAlignment: .center,
                                  children: [
                                    Text(
                                      "Start Reading",
                                      style: TextStyle(
                                        color: textColor,
                                        letterSpacing: .5,
                                        fontSize: 18,
                                        fontWeight: .w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_rounded,
                                      color: textColor,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
