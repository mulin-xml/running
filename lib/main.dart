import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameList = ['张晓媚', '翁金祖', '张勋', '陈蒋睿', '崔浩', '徐沐霖', '王宇成', '杨敬', '夏玉娇', '蔡菀頔'];
  final _numList = List.generate(10, (index) => index);
  final _stepList = List.generate(10, (index) => Random().nextInt(5000) + 10000);

  @override
  Widget build(BuildContext context) {
    _numList.shuffle();
    _stepList.sort();
    return Scaffold(
      backgroundColor: const Color(0xffebebeb),
      appBar: AppBar(backgroundColor: const Color(0xffebebeb), toolbarHeight: 0, elevation: 0),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(10),
          // color: Colors.green,
          height: 50,
          alignment: Alignment.center,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: const [
              Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Icon(Icons.home_outlined)),
              Text('新业务算法组', style: TextStyle(fontSize: 18)),
            ]),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)), backgroundColor: const Color(0xfff7f7f7), elevation: 0),
              child: Row(children: const [
                Icon(CupertinoIcons.ellipsis, color: Colors.black),
                SizedBox(height: 20, child: VerticalDivider(thickness: 0.5)),
                Icon(Icons.mode_standby, color: Colors.black),
              ]),
            ),
          ]),
        ),
        Expanded(
          child: Scrollbar(
            child: ListView(padding: const EdgeInsets.symmetric(horizontal: 30), children: [
              const SizedBox(height: 45),
              SizedBox(
                height: 44,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Row(children: [
                    const VerticalDivider(
                      thickness: 4,
                      color: Colors.black,
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
                      Text('步数排行榜', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
                      Text('每晚10点截止排名'),
                    ])
                  ]),
                  Row(children: const [
                    Icon(Icons.offline_pin, color: Color(0xfff9961f), size: 15),
                    Text('发起新挑战', style: TextStyle(color: Color(0xfff9961f), fontSize: 13)),
                  ])
                ]),
              ),
              const SizedBox(height: 45),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Colors.white),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 11,
                  itemBuilder: (context, index) {
                    return index < 10 ? Box(index, _numList[index], _nameList[_numList[index]], _stepList[9 - index]) : Container(height: 100);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(thickness: 1, height: 0, indent: 30, endIndent: 30);
                  },
                ),
              )
            ]),
          ),
        ),
      ]),
    );
  }
}

class Box extends StatelessWidget {
  const Box(this.i, this.ii, this.name, this.step, {super.key});

  final int i;
  final int ii;
  final String name;
  final int step;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ii == 5 ? const Color(0xfff8f8f8) : null,
      padding: const EdgeInsets.fromLTRB(30, 14, 30, 14),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          SizedBox(
            width: 20,
            child: Text('${i + 1}', style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16)),
          ),
          Container(
            height: 36,
            width: 36,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Image.asset('images/$ii.jpg'),
          ),
          const SizedBox(width: 12),
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontSize: 16)),
            Visibility(
              visible: i == 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(4, 1, 4, 1),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: const Color(0xfff69222)),
                child: const Text('今日冠军', style: TextStyle(fontSize: 8.5, color: Colors.white)),
              ),
            ),
          ]),
        ]),
        Text(
          '$step',
          style: const TextStyle(
            fontSize: 26,
            color: Color(0xfff09626),
            fontFeatures: [FontFeature.tabularFigures()],
            letterSpacing: -1.7,
            // fontWeight: FontWeight.w500,
          ),
        ),
      ]),
    );
  }
}
