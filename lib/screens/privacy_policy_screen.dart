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
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last updated: December 2024',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            
            _buildSection(
              context,
              'Information We Collect',
              'AI Math Solver is designed with privacy in mind. We collect minimal information necessary to provide our services:\n\n• Images: Photos you take or select for OCR processing (processed locally)\n• Text Messages: Chat conversations with our AI (not stored permanently)\n• Usage Data: Basic app usage statistics for improvement purposes\n• Device Information: Basic device info for compatibility and performance optimization',
            ),
            
            _buildSection(
              context,
              'How We Use Your Information',
              'Your information is used solely to:\n\n• Process mathematical problems through OCR\n• Provide AI-powered solutions and explanations\n• Improve app performance and user experience\n• Ensure app stability and security\n\nWe do not use your data for advertising or marketing purposes.',
            ),
            
            _buildSection(
              context,
              'Data Storage and Security',
              'Your privacy is our priority:\n\n• Images are processed locally on your device using Google ML Kit\n• Chat conversations are not stored permanently on our servers\n• All communications with our AI service are encrypted\n• We do not create permanent user profiles or accounts\n• No personal identification information is required or collected',
            ),
            
            _buildSection(
              context,
              'Third-Party Services',
              'AI Math Solver uses the following third-party services:\n\n• Google ML Kit: For on-device text recognition (no data sent to Google)\n• DeepSeek AI: For mathematical problem solving (messages are processed but not stored)\n• Device Camera and Gallery: For image capture and selection (permissions required)',
            ),
            
            _buildSection(
              context,
              'Data Sharing',
              'We do not sell, trade, or otherwise transfer your personal information to third parties. This does not include trusted third parties who assist us in operating our app, conducting our business, or servicing you, as long as those parties agree to keep this information confidential.',
            ),
            
            _buildSection(
              context,
              'Children\'s Privacy',
              'Our app is suitable for users of all ages, including children. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe your child has provided us with personal information, please contact us.',
            ),
            
            _buildSection(
              context,
              'Permissions Explanation',
              'AI Math Solver requests the following permissions:\n\n• Camera: To capture photos of mathematical problems\n• Photo Library: To select existing images for processing\n• Internet: To communicate with AI services for problem solving\n\nThese permissions are used only for their stated purposes.',
            ),
            
            _buildSection(
              context,
              'Data Retention',
              'We retain your data for the shortest time necessary:\n\n• Images: Processed locally and not stored permanently\n• Chat messages: Cleared when you close the app or clear chat\n• Usage analytics: Anonymized and retained for app improvement only',
            ),
            
            _buildSection(
              context,
              'Your Rights',
              'You have the right to:\n\n• Clear your chat history at any time\n• Deny or revoke app permissions\n• Request information about data processing\n• Contact us with privacy concerns\n• Uninstall the app to remove all local data',
            ),
            
            _buildSection(
              context,
              'Changes to Privacy Policy',
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date.',
            ),
            
            _buildSection(
              context,
              'Contact Us',
              'If you have any questions about this Privacy Policy or our data practices, please contact us through the app support section or our official channels.',
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