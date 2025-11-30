import 'package:ai_math_app/widgets/feature_card.dart';
import 'package:ai_math_app/widgets/feature_item.dart';
import 'package:flutter/material.dart';

import '../widgets/banner_ad_widget.dart';
import '../widgets/interstitial_ad_widget.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: Wrapping in SafeArea and Scaffold is fine.
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("AI Math Solver"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          // IMPORTANT CHANGE: Column to take up full available height
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // Align the content to start, but use Expanded and Spacer to manage spacing
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
              // Header
              Text(
                "How can I help you today?",
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              
              // A little space after the greeting
              const SizedBox(height: 30), 
              
              // 1. Scan Card (Wrapped in Expanded)
              Expanded(
                child: FeatureCard(
                  icon: Icons.camera_alt,
                  title: "Scan Math Problem",
                  description: "Take a photo of any math problem to get instant solutions.",
                  color: Theme.of(context).colorScheme.primary,
                  onTap: () => Navigator.pushNamed(context, '/scan'),
                ),
              ),
              
              // Space between cards
              const SizedBox(height: 20), 
              
              // 2. Chat Card (Wrapped in Expanded)
              Expanded(
                child: FeatureCard(
                  icon: Icons.chat,
                  title: "Chat with AI",
                  description: "Ask any math question and get step-by-step answers.",
                  color: Theme.of(context).colorScheme.secondary,
                  onTap: () => Navigator.pushNamed(context, '/chat'),
                ),
              ),
              
              // Spacer to push everything else up slightly (Optional: Use instead of BannerAd)
              // const Spacer(),
              
              const SizedBox(height: 24),
              // const HomeBannerAd(), // Keep this if you want the ad at the bottom of the body
            ],
          ),
        ),
        
        // This part is fine as it's a fixed footer
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ... Terms and Privacy buttons
              TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/terms'),
                icon: const Icon(Icons.description_outlined, size: 24),
                label: const Text('Terms'),
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12),
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/privacy'),
                icon: const Icon(Icons.privacy_tip_outlined, size: 24),
                label: const Text('Privacy'),
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}