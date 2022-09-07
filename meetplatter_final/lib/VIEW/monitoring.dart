import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:meetplatter_final/VIEW/log_display.dart';
import 'package:meetplatter_final/json/sensor_data.dart';
import 'package:dio/dio.dart';
import 'package:icon_decoration/icon_decoration.dart';

Future<dynamic> getSensorData() async {
  Dio dio = Dio();
  var response = await dio.get("http://192.168.123.181:9090/");
  return response.data;
}

const double kDefaultPadding = 20.0;
const kPrimaryColor = Color(0xFF0C9869);

class MonitoringPage extends StatefulWidget {
  const MonitoringPage({super.key});

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();
}

class _MonitoringPageState extends State<MonitoringPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: getSensorData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: const CircularProgressIndicator(),
            );
          } else {
            var results = Sensor.fromJson(snapshot.data);
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  title: const Text('Monitoring & Control'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const LoggingDisplay()));
                        },
                        icon: const Icon(Icons.work_history))
                  ],
                ),
                body: LiquidSwipe(enableLoop: false, pages: [
                  Container(
                    color: Colors.white,
                    height: size.height,
                    child: ContainedTabBarView(
                      tabs: const [
                        DecoratedIcon(
                          icon: Icon(Icons.co2, color: Colors.green, size: 60),
                          decoration: IconDecoration(shadows: [
                            Shadow(
                                blurRadius: 2,
                                offset: Offset(2, 0),
                                color: Colors.grey)
                          ]),
                        ),
                        DecoratedIcon(
                          icon: Icon(Icons.thermostat,
                              color: Colors.lightGreen, size: 50),
                          decoration: IconDecoration(shadows: [
                            Shadow(
                                blurRadius: 2,
                                offset: Offset(2, 0),
                                color: Colors.grey)
                          ]),
                        ),
                        DecoratedIcon(
                          icon: Icon(Icons.sunny, color: Colors.lime, size: 50),
                          decoration: IconDecoration(shadows: [
                            Shadow(
                                blurRadius: 2,
                                offset: Offset(2, 0),
                                color: Colors.grey)
                          ]),
                        ),
                      ],
                      tabBarProperties: TabBarProperties(
                        height: size.height * 0.15,
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
                          color: Colors.green[100],
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: size.height * 0.9,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          200, 34, 139, 34),
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
                                                                '${results.AirCO2} ppm',
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
                                                                  '${results.AirCO2} ppm',
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
                          color: Colors.green[100],
                          child: Container(
                            margin: const EdgeInsets.all(kDefaultPadding),
                            height: size.height * 0.9,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(200, 34, 139, 34),
                                borderRadius: BorderRadius.circular(
                                    kDefaultPadding * 1.5)),
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
                                            color: Color.fromARGB(
                                                255, 85, 107, 47),
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
                                    height: size.height * 0.25,
                                    elevation: 6,
                                    color:
                                        const Color.fromARGB(255, 46, 139, 87),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(kDefaultPadding)),
                                    child: Column(
                                      children: [
                                        Flexible(
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
                                                  '현재온도 : ${results.AirTemp} 도\n현재습도 : ${results.AirHumidity} %',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  minFontSize:
                                                      kDefaultPadding * 1.5,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 85, 107, 47),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Positioned(
                                                  bottom: kDefaultPadding / 4,
                                                  left: 0,
                                                  right: 0,
                                                  child: AutoSizeText(
                                                    '현재온도 : ${results.AirTemp} 도\n현재습도 : ${results.AirHumidity} %',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    minFontSize:
                                                        kDefaultPadding * 1.5,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
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
                                                backgroundColor:
                                                    Colors.redAccent,
                                                shadowColor:
                                                    const Color.fromARGB(
                                                        255, 85, 107, 47),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kDefaultPadding))),
                                            onPressed: () {
                                              heating();
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
                                                backgroundColor:
                                                    Colors.blueAccent,
                                                shadowColor:
                                                    const Color.fromARGB(
                                                        255, 85, 107, 47),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            kDefaultPadding))),
                                            onPressed: () {
                                              cooling();
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
                        ),
                        Container(
                          color: Colors.green[100],
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: size.height * 0.9,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          200, 34, 139, 34),
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
                                                      '광량',
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
                                                        '광량',
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
                                                                '${results.Lux} lux',
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
                                                                  '${results.Lux} lux',
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
                      ],
                    ),
                  ),

