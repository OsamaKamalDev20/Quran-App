import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui/Quran%20App/json/onboarding_screen_data.dart';
import 'package:flutter_ui/Quran%20App/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../provider/quran_onboarding_provider.dart';
import '../utils/colors.dart';

class QuranOnboardingScreen extends StatefulWidget {
  const QuranOnboardingScreen({super.key});

  @override
  State<QuranOnboardingScreen> createState() => _QuranOnboardingScreenState();
}

class _QuranOnboardingScreenState extends State<QuranOnboardingScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<QuranOnboardingProvider>().initializeAnimations(this);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuranOnboardingProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: warmBackground,
          body: SafeArea(
            child: Column(
              children: [
                // 🔹 Skip Button Row
                Align(
                  alignment: .topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const QuranHomePage(),
                        ),
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: .w600,
                        color: primaryGreen,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: provider.quranController,
                    itemCount: onboardData.length,
                    onPageChanged: provider.onPageChanged,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const .symmetric(horizontal: 20),
                        child: FadeTransition(
                          opacity: provider.fadeAnimation,
                          child: SlideTransition(
                            position: provider.slideAnimation,
                            child: Column(
                              spacing: 20,
                              mainAxisAlignment: .center,
                              children: [
                                // Animated image container
                                ScaleTransition(
                                  scale: provider.scaleAnimation,
                                  child: Hero(
                                    tag:
                                        "onboardData_${onboardData[index].image}",
                                    child: ClipRRect(
                                      borderRadius: .circular(10),
                                      child: Image.asset(
                                        onboardData[index].image,
                                        height: 200,
                                        width: .infinity,
                                        fit: .cover,
                                      ),
                                    ),
                                  ),
                                ),

                                // Title with animated container
                                FadeInLeft(
                                  delay: const Duration(milliseconds: 500),
                                  child: Text(
                                    onboardData[index].title,
                                    textAlign: .center,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: .bold,
                                      color: primaryGreen,
                                    ),
                                  ),
                                ),

                                // Description with animated container
                                FadeInUp(
                                  delay: const Duration(milliseconds: 600),
                                  child: Text(
                                    onboardData[index].description,
                                    textAlign: .center,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: translationText,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 20),
                // Page indicator
                SmoothPageIndicator(
                  controller: provider.quranController,
                  count: onboardData.length,
                  effect: CustomizableEffect(
                    dotDecoration: DotDecoration(
                      width: 16,
                      height: 8,
                      // ignore: deprecated_member_use
                      color: primaryGreen.withOpacity(.18),
                      borderRadius: .circular(4),
                    ),
                    activeDotDecoration: DotDecoration(
                      width: 40,
                      height: 8,
                      color: primaryGreen,
                      borderRadius: .circular(4),
                    ),
                  ),
                ),

                // Enhanced button
                SizedBox(height: 30),
                FadeInLeft(
                  delay: Duration(milliseconds: 600),
                  child: Container(
                    height: 50,
                    width: .infinity,
                    margin: const .symmetric(vertical: 15),
                    padding: const .symmetric(horizontal: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: textColor,
                      ),
                      onPressed: () {
                        if (provider.currentPage == onboardData.length - 1) {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const QuranHomePage(),
                            ),
                          );
                        } else {
                          provider.nextPage(onboardData.length);
                        }
                      },
                      child: Text(
                        "Start Reading Quran",
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.1,
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
