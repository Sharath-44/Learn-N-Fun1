import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnnfun/commonPages/completedPage.dart';
import 'package:learnnfun/widgets.dart';

class QuizIntro extends StatefulWidget {
  @override
  _QuizIntro createState() => _QuizIntro();
}

class _QuizIntro extends State<QuizIntro> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xfff4f4f4),
        body: SafeArea(

            //child: Center(
              child: Column(children: [
                //Image.asset("assets/revisionQuiz.png"),
                // heading
                Align(
                  alignment: Alignment.centerRight,
                  child: Stack(children: [
                    Container(
                            height: height * 0.05,
                            width: width * 0.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                      color: const Color(0x6616697a),
                                      offset: Offset(-4, 8),
                                      blurRadius: 10,
                                      spreadRadius: 0)
                                ],
                                color: const Color(0xffffffff)),
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: width * 0.05, top: height * 0.03),
                              child: Text(
                                "Catch the Nuts",
                                style: GoogleFonts.quicksand(
                                    color: const Color(0xff000000),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    fontSize: height * 0.012),
                              ),
                            )),
                  Container(
                          height: height * 0.05,
                          width: width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              boxShadow: [
                                BoxShadow(
                                    color: const Color(0xb216697a),
                                    offset: Offset(-4, 4),
                                    blurRadius: 8,
                                    spreadRadius: 0)
                              ],
                              color: const Color(0xff16697a)),
                          child: Padding(
                            padding:
                            EdgeInsets.only(left: width * 0.05, top: height * 0.005),
                            child: Text(
                              "Revision",
                              style: GoogleFonts.quicksand(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  fontSize: height * 0.03),
                            ),
                          )),
                  ],),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.1, bottom: height * 0.1),
                    child: whiteScreen(context,
                        height: height * 0.45,
                        padding: 14,
                        children: [
                          Text("Catch the Correct Nuts",
                            style: GoogleFonts.quicksand(
                                color: const Color(0xffffa62b),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                fontSize: height * 0.05),
                          ),
                          Text(
                            "Match the following",
                            style: GoogleFonts.quicksand(
                                color: const Color(0xff16697a),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: height * 0.025),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Move the Squirrel to catch the correct answers!\n"
                                "Catch all the correct answers to finish the game.",
                            style: GoogleFonts.quicksand(
                                color: const Color(0xff1a1b41),
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                fontSize: height * 0.025),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                  ),
                ),
                button(context,
                    text: "Let's Play!",
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TaskCompleted(
                              isTask: true,
                            ),
                            settings: RouteSettings(name: 'Actual game'))))
              ]),
            ));
  }
}
