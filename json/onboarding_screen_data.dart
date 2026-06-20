class QuranOnboardingScreen {
  String title, image, description;

  QuranOnboardingScreen({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<QuranOnboardingScreen> onboardData = [
  QuranOnboardingScreen(
    title: "Read & Reflect",
    image: "assets/images/quran/onboarding_1.jpg",
    description:
        "Read the Holy Quran with beautiful Uthmani script, translations in multiple languages, and word-by-word meanings.",
  ),
  QuranOnboardingScreen(
    title: "Listen & Understand",
    image: "assets/images/quran/onboarding_2.jpg",
    description:
        "Listen to beautiful recitations by world-renowned Qaris with synchronized highlighting of verses.",
  ),
  QuranOnboardingScreen(
    title: "Memorize & Recite",
    image: "assets/images/quran/onboarding_3.jpg",
    description:
        "Memorize the Holy Quran with powerful tools, repetition modes, and progress tracking to help you become a Hafiz",
  ),
];
