import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({ Key? key }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var widthOfForm = size.width-20;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            height: 50,
            child: const Text(
              "Login",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              ),
          ),
          Divider(
            color: Colors.black54,
            height: 4,
            indent: widthOfForm*0.1,
            endIndent: widthOfForm*0.1,
            thickness: 1,
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Email",
                labelText: "Email", 
                border: OutlineInputBorder()
              ),
            ) 
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Password",
                labelText: "Password", 
                border: OutlineInputBorder()
              ),
            ) 
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: 	ElevatedButton(
              onPressed: (){},
              child: Container(
                alignment: Alignment.center,
                width: widthOfForm*0.8,
                child: Text("LOGIN")
                )
            ),
          )

        ],
        ),
    );
  }
}