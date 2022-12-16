import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_project/models/onboarding_model.dart';

import 'menu_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: contens.length,
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(65),
                  child: Column(
                    children: [
                      Image.asset(
                        contens[i].image,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        contens[i].title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        contens[i].description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: contens.asMap().entries.map((entry) {
              return GestureDetector(
                child: Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.blue)
                        .withOpacity(currentIndex == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MenuPage(),
                ),
              );
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all(
                const Size(300, 40),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            child: Text(
              "Get Started",
              style: GoogleFonts.urbanist(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
