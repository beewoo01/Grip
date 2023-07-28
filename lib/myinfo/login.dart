import 'package:flutter/material.dart';


class Login extends StatefulWidget {


  @override
  State createState() => LoginState();
}

class LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            buildDivider(),
            Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: buildLoginTitle(),)
          ],
        ),
      ),
    );
  }

  Widget buildLoginTitle() {
    return Column(
      children: [
        Text('LOGIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
        Text('로그인', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),)
      ],
    );
  }

  Divider buildDivider() {
    return Divider(thickness: 1, height: 1,);
  }

}