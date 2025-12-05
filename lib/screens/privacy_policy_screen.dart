import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Title
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),

            // Last Updated Date
            Text(
              'Last Updated: Nov 2025',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            
            // Introductory Paragraph
            Text(
              'JUAN PALACIOS LLC ("we", "our", or "us") values your privacy. This Privacy Policy explains how we collect, use, and protect your information when you use our mobile application Ai Math Solver ("App"). By using the App, you agree to the practices described in this Privacy Policy.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // 1. Information We Collect
            _buildSection(
              context,
              '1. Information We Collect',
              'AI Math Solver is designed with privacy in mind. We collect minimal information necessary to provide our services:\n\n1.1 Images (Photos)\nWhen you scan a math problem, the app may access your camera or photo library.\n• Images are used only for mathematical text recognition (OCR).\n• All image processing is done locally on your device using Google ML Kit.\n• We do not store, upload, or share your images.\n\n1.2 Text Messages\nWhen you chat with our AI, the messages you send are transmitted to our AI provider (DeepSeek AI) to generate responses.\n• Messages are not stored permanently by us.\n• No chat data is used for training or advertising purposes.\n\n1.3 Device Information\nWe may collect limited, non-personal information such as:\n• Device model\n• Operating system version\n• Performance and crash information\n• This helps improve app performance and compatibility.\n• We do not collect any information that can directly identify you.',
            ),
            
            // 2. How We Use Your Information
            _buildSection(
              context,
              '2. How We Use Your Information',
              'Your data is used only to:\n\n• Solve math problems and generate responses.\n• Process images to extract text.\n• Improve app functionality, performance, and stability.\n• Provide customer support when needed.\n\nWe never sell your data or use it for advertising.',
            ),
            
            // 3. Third-Party Services
            _buildSection(
              context,
              '3. Third-Party Services',
              'The app uses the following trusted services:\n\n3.1 Google ML Kit\n• Used for on-device text recognition (OCR).\n• Images are processed directly on your device.\n• No image data is sent to Google servers.\n\n3.2 DeepSeek AI\n• Used to analyze and solve mathematical problems.\n• Messages are processed to generate solutions.\n• Data is not stored after processing.\n\n3.3 Device Camera and Gallery\n• Used only when you choose to take or select a photo.\n• Requires your permission.',
            ),
            
            // 4. Permissions We Use
            _buildSection(
              context,
              '4. Permissions We Use',
              'The app requests the following permissions:\n\n• Camera: To take photos of math problems.\n• Photo Library / Storage: To select existing images for text extraction.\n• Internet: Required to communicate with the AI model and generate solutions.\n\nWe request only the permissions necessary for the app to function.',
            ),
            
            // 5. Data Security
            _buildSection(
              context,
              '5. Data Security',
              'We take data protection seriously:\n\n• Images are processed locally and never uploaded.\n• All network communication is encrypted (HTTPS).\n• We do not store personal information on our servers.',
            ),
            
            // 6. Children’s Privacy
            _buildSection(
              context,
              '6. Children’s Privacy',
              'AI Math Solver is suitable for students, but we do not knowingly collect personal data from children.\nIf you believe a child has provided personal data, please contact us and we will delete it.',
            ),
            
            // 7. Your Rights
            _buildSection(
              context,
              '7. Your Rights',
              'You may:\n\n• Request deletion of any temporary data associated with your use.\n• Disable camera or photo access at any time through your device settings.',
            ),
            
            // 8. Changes to This Policy
            _buildSection(
              context,
              '8. Changes to This Policy',
              'We may update this Privacy Policy. When we do, we will update the "Last Updated" date at the top.',
            ),
            
            // 9. Contact Us (Updated with email)
            _buildSection(
              context,
              '9. Contact Us',
              'If you have any questions about this Privacy Policy or your data, please contact us:\njuancpalacios878@gmail.com\nThank you for using AI Math Solver.',
            ),
            
            const SizedBox(height: 32),
            
            Center(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Got It'),
              ),
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}