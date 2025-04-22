import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:manuk_pos/core/theme/theme.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.backgroundPrimaryColor,
        body: OnBoardingSlider(
          finishButtonText: 'Register',
          onFinish: () {
            context.go('/auth/signup');
          },
          finishButtonStyle: FinishButtonStyle(
            backgroundColor: AppTheme.secondaryColor,
          ),
          skipTextButton: Text(
            'Skip',
            style: AppTheme.bodyText,
          ),
          trailing: Text(
            'Guest Mode',
            style: AppTheme.bodyText,
          ),
          trailingFunction: () {
            context.go('/home');
          },
          controllerColor: AppTheme.secondaryColor,
          totalPage: 3,
          headerBackgroundColor: AppTheme.secondaryColor,
          // pageBackgroundColor: AppTheme.secondaryColor,
          background: [
            Image.asset(
              'assets/images/onboard/1.png',
              height: 400,
            ),
            Image.asset(
              'assets/images/onboard/2.jpeg',
              height: 400,
            ),
            Image.asset(
              'assets/images/onboard/3.jpg',
              height: 400,
            ),
          ],
          speed: 1.8,
          pageBodies: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    'Simplify Your Sales Process',
                    textAlign: TextAlign.center,
                    style: AppTheme.headingText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Manuk Pos helps you handle sales faster and smarter. Create transactions, print receipts, and manage customers with ease—all from your mobile device.',
                    textAlign: TextAlign.center,
                    style: AppTheme.bodyText,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    'Real-Time Inventory Management',
                    textAlign: TextAlign.center,
                    style: AppTheme.headingText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Track your stock levels effortlessly. Manuk Pos keeps your inventory up to date automatically, so you always know what's available, what’s low, and what to restock.",
                    textAlign: TextAlign.center,
                    style: AppTheme.bodyText,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 480,
                  ),
                  Text(
                    'Smart Reports for Better Decisions',
                    textAlign: TextAlign.center,
                    style: AppTheme.headingText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Understand your business with clear and simple reports. Manuk Pos provides daily sales summaries, top-selling items, and profit analysis to help you grow.',
                    textAlign: TextAlign.center,
                    style: AppTheme.bodyText,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
