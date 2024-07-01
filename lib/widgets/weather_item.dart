
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WeatherItem extends StatelessWidget {

  final String text;
  final String subtext;
  final String lottie;


  const WeatherItem({super.key, required this.text, required this.subtext,  required this.lottie});



  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: MediaQuery.of(context).size.width*0.5,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset(
              lottie,
              height: 90,
              fit: BoxFit.cover,
            ),
            const SizedBox(height:10),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: text,
                    style: GoogleFonts.ubuntu(
                        fontSize: 18, color: Colors.black
                    ), children:[ TextSpan(
                    text: subtext,
                    style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold)
                )]
                ))


          ],
        ),
      ),
    );
  }
}
