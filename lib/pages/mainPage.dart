// ignore_for_file: file_names

import 'package:openai_image_generator/controller/imageController.dart';
import 'package:openai_image_generator/models/imageModels.dart';
import 'package:flutter/material.dart';
import 'package:openai_image_generator/filesWithImportantVariables/constants.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<ImageModels>? future;
  ImageController imageController = ImageController();
  TextEditingController textBoxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    future = null;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double systemNavigationBarHeight =
        MediaQuery.of(context).padding.bottom;
    final double systemUpperBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: screenWidth - 25.0,
                    height: 60.0,
                    child: TextField(
                      textAlign: TextAlign.left,
                      style: textStyle(17.0),
                      controller: textBoxController,
                      cursorColor: Colors.white,
                      cursorWidth: 0.8,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset(
                          'assets/icons/search_icon.png',
                          scale: 5,
                        ),
                        hintText: 'Describe your image',
                        hintStyle: textStyle(16.0),
                        filled: true,
                        fillColor: allElementsColor,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ),
                Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: screenWidth - 25.0,
                    height: screenHeight -
                        systemUpperBarHeight -
                        systemNavigationBarHeight -
                        150.0, //150.0 = paddings, text box and button heights
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: allElementsColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        // THIS BUTTON IS ONLY FOR THE NICE CLICKING ON THE CONTAINER EFFECT
                      },
                      child: Center(
                        child: FutureBuilder(
                            future: future,
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return CircularProgressIndicator(
                                    color: circularProgressIndinactorColor,
                                  );
                                case ConnectionState.done:
                                  if (snapshot.data!.error.isNotEmpty) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data!.error,
                                        style: textStyle(17.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  } else {
                                    return ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child:
                                            Image.network(snapshot.data!.url));
                                  }

                                default:
                                  return Text(
                                    '*image will appear here*',
                                    style: textStyle(15.0),
                                  );
                              }
                            }),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: FutureBuilder<ImageModels?>(
                      future: future,
                      builder: (context, snapshot) {
                        return SizedBox(
                            width: screenWidth - 25.0,
                            height: 60.0,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: allElementsColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    null;
                                  } else {
                                    setState(() {
                                      future = imageController.getImage(
                                          promt: textBoxController.text);
                                    });
                                  }
                                },
                                child: Text(
                                  'Generate Image',
                                  style: textStyle(18.0),
                                )));
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
