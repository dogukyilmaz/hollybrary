import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hollybrary/utils/app_colors.dart';
import 'package:hollybrary/widgets/button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: const BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/welcome.jpg'),
        )),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                    text: 'Welcome',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\nstart your digital library',
                        style: TextStyle(
                          color: AppColors.accentColor,
                          fontSize: 14,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 3),
              const ButtonWidget(
                  bgColor: AppColors.primaryColor,
                  text: "Add Movie",
                  textColor: AppColors.accentColor)
            ]),
      ),
    );
  }
}
