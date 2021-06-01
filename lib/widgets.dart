import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StandardButton extends StatelessWidget {
  ///Gives the standard button used all throughout the application. USE THIS ONLY
  ///need to pass a variable called context and a text in double quotes in the form text:"<Button Content>"
  ///Also need to pass what should happen on click of the button to onTap in the form onTap:(){<code goes here>}
  const StandardButton({
    Key key,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.065,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xffca7602),
              blurRadius: 0.0, // soften the shadow
              spreadRadius: 1.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                2.0, // Move to bottom 10 Vertically
              ),
            )
          ],
          color: Color(0xffffa62b),
          border: Border.all(
            color: Color(0xffffa62b),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: ElevatedButton(
          child: Text(text,
              style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: height * 0.03),
              textAlign: TextAlign.left),
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(Color(0xffcb7703)),
            elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return 0;
                return 8; // Use the component's default.
              },
            ),
            minimumSize: MaterialStateProperty.all<Size>(
                Size(width * 0.6, height * 0.65)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Color(0xfaffa62b);
                return Color(0xffffa62b); // Use the component's default.
              },
            ),
          ),
          onPressed: onTap),
    );
  }
}


class WhiteScreen extends StatelessWidget {
  ///Gives a white screen with some slight elevation as is used across the entire application.
  ///You need to pass a List of widgets (Similar to what you pass into column) [Widget1,Widget2]
  ///You can also pass a padding variable if you feel you want some padding on all sides
  const WhiteScreen({
    Key key,
    @required this.height,
    this.width,
    this.padding = 0,
    this.elevation = 4,
    this.children,
  }) : super(key: key);

  final double width;
  final double height;
  final double padding;
  final double elevation ;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width==null?MediaQuery.of(context).size.width * 0.80:width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height * 0.1),
          boxShadow: [
            BoxShadow(
              color: Color(0x338b8b8b),
              blurRadius: elevation,
              offset: Offset(0, elevation),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: children),
        ));
  }
}

class StdBackButton extends StatelessWidget {
  ///Use this for the default back button. Using this as the first element of your column will make it standard everywhere
  const StdBackButton({
    Key key, this.onTap,
  }) : super(key: key);

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: IconButton(
          iconSize: 50,
          icon: Icon(Icons.chevron_left),
          onPressed: onTap==null?() => Navigator.pop(context):onTap),
    );
  }
}

