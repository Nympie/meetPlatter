import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class MonitoringPage extends StatefulWidget {
  MonitoringPage({super.key, });
  //
  // final String _Bright = 10.toString();
  // final String _Thermo = 10.toString();
  // final String _Humi = 10.toString();
  // final String Co2 = 10.toString();

  // late String _Co2_str = '';
  // late String _Humi_str = '';
  // late String _Thermo_str = '';
  // late String _Bright_str = '';

  @override
  State<MonitoringPage> createState() => _MonitoringPageState();

}


class _MonitoringPageState extends State<MonitoringPage> {

  final String _Co2 = 10.toString();
  final String _Bright = 10.toString();
  final String _Thermo = 10.toString();
  final String _Humi = 10.toString();
  final String _pH = 10.toString();
  final String _Water_Thermo = 10.toString();
  final String _Water_Cm = 10.toString();

  @override
  Widget build(BuildContext context) {
    final page = [
      Container(color: Colors.white,
        height: 650,
        child: ContainedTabBarView(
          tabs: [
            Container(
              decoration:const BoxDecoration(
                color: Colors.white,
              ),
              child: const Icon(Icons.co2,
              size: 50,
              color: Colors.grey,),
            ),
            const Icon(Icons.thermostat,
            size: 50,
            color: Colors.grey,),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const Icon(Icons.sunny,
              size: 50,
              color: Colors.grey),
            )
          ],
          tabBarProperties: TabBarProperties(
            height: 100.0, // 탭 바 세로 길이
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
            unselectedLabelColor: Colors.grey[400],
          ),
          views: [
            Container(
              color:const Color.fromARGB(180, 34,139,34),
              child: Column(
              children: [
                Container(
                  padding : const EdgeInsets.only(top: 50, bottom: 30),

                  child: Stack(
                    children: const [
                      Text('Co2 농도',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromARGB(255,85,107,47),
                          fontSize:40,
                          fontWeight: FontWeight.bold),),

                    Positioned(
                      bottom: 5,
                        left: 0,
                        right: 0,
                        child:
                        Text('Co2 농도',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:40,
                              fontWeight: FontWeight.bold),),)
                    ]
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(20),
                  height:200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255,46,139,87),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  padding:const EdgeInsets.all(70),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                            Text('$_Co2 ppm',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                            color: Color.fromARGB(255,85,107,47),
                            fontSize:40,
                            fontWeight: FontWeight.bold),),

                            Positioned(
                            bottom: 5,
                            left: 0,
                            right: 0,
                            child:
                            Text('$_Co2 ppm',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                            color: Colors.white,
                            fontSize:40,
                            fontWeight: FontWeight.bold),),)
                            ]
                      )
                    ],
                  ),
                ),
              ],
            ),),
          Container(
            color:const Color.fromARGB(180, 34,139,34),
            child: Column(
              children: [
                Container(
                  padding:const EdgeInsets.all(10),
                  child: Stack(
                    children: const [
                      Text('대기 온습도',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255,85,107,47),
                            fontSize:40,
                            fontWeight: FontWeight.bold),),

                      Positioned(
                        bottom: 3,
                        left: 0,
                        right: 0,
                        child:
                        Text('대기온습도',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:40,
                              fontWeight: FontWeight.bold),),)
                    ],
                  ),
                ),
                BlurryContainer(
                  blur: 0,
                  width: 350,
                  height: 100,
                  elevation: 6,
                  color: const Color.fromARGB(255,46,139,87),
                  padding: const EdgeInsets.all(5),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),

                  child: Stack(
                      children: [
                        Container(
                          alignment : Alignment.center,
                          child: Text('현재온도 : $_Thermo 도\n현재습도 : $_Humi %',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Color.fromARGB(255,85,107,47),
                                fontSize:31,
                                fontWeight: FontWeight.bold),),
                        ),

                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child:
                          Text('현재온도 : $_Thermo 도\n현재습도 : $_Humi %',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize:30,
                                fontWeight: FontWeight.bold),),)
                      ]
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      padding: const EdgeInsets.all(10),
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 105,105,105).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0,3)
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white, width: 3)
                      ),
                    child: const Text('목표온도',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize:30,
                            fontWeight: FontWeight.bold),),

                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary:const Color.fromARGB(255,255,99,71),
                              elevation: 10,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              )
                            ),
                            onPressed: (){},
                            child: const Text('히팅',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize:20,
                                  fontWeight: FontWeight.bold),),
                          ),
                        ),

                        SizedBox(
                          width: 150,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary:const Color.fromARGB(255,30,144,255),
                                elevation: 10,
                                shadowColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            onPressed: (){},
                            child: const Text('쿨링',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize:20,
                                  fontWeight: FontWeight.bold),),
                          ),
                        ),
                      ],
                    )
                  ],

                )
              ],
            ),),
          Container(
            color:const Color.fromARGB(180, 34,139,34),
            child: Column(
              children: [
                Container(
                  padding : const EdgeInsets.only(top: 50, bottom: 30),

                  child: Stack(
                      children: const [
                        Text('광량',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255,85,107,47),
                              fontSize:40,
                              fontWeight: FontWeight.bold),),

                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child:
                          Text('광량',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:40,
                                fontWeight: FontWeight.bold),),)
                      ]
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  height:200,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255,46,139,87),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  padding:const EdgeInsets.all(70),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Stack(
                          children: [
                            Text('$_Bright lux',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color.fromARGB(255,85,107,47),
                                  fontSize:40,
                                  fontWeight: FontWeight.bold),),

                            Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child:
                              Text('$_Bright lux',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize:40,
                                    fontWeight: FontWeight.bold),),)
                          ]
                      )
                    ],
                  ),
                ),
              ],
            ),)
        ],
          onChange: (index) => print(index),
        )),

      // 2번째 페이지
      Container(color: Colors.white,
          height: 650,
          child: ContainedTabBarView(

            tabs: [
              Container(
                decoration:const BoxDecoration(
                  color: Colors.white,
                ),
                child: Stack(
                  children: const [
                    Text('이온농도\n(pH)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  ],
                ),
              ),
              Container(
                child: const Icon(Icons.thermostat,
                  size: 50,
                  color: Colors.grey,),
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: const Icon(Icons.water,
                    size: 50,
                    color: Colors.grey),
              )
            ],
            tabBarProperties: TabBarProperties(
              height: 100.0, // 탭 바 세로 길이
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
              unselectedLabelColor: Colors.grey[400],
            ),

            views: [
              Container(
                color:const Color.fromARGB(200,30,144,255),
                child: Column(
                  children: [
                    Container(
                      padding : const EdgeInsets.only(top: 50, bottom: 30),

                      child:
                      Stack(
                          children: const [
                            Text('수소이온농도(pH)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255,25,25,112),
                                  fontSize:40,
                                  fontWeight: FontWeight.bold),),

                            Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child:
                              Text('수소이온농도(pH)',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:40,
                                    fontWeight: FontWeight.bold),),)
                          ]
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(20),
                      height:200,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(180,34,34,139),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      padding:const EdgeInsets.all(70),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Stack(
                              children: [
                                Text('$_pH pH',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255,25,25,112),
                                      fontSize:40,
                                      fontWeight: FontWeight.bold),),

                                Positioned(
                                  bottom: 5,
                                  left: 0,
                                  right: 0,
                                  child:
                                  Text('$_pH pH',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize:40,
                                        fontWeight: FontWeight.bold),),)
                              ]
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ),
              Container(color:const Color.fromARGB(200,30,144,255),
                child: Column(
                  children: [
                    Container(
                      padding : const EdgeInsets.only(top: 50, bottom: 30),

                      child: Stack(
                          children: const [
                            Text('담액 온도',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255,25,25,112),
                                  fontSize:40,
                                  fontWeight: FontWeight.bold),),

                            Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child:
                              Text('담액 온도',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:40,
                                    fontWeight: FontWeight.bold),),)
                          ]
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(20),
                      height:200,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(180,34,34,139),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      padding:const EdgeInsets.all(70),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Stack(
                              children: [
                                Text('$_Water_Thermo 도',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: const Color.fromARGB(255,25,25,112),
                                      fontSize:40,
                                      fontWeight: FontWeight.bold),),

                                Positioned(
                                  bottom: 5,
                                  left: 0,
                                  right: 0,
                                  child:
                                  Text('$_Water_Thermo 도',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize:40,
                                        fontWeight: FontWeight.bold),),)
                              ]
                          ),
                        ],
                      ),
                    ),
                  ],
                ),),
              Container(color:const Color.fromARGB(200,30,144,255),
                child: Column(
                  children: [
                    Container(
                      padding : const EdgeInsets.only(top: 50, bottom: 30),

                      child: Stack(
                          children: const [
                            Text('수위',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255,25,25,112),
                                  fontSize:40,
                                  fontWeight: FontWeight.bold),),

                            Positioned(
                              bottom: 5,
                              left: 0,
                              right: 0,
                              child:
                              Text('수위',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:40,
                                    fontWeight: FontWeight.bold),),)
                          ]
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.all(20),
                      height:200,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(180,34,34,139),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      padding:const EdgeInsets.all(70),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Stack(
                              children: [
                                Text('$_Water_Cm Cm',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255,25,25,112),
                                      fontSize:40,
                                      fontWeight: FontWeight.bold),),

                                Positioned(
                                  bottom: 5,
                                  left: 0,
                                  right: 0,
                                  child:
                                  Text('$_Water_Cm Cm',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize:40,
                                        fontWeight: FontWeight.bold),),)
                              ]
                          ),
                        ],
                      ),
                    ),
                  ],
                ),)
            ],
            onChange: (index) => print(index),
          )),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Monitoring & Control'),
      ),
      body: LiquidSwipe(
        enableLoop: false,
        pages: page,
        // slideIconWidget: Icon(Icons.arrow_back_ios),
      )
    );
  }
}

