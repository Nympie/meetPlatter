import 'dart:async';
import 'dart:isolate';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:blurrycontainer/blurrycontainer.dart';


void main() {
  runApp(const MyApp());
}

const double kDefaultPadding = 20.0;
const kPrimaryColor = Color(0xFF0C9869);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final page = [
     Container(
                    color: Colors.white,
                    height: 650,
                    child: ContainedTabBarView(
                      tabs: const [
                        Icon(
                          Icons.co2,
                          size: 50,
                          color: Colors.grey,
                        ),
                        Icon(
                          Icons.thermostat,
                          size: 50,
                          color: Colors.lightBlueAccent,
                        ),
                        Icon(Icons.sunny,
                            size: 50, color: Colors.deepOrangeAccent)
                      ],
                      tabBarProperties: TabBarProperties(
                        height: 100.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 8.0,
                        ),
                        indicator: ContainerTabIndicator(
                          padding: const EdgeInsets.only(top: 30),
                          height: 10,
                          width: 10,
                          radius: BorderRadius.circular(100),
                          color: Colors.green,
                          borderWidth: 2.0,
                          borderColor: Colors.green,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor:
                            const Color.fromARGB(255, 137, 143, 135),
                      ),
                      views: [
                        Container(
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: size.height * 0.9,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 34, 139, 34),
                                      borderRadius:
                                          BorderRadius.circular(20 * 1.5)),
                                  child: Column(
                                    children: [
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(
                                                width: size.width,
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: const [
                                                    AutoSizeText(
                                                      'Co2 농도',
                                                      maxLines: 1,
                                                      minFontSize: 20 * 1.5,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 85, 107, 47),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Positioned(
                                                      bottom: 20 / 4,
                                                      left: 0,
                                                      right: 0,
                                                      child: AutoSizeText(
                                                        'Co2 농도',
                                                        maxLines: 1,
                                                        minFontSize: 20 * 1.5,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                child: BlurryContainer(
                                                  blur: 0,
                                                  width: size.width * 0.7,
                                                  height: size.height * 0.5,
                                                  elevation: 6,
                                                  color: const Color.fromARGB(
                                                      255, 46, 139, 87),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  child: Column(
                                                    children: [
                                                      Flexible(
                                                        fit: FlexFit.loose,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20,
                                                                  bottom: 20),
                                                          child: Stack(
                                                            alignment: Alignment
                                                                .center,
                                                            children: [
                                                              AutoSizeText(
                                                                '123 ppm',
                                                                maxLines: 1,
                                                                minFontSize:
                                                                    20 * 1.5,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: const TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            85,
                                                                            107,
                                                                            47),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Positioned(
                                                                bottom: 20 / 4,
                                                                left: 0,
                                                                right: 0,
                                                                child:
                                                                    AutoSizeText(
                                                                  '123 ppm',
                                                                  maxLines: 1,
                                                                  minFontSize:
                                                                      20 * 1.5,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(kDefaultPadding),
                          height: size.height * 0.9,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 34, 139, 34),
                              borderRadius:
                                  BorderRadius.circular(kDefaultPadding * 1.5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Stack(
                                  children: const [
                                    AutoSizeText(
                                      '대기 온습도',
                                      maxLines: 1,
                                      minFontSize: kDefaultPadding * 1.5,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 85, 107, 47),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Positioned(
                                      bottom: kDefaultPadding / 4,
                                      left: 0,
                                      right: 0,
                                      child: AutoSizeText(
                                        '대기 온습도',
                                        maxLines: 1,
                                        minFontSize: kDefaultPadding * 1.5,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: BlurryContainer(
                                  blur: 0,
                                  width: size.width * 0.7,
                                  height: size.height * 0.2,
                                  elevation: 6,
                                  color: const Color.fromARGB(255, 46, 139, 87),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(kDefaultPadding)),
                                  child: Flexible(
                                    fit: FlexFit.loose,
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                          top: kDefaultPadding,
                                          bottom: kDefaultPadding),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          AutoSizeText(
                                            '현재온도 : 123 도\n현재습도 : 123 %',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            minFontSize: kDefaultPadding * 1.5,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 85, 107, 47),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Positioned(
                                            bottom: kDefaultPadding / 4,
                                            left: 0,
                                            right: 0,
                                            child: AutoSizeText(
                                              '현재온도 : 123 도\n현재습도 : 123 %',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              minFontSize:
                                                  kDefaultPadding * 1.5,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  BlurryContainer(
                                    blur: 0,
                                    width: size.width * 0.7,
                                    height: size.height * 0.2,
                                    elevation: 6,
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(
                                        kDefaultPadding / 4),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(kDefaultPadding)),
                                    child: const Text(
                                      '목표온도',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.3,
                                        height: size.height * 0.1,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 10,
                                              shadowColor: const Color.fromARGB(
                                                  255, 85, 107, 47),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kDefaultPadding))),
                                          onPressed: () {
                                  
                                          },
                                          child: const Text(
                                            '히팅',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: kDefaultPadding,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: size.width * 0.3,
                                        height: size.height * 0.1,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 10,
                                              shadowColor: const Color.fromARGB(
                                                  255, 85, 107, 47),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kDefaultPadding))),
                                          onPressed: () {
                                          
                                          },
                                          child: const Text(
                                            '쿨링',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: kDefaultPadding,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: size.height * 0.9,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 34, 139, 34),
                                      borderRadius:
                                          BorderRadius.circular(20 * 1.5)),
                                  child: Flexible(
                                    fit: FlexFit.loose,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: size.width,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: const [
                                                AutoSizeText(
                                                  '광량',
                                                  maxLines: 1,
                                                  minFontSize: 20 * 1.5,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 85, 107, 47),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Positioned(
                                                  bottom: 20 / 4,
                                                  left: 0,
                                                  right: 0,
                                                  child: AutoSizeText(
                                                    '광량',
                                                    maxLines: 1,
                                                    minFontSize: 20 * 1.5,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: BlurryContainer(
                                              blur: 0,
                                              width: size.width * 0.7,
                                              height: size.height * 0.5,
                                              elevation: 6,
                                              color: const Color.fromARGB(
                                                  255, 46, 139, 87),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              child: Column(
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.loose,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20,
                                                              bottom: 20),
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          AutoSizeText(
                                                            '123 Lux',
                                                            maxLines: 1,
                                                            minFontSize:
                                                                20 * 1.5,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        85,
                                                                        107,
                                                                        47),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Positioned(
                                                            bottom: 20 / 4,
                                                            left: 0,
                                                            right: 0,
                                                            child: AutoSizeText(
                                                              '123} Lux',
                                                              maxLines: 1,
                                                              minFontSize:
                                                                  20 * 1.5,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


    

    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Monitoring'),
      ),
      body: LiquidSwipe(
        enableLoop: false,
        pages : page
      )

      ); // This trailing comma makes auto-formatting nicer for build methods.

  }
}
