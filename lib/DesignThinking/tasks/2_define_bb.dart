import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnnfun/DesignThinking/commonPages/informationCard.dart';

import 'package:learnnfun/auth.dart';
import '../Persona.dart';

class Basketball extends StatefulWidget {
  @override
  _BasketballState createState() => _BasketballState();
}

class _BasketballState extends State<Basketball> {
  get currentPersona =>
      currentProgress.playingLevel2 ? currentPersonaL2 : currentPersonaL1;
  get score => currentProgress.playingLevel2 ? l2Score : l1Score;
  int hoopsLeft = currentProgress.playingLevel2
      ? currentPersonaL2.likeChoices.length
      : currentPersonaL1.likeChoices.length;

  int points = 0;

  void checkHoop(bool left) {
    ///Left is whether the left hoop is activated.
    /// If the left hoop is activated, need to check if first is correct, otherwise last
    if (left &&
            currentPersona
                    .likeChoices[currentPersona.likeChoices.length - hoopsLeft][
                currentPersona
                    .likeChoices[currentPersona.likeChoices.length - hoopsLeft]
                    .keys
                    .first] ||
        !left &&
            currentPersona
                    .likeChoices[currentPersona.likeChoices.length - hoopsLeft][
                currentPersona
                    .likeChoices[currentPersona.likeChoices.length - hoopsLeft]
                    .keys
                    .last]) points++;
    if (hoopsLeft == 1) {
      score.task[2] = points;
      if (currentProgress.playingLevel2) {
        userDocReference.update({
          "rewards": FieldValue.increment(points),
          "taskUnlocked": 11,
          "L2T2": points
        });
        currentProgress.taskUnlocked = 11;
        currentProgress.rewards += points;
      } else {
        userDocReference.update({
          "rewards": FieldValue.increment(points),
          "taskUnlocked": 3,
          "L1T2": points
        });
        currentProgress.taskUnlocked = 3;
        currentProgress.rewards += points;
      }

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InformationCard(cardNumber: 1),
              settings: RouteSettings(name: 'Actual game')));
    } else {
      setState(() {
        hoopsLeft--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        body: SafeArea(
            child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Open Sans | 10px All
              Padding(
                padding: EdgeInsets.only(left: width * 0.06),
                child: Text("Hoops left - $hoopsLeft",
                    style: GoogleFonts.signika(
                        color: const Color(0xff9c27b0),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: height * 0.03),
                    textAlign: TextAlign.left),
              ),
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context))
            ],
          ),
          SizedBox(height: height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Open Sans | 10px All

              Column(
                children: [
                  Text(
                      currentPersona
                          .likeChoices[
                              currentPersona.likeChoices.length - hoopsLeft]
                          .keys
                          .first,
                      style: GoogleFonts.signika(
                          color: const Color(0xff9c27b0),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: height * 0.03),
                      textAlign: TextAlign.center),
                  DragTarget<bool>(
                      onWillAccept: (data) => true,
                      onAccept: (data) {
                        checkHoop(true);
                      },
                      builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return Hoop(height: height, width: width);
                      }),
                ],
              ),
              Column(
                children: [
                  Text(
                      currentPersona
                          .likeChoices[
                              currentPersona.likeChoices.length - hoopsLeft]
                          .keys
                          .last,
                      style: GoogleFonts.signika(
                          color: Color(0xff9c27b0),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          fontSize: height * 0.03),
                      textAlign: TextAlign.center),
                  DragTarget<bool>(
                    onWillAccept: (data) => true,
                    onAccept: (data) {
                      checkHoop(false);
                    },
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return Hoop(height: height, width: width);
                    },
                  )
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.1),
            child: Text(
              "Drag to Shoot",
              style: GoogleFonts.signika(
                  color: const Color(0xffa689e1),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: height * 0.03),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: height * 0.08,
                  child: SvgPicture.asset("assets/basketball/arrow.svg")),
              Container(
                height: height * 0.08,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(pi),
                  child: SvgPicture.asset("assets/basketball/arrow.svg"),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.25, right: width * 0.25),
            child: Draggable(
              data: true,
              childWhenDragging: Container(),
              feedback: Container(
                height: height * 0.2,
                width: width * 0.4,
                child: SvgPicture.asset("assets/basketball/basketball.svg"),
              ),
              child: Container(
                height: height * 0.2,
                width: width * 0.4,
                child: SvgPicture.asset("assets/basketball/basketball.svg"),
              ),
            ),
          )
        ])));
  }
}

class Hoop extends StatelessWidget {
  const Hoop({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height * 0.2,
        width: width * 0.4,
        child: SvgPicture.asset("assets/basketball/hoop.svg"));
  }
}
