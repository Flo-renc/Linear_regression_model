import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF7F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text.rich(
                    TextSpan(
                      text: 'Welcome to ', 
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF555D50)
                      ),

                      children: <TextSpan>[
                        TextSpan(
                          text: 'AIWhisper',
                          style: TextStyle(
                            fontFamily: 'KaushanScript',
                            fontSize: 32,
                            color: Color(0xFF555D50)

                          ),
                        ),
                        
                      ]
                    ),

                    
                  ),

                  const SizedBox(height: 88),

                  //login button
                  SizedBox(
                    width: 255,
                    height: 73,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/predict');
                      },
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFC08081),
                        foregroundColor: Color(0xFFEAE0C8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                      child: const Text('Get Started',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24,
                      ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 44),

                ],
              )
            ),
          ),
        )
      )
    );
  }
}