//2page
                  Container(
                    color: Colors.white,
                    height: size.height,
                    child: ContainedTabBarView(
                      tabs: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Stack(
                            children: const [
                              Text(
                                '이온농도\n(pH)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const DecoratedIcon(
                          icon: Icon(Icons.thermostat,
                              color: Colors.blue, size: 50),
                          decoration: IconDecoration(shadows: [
                            Shadow(
                                blurRadius: 2,
                                offset: Offset(2, 0),
                                color: Colors.grey)
                          ]),
                        ),
                        const DecoratedIcon(
                          icon: Icon(Icons.water,
                              color: Colors.lightBlueAccent, size: 50),
                          decoration: IconDecoration(shadows: [
                            Shadow(
                                blurRadius: 2,
                                offset: Offset(2, 0),
                                color: Colors.grey)
                          ]),
                        ),
                      ],
                      tabBarProperties: TabBarProperties(
                        height: size.height * 0.15,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32.0,
                          vertical: 8.0,
                        ),
                        indicator: ContainerTabIndicator(
                          padding:
                              const EdgeInsets.only(top: kDefaultPadding * 1.5),
                          height: 10,
                          width: 10,
                          radius: BorderRadius.circular(100),
                          color: Colors.blue,
                          borderWidth: 2.0,
                          borderColor: Colors.blue,
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor:
                            const Color.fromARGB(255, 137, 143, 135),
                      ),
                      views: [
                        Container(
                          color: Colors.blue[100],
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: size.height * 0.9,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          200, 30, 144, 255),
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
                                                      '이온농도(pH)',
                                                      maxLines: 1,
                                                      minFontSize: 20 * 1.5,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 25, 25, 112),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Positioned(
                                                      bottom: 20 / 4,
                                                      left: 0,
                                                      right: 0,
                                                      child: AutoSizeText(
                                                        '이온농도(pH)',
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
                                                      180, 34, 34, 139),
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
                                                                '${results.pH} pH',
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
                                                                            25,
                                                                            25,
                                                                            112),
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
                                                                  '${results.pH} pH',
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
                          color: Colors.blue[100],
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: size.height * 0.9,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          200, 30, 144, 255),
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
                                                      '담액 온도',
                                                      maxLines: 1,
                                                      minFontSize: 20 * 1.5,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 25, 25, 112),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Positioned(
                                                      bottom: 20 / 4,
                                                      left: 0,
                                                      right: 0,
                                                      child: AutoSizeText(
                                                        '담액 온도',
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
                                                      180, 34, 34, 139),
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
                                                                '${results.WaterTemp} 도',
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
                                                                            25,
                                                                            25,
                                                                            112),
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
                                                                  '${results.WaterTemp} 도',
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
                          color: Colors.blue[100],
                          child: Column(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: size.height * 0.9,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          200, 30, 144, 255),
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
                                                      '수위',
                                                      maxLines: 1,
                                                      minFontSize: 20 * 1.5,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 25, 25, 112),
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Positioned(
                                                      bottom: 20 / 4,
                                                      left: 0,
                                                      right: 0,
                                                      child: AutoSizeText(
                                                        '수위',
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
                                                      180, 34, 34, 139),
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
                                                                '${results.WaterLevel} cm',
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
                                                                            25,
                                                                            25,
                                                                            112),
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
                                                                  '${results.WaterLevel} cm',
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
                      ],
                    ),
                  ),
                ]));
          }
        });
  }

  void heating() {
    String order = 'heat';
    Dio dio = Dio();
    dio.post("http://192.168.123.181:9090/motor_control", data: order);
  }

  void cooling() {
    String order = 'cool';
    Dio dio = Dio();
    dio.post("http://192.168.123.181:9090/motor_control", data: order);
  }
}
