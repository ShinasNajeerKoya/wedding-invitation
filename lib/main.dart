import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(const WalimaInvitationApp());
}

class WalimaInvitationApp extends StatelessWidget {
  const WalimaInvitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Venue Locations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC49A6C)),
        scaffoldBackgroundColor: const Color(0xFFFFF7EE),
        useMaterial3: true,
      ),
      home: const InvitationPage(),
    );
  }
}

class InvitationPage extends StatelessWidget {
  const InvitationPage({super.key});

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 700;
    // const backgroundColor = Color(0xFFFFF7EE);
    const backgroundColor = Color(0xFFFCF9F5);
    const textColor = Color(0xFF6D4922);
    const buttonColor = Color(0xFFC49A6C);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 60),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40),
                  // Animated Title
                  AnimatedTextKit(
                    animatedTexts: [
                      // BounceAnimatedText(text)
                      BounceAnimatedText(
                        'Marriage & Reception Invitation',
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          fontSize: isMobile ? 28 : 42,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          letterSpacing: 1.2,
                        ),
                        duration: const Duration(seconds: 3),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),

                  const SizedBox(height: 30),

                  // Intro text
                  Text(
                    'With immense joy, we cordially invite you and your family to join us in celebrating the marriage and walima (reception) of',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: isMobile ? 16 : 20, color: textColor.withOpacity(0.8), height: 1.5),
                  ).animate().fadeIn(duration: 900.ms).moveY(begin: 20),

                  const SizedBox(height: 40),

                  // Names section
                  Column(
                    children: [
                      Text(
                        'Shinas Najeer Koya',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: isMobile ? 28 : 38, fontWeight: FontWeight.w700, color: textColor),
                      ),
                      Text(
                        '&',
                        style: TextStyle(
                          fontSize: isMobile ? 26 : 34,
                          fontWeight: FontWeight.w500,
                          color: textColor.withOpacity(0.7),
                        ),
                      ),
                      Text(
                        'Nazreena',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: isMobile ? 28 : 38, fontWeight: FontWeight.w700, color: textColor),
                      ),
                    ],
                  ).animate().fadeIn(duration: 1200.ms).scale(begin: const Offset(0.9, 0.9)),

                  const SizedBox(height: 50),

                  // Event sections
                  EventCard(
                    title: 'Marriage Ceremony',
                    locationName: 'Vinayaka Mangalya Mandir, \nKonandur, Thirthahalli',
                    time: '11:30 AM',
                    date: ' 28 Dec 2025 (Sunday)',
                    buttonLabel: 'Marriage Hall Location',
                    onPressed: () => _openUrl('https://maps.app.goo.gl/pUgpnUgtLaNsjS32A'),
                    textColor: textColor,
                    buttonColor: buttonColor,
                    isMobile: isMobile,
                  ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1),

                  const SizedBox(height: 30),

                  EventCard(
                    title: 'Walima (Reception)',
                    locationName: 'Koya Manzil, Brahmavara',
                    time: '12:30 PM',
                    date: ' 29 Dec 2025 (Monday)',
                    buttonLabel: 'Reception Venue Location',
                    onPressed: () => _openUrl('https://maps.app.goo.gl/6gTT7FZVTyDL1yon7'),
                    textColor: textColor,
                    buttonColor: buttonColor,
                    isMobile: isMobile,
                  ).animate().fadeIn(duration: 1000.ms).slideX(begin: 0.1),

                  const SizedBox(height: 60),

                  // Closing note
                  Text(
                    'Your dua is the best presence.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: textColor.withOpacity(0.7),
                      fontSize: isMobile ? 16 : 18,
                    ),
                  ).animate().fadeIn(duration: 1000.ms).scale(begin: const Offset(0.95, 0.95)),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String locationName;
  final String time;
  final String date;
  final String buttonLabel;
  final VoidCallback onPressed;
  final Color textColor;
  final Color buttonColor;
  final bool isMobile;

  const EventCard({
    super.key,
    required this.title,
    required this.locationName,
    required this.time,
    required this.date,
    required this.buttonLabel,
    required this.onPressed,
    required this.textColor,
    required this.buttonColor,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey.shade100,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,

      onTap: onPressed,
      child: Center(
        child: Container(
          width: isMobile ? 350 : 500,
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [BoxShadow(color: Colors.brown.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: isMobile ? 22 : 26, fontWeight: FontWeight.bold, color: textColor),
              ),
              const SizedBox(height: 12),
              Text(
                locationName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: isMobile ? 10 : 14, fontWeight: FontWeight.normal, color: textColor),
              ),
              const SizedBox(height: 16),
              Text('Date:$date', style: TextStyle(fontSize: isMobile ? 16 : 18, color: textColor.withOpacity(0.8))),
              const SizedBox(height: 12),
              Text('Time: $time', style: TextStyle(fontSize: isMobile ? 16 : 18, color: textColor.withOpacity(0.8))),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40, vertical: 10),
                decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 18),
                    // SizedBox(height: 16, width: 16, child: Image.asset('assets/images/map.png')),
                    const SizedBox(width: 4),
                    Text(
                      buttonLabel,
                      style: TextStyle(fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
