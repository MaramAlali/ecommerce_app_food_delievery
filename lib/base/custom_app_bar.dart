import 'package:flutter/material.dart';
import '../widgets/big_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  //final Color? color;
  final bool backButtonExist;
  final Function? onBackPressed;

  const CustomAppBar({Key? key,
    required this.title,
    this.backButtonExist = true,
    this.onBackPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BigText(
          text: title,
          size: 25,
          color:Colors.white,
        ),
        centerTitle: true,
        backgroundColor:const Color.fromARGB(255, 206, 143, 48),
        elevation: 0,
        leading: backButtonExist ? IconButton(onPressed: () =>
        onBackPressed != null
            ? onBackPressed!()
            :  Navigator.of(context, rootNavigator: true).pushNamed("/"),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),color: const Color.fromARGB(255, 206, 143, 48),):const SizedBox(),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(500, 53);
}
