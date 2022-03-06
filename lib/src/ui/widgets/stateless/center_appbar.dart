import 'package:flutter/material.dart';
import 'package:mybook_flutter/src/ui/themes/colors.dart';

class CenterAppBar extends StatelessWidget {
  String title;
  CenterAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        AppColors.primary, 
        AppColors.secondary
      ]
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 4, right: 4),
      child: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.primary),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (){},
            )
        ],
        title: ShaderMask(
          shaderCallback: (Rect rect) => linearGradient,
          child: Text(
            title, 
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white))),
      ),
    );
  }
}
