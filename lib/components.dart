import 'package:flutter/material.dart';

class button extends StatelessWidget {


  const button({required this.color,required this.title, required this.wid});
final Color color;
final String title;
final Widget wid;



  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed:() async{

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => wid
              ),

            );

          },
          minWidth: 200,
          height: 42,
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
//Navigator.push(context,   MaterialPageRoute(builder: (context) => SignInScreen()),


void onpress(
    context,
    widget,
    ) =>
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),

    );