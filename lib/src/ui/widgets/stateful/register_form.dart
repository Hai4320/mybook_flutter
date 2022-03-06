import 'package:flutter/material.dart';

import '../../../constants/app_localization.dart';
import '../../../constants/assets.dart';
import '../../themes/colors.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({ Key? key }) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
            child: Text(
              AppLocalizations.of(context).translate('REGISTER'),
              style: const TextStyle(
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
                hintText: "Enter Email Address",
                labelText: "Email", 
                border: OutlineInputBorder()
              ),
            ) 
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Enter User Name",
                labelText: "User Name", 
                border: OutlineInputBorder()
              ),
            ) 
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Enter Password",
                labelText: "Password", 
                border: OutlineInputBorder()
              ),
            ) 
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                labelText: "Confirm Password", 
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
                child: Text(AppLocalizations.of(context).translate('REGISTER'),)
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:10),
            alignment: Alignment.center,
            child: Text(
              AppLocalizations.of(context).translate('have_account'),
              style: TextStyle(
                color: AppColors.blue
              ),
              ),
          ),
          Container(
            margin: const EdgeInsets.only(top:10),
            alignment: Alignment.center,
            child: Divider(
              color: Colors.black54,
              height: 4,
              indent: widthOfForm*0.2,
              endIndent: widthOfForm*0.2,
              thickness: 1,
          ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: (){},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [//BoxShadow
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                                blurStyle: BlurStyle.outer,
                                spreadRadius: 3.0,
                              ), //BoxShadow
                            ],
                    ),
                    child: Image.asset(AppIcons.ic_google)
                    ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextButton(
                  onPressed: (){},
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [//BoxShadow
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 0.0),
                                blurRadius: 3.0,
                                blurStyle: BlurStyle.outer,
                                spreadRadius: 3.0,
                              ), //BoxShadow
                            ],
                    ),
                    child: Image.asset(AppIcons.ic_facebook)
                    ),
                ),
              )
            ],
          )
        ],
        ),
    );
  }
}