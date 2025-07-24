import 'package:ai_math_app/widgets/feature_card.dart';
import 'package:ai_math_app/widgets/feature_item.dart';
import 'package:flutter/material.dart';

import '../widgets/banner_ad_widget.dart';
import '../widgets/interstitial_ad_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("AI Math Solver"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                "How can I help you today?",
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
      
              // Scan Card
              FeatureCard(
                icon: Icons.camera_alt,
                title: "Scan Math Problem",
                description:
                    "Take a photo of any math problem to get instant solutions.",
                color: Theme.of(context).colorScheme.primary,
                onTap: () => InterstitialAdManager.showNavigationAd(
                  context: context,
                  onComplete: () => Navigator.pushNamed(context, '/scan'),
                ),
              ),
              const SizedBox(height: 16),
      
              // Chat Card
              FeatureCard(
                icon: Icons.chat,
                title: "Chat with AI",
                description:
                    "Ask any math question and get step-by-step answers.",
                color: Theme.of(context).colorScheme.secondary,
                onTap: () => InterstitialAdManager.showNavigationAd(
                  context: context,
                  onComplete: () => Navigator.pushNamed(context, '/chat'),
                ),
              ),
              const SizedBox(height: 24),
      
              // Additional Info (Optional)
              const Text(
                "Features:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const FeatureItem(
                icon: Icons.check,
                text: "Algebra, Calculus, Geometry",
              ),
              const FeatureItem(
                icon: Icons.check,
                text: "Handwritten or printed problems",
              ),
              const FeatureItem(icon: Icons.check, text: "Detailed explanations"),
              const HomeBannerAd(),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/terms'),
                icon: const Icon(Icons.description_outlined, size: 24),
                label: const Text('Terms'),
                style: TextButton.styleFrom(
                  textStyle: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(fontSize: 12),
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/privacy'),
                icon: const Icon(Icons.privacy_tip_outlined, size: 24),
                label: const Text('Privacy'),
                style: TextButton.styleFrom(
                  textStyle: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
