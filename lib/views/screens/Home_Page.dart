import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../providers/json_decode_provider.dart';
import '../../providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
      lowerBound: 0,
      upperBound: 2 * pi,
    );
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/gifs/BackgroundBlack.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Text(
                        "Solar System",
                        style: TextStyle(
                          fontSize: 3.h,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.all(6.w),
                            height: 18.h,
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushNamed('settings_page');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.settings, size: 4.h),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        "Settings",
                                        style: TextStyle(fontSize: 2.5.h),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context)
                                        .pushNamed('favorites_page');
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.favorite_border_rounded,
                                          size: 4.h),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Text(
                                        "Favorites",
                                        style: TextStyle(fontSize: 2.5.h),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.dehaze,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Expanded(
                flex: 18,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...List.generate(
                        Provider.of<JsonDecodeProvider>(context, listen: false)
                            .galaxyDetails
                            .length,
                            (index) => Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  'details_page',
                                  arguments: Provider.of<JsonDecodeProvider>(
                                      context,
                                      listen: false)
                                      .galaxyDetails[index],
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      animationController.repeat();
                                      setState(() {});
                                    },
                                    onDoubleTap: () {
                                      animationController.reverse(from: 2 * pi);
                                      setState(() {});
                                    },
                                    child: AnimatedBuilder(
                                      animation: animationController,
                                      child: Image.asset(
                                        Provider.of<JsonDecodeProvider>(context,
                                            listen: false)
                                            .galaxyDetails[index]
                                            .image,
                                        height: 20.h,
                                        width: 20.h,
                                      ),
                                      builder: (context, widget) {
                                        return Transform.rotate(
                                          angle: animationController.value,
                                          child: widget,
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: 20.h,
                                    width: 25.h,
                                    decoration: BoxDecoration(
                                      color:
                                      (Provider.of<ThemeProvider>(context)
                                          .themeModel
                                          .isDark)
                                          ? Colors.grey.withOpacity(0.4)
                                          : Colors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(1.h),
                                    ),
                                    padding: EdgeInsets.all(1.h),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Provider.of<JsonDecodeProvider>(
                                                  context)
                                                  .galaxyDetails[index]
                                                  .name,
                                              style: TextStyle(
                                                fontSize: 3.h,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                if (animationController
                                                    .isAnimating) {
                                                  animationController.stop();
                                                } else {
                                                  animationController.repeat();
                                                }
                                                setState(() {});
                                              },
                                              icon: (animationController
                                                  .isAnimating)
                                                  ? const Icon(Icons.stop)
                                                  : const Icon(
                                                  Icons.play_arrow),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.h,
                                        ),
                                        Text(
                                          'Radius : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].radius}',
                                          style: TextStyle(
                                            fontSize: 2.h,
                                          ),
                                        ),
                                        Text(
                                          'Velocity : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].velocity}',
                                          style: TextStyle(
                                            fontSize: 2.h,
                                          ),
                                        ),
                                        Text(
                                          'Gravity : ${Provider.of<JsonDecodeProvider>(context).galaxyDetails[index].gravity}',
                                          style: TextStyle(
                                            fontSize: 2.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}