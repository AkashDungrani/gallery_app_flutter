import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/models/globals.dart';
import 'package:gallery_app/models/image_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/api_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController serchcategorycontroller = TextEditingController();
  late Future<List<Photos>?> getdata;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata = ApiHelper.apiHelper.fetchimage();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: (Globals.isdark==true)? Colors.black:Colors.white,
      appBar: AppBar(
        title: Text("Gallery App"),
        backgroundColor:(Globals.isdark==true)? Colors.black:Colors.grey,
        actions: [
          Switch(
            inactiveTrackColor: Colors.black,
            activeColor: Colors.white,
              value: Globals.isdark,
              onChanged: (value) {
                setState(() {
                  Globals.isdark = value;
                });
              })
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              flex: 0,
              child: Row(children: [
                Expanded(
                  flex: 10,
                  child: TextFormField(
                    style: TextStyle(
                        color: (Globals.isdark == true)
                            ? Colors.grey
                            : Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    controller: serchcategorycontroller,
                    decoration: InputDecoration(
                      enabled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      hintText: "Search Category",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: (Globals.isdark==true)? Colors.black12:Colors.grey.shade100,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      String category = serchcategorycontroller.text;
                      setState(() {
                        getdata =
                            ApiHelper.apiHelper.fetchimage(category: category);
                      });
                    },
                    child: Container(
                        height: 56,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: (Globals.isdark == true)
                              ? Colors.white30
                              : Colors.black38,
                        ),
                        child: Icon(
                          CupertinoIcons.search,
                          color: (Globals.isdark==true)? Colors.white:Colors.black,
                        )),
                  ),
                )
              ]),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: (Globals.isdark == true) ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    ...Categories.map((e) => Column(children: [
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              String category = e["name"];
                              setState(() {
                                getdata = ApiHelper.apiHelper
                                    .fetchimage(category: category);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 5,left: 5),
                              height: 70,
                              width: 100,
                              decoration: BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //       blurRadius: 1,
                                //       spreadRadius: 1,
                                //       blurStyle: BlurStyle.outer,
                                //       color: Colors.grey),
                                // ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    e["image"],
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          Text(
                            e["name"],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: (Globals.isdark == true)
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        ])).toList(),
                  ]),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                flex: 10,
                child: Center(
                    child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                    future: getdata,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error:${snapshot.error}");
                      } else if (snapshot.hasData) {
                        List<Photos>? data = snapshot.data;
                        return Container(
                          height: height * 0.5,
                          child: MasonryGridView.builder(
                            padding: EdgeInsets.all(10),
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            physics: BouncingScrollPhysics(),
                            itemCount: data!.length,
                            gridDelegate:
                                SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, "image_view",
                                      arguments: data[i]);
                                },
                                child: Hero(
                                  tag: data[i].preview,
                                  child: Container(
                                    height:
                                        data[i].preheight.toDouble() + 100,
                                    width: data[i].prewidth.toDouble(),
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 1,
                                              spreadRadius: 2,
                                              blurStyle: BlurStyle.outer,
                                              color: Colors.white),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(data[i].largeimage,
                                          fit: BoxFit.fill,
                                          height: height * 0.14),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                )))
          ],
        ),
      ),
    );
  }
}
