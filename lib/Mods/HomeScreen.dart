import 'dart:math';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var P=0.0, R=0.0, N=0.0, emi=0.0, emi2;
  var ip, ip2;

  var t1 = TextEditingController();
  var t2 = TextEditingController();
  var t3 = TextEditingController();

  var anim = 0;

  String But = "=";

  void output(){
    setState(() {
      if(P==0.0){
        P = double.parse(t1.text);
        R = double.parse(t2.text);
        N = double.parse(t3.text);
        R = R / (12 * 100);
        N = N * 12;
        emi = (P * R * pow(1 + R, N)) / (pow(1 + R, N) - 1);
        emi2 = emi.round();
        ip = (N * emi2) - P;
        ip2 = P + ip;
        But = "C";
        anim = 1;
      }
      else{
        t1 = TextEditingController(text: "");
        t2 = TextEditingController(text: "");
        t3 = TextEditingController(text: "");
        P = 0.0;
        R = 0.0;
        N = 0.0;
        emi = 0.0;
        emi2 = 0;
        ip = 0.0;
        ip2 = 0.0;
        But = "=";
        anim = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "EMI CALCULATOR",
            style: TextStyle(
                fontWeight: FontWeight.w400
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        centerTitle: true,
        toolbarHeight: 105,
      ),
      body: AnimatedContainer(
        duration: Duration(seconds: 5),
        child: ListView(
          children:[ Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(height: 15,),
                //These are the three input fields

                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter the Principal",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.attach_money_outlined)
                  ),
                  controller: t1,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter the Rate of Interest",
                    hintText: "0.0",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.percent_outlined)
                  ),
                  controller: t2,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Enter the Time",
                    hintText: "In Years",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.access_time)
                  ),
                  controller: t3,
                ),



                SizedBox(height: 55.0,),
                AnimatedContainer(
                   padding: EdgeInsets.fromLTRB(anim==0?38:50, anim==0?20:9, anim==0?38:50, anim==0?20:9),
                   duration: Duration(seconds: 2),
                   curve: Curves.fastOutSlowIn,
                   decoration: BoxDecoration(
                     border: Border.all(width: 1, color: Colors.transparent),
                     borderRadius: BorderRadius.all(Radius.circular(15)),
                     gradient: LinearGradient(
                       colors: [
                         anim==0 ? Colors.blue: Color.fromARGB(255, 15, 189, 196),
                         anim==0 ? Colors.lightBlueAccent: Color.fromARGB(255, 129, 192, 225),
                       ]
                     ),
                   ),
                   child: Text(
                     "Monthly EMI - $emi2",
                     style: TextStyle(
                         fontWeight: FontWeight.w400,
                         letterSpacing: 3.0,
                         fontSize: 15
                      ),
                   ),
                ),
                Divider(
                  height: 75.0,
                  thickness: 1.5,
                  color: Colors.blue,                      //This is the Divider
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "LOAN SUMMARY",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 3.0,
                            fontSize: 10,
                            color: Colors.grey
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 30.0,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Loan Amount - $P",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 3.0,
                            fontSize: 15,
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 10.0,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Interest Payable - $ip",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          letterSpacing: 3.0,
                          fontSize: 15,
                        ),
                      ),
                    ]
                ),
                SizedBox(height: 10.0,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Total Payable - $ip2",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          letterSpacing: 3.0,
                          fontSize: 15,
                        ),
                      ),
                    ]
                ),
              ],
            ),
          ),]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { output(); },
        child: Text(
            "$But",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16
            ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}