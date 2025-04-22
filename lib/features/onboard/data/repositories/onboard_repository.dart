import 'package:manuk_pos/features/onboard/domain/entities/onboard_data.dart';

class OnboardRepository {
  List<OnboardData> getOnboardData() {
    return [
      OnboardData(
        image: 'assets/images/logo.png',
        title: 'Welcome to Manuk POS',
        description: 'This is a brief description of the app.',
      ),
      OnboardData(
        image: 'assets/images/logo.png',
        title: 'Manage Your Sales',
        description: 'Track and manage your sales efficiently.',
      ),
      OnboardData(
        image: 'assets/images/logo.png',
        title: 'Get Insights',
        description: 'Analyze your business performance in real-time.',
      ),
    ];
  }
}
