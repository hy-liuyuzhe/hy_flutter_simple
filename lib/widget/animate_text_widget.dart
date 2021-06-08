import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hy_flutter_simple/widget/base_stateless_widget.dart';

class AnimateTextWidget extends StatefulWidget {
  @override
  _AnimateTextWidgetState createState() => _AnimateTextWidgetState();
}

class _AnimateTextWidgetState extends State<AnimateTextWidget> {
  late List<AnimatedTextExample> _examples;
  int _index = 0;

  int _tapCount = 0;

  @override
  void initState() {
    super.initState();
    _examples = animatedTextExamples(onTap: () {
      print("tap event");
      setState(() {
        _tapCount++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var textExample = _examples[_index];
    return Scaffold(
      appBar: AppBar(title: Text(textExample.label)),
      body: Column(
        children: [
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(color: textExample.color),
            width: 300,
            height: 300,
            child: Center(
              key: ValueKey(textExample.label),
              child: textExample.child,
            ),
          ),
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text("taps: $_tapCount"),
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "next",
        onPressed: () {
          setState(() {
            _index = ++_index % _examples.length;
            _tapCount = 0;
          });
        },
        child: Icon(
          Icons.play_circle_filled,
          size: 50,
        ),
      ),
    );
  }
}

List<AnimatedTextExample> animatedTextExamples({required VoidCallback onTap}) {
  return [
    rotateAnimatedTextExample(onTap),
    fadeAnimatedTextExample(onTap),
    typerAnimatedTextExample(onTap),
    combinationAnimatedTextExample(onTap)
  ];
}

AnimatedTextExample combinationAnimatedTextExample(VoidCallback onTap) => AnimatedTextExample(
    label: 'Combination',
    color: Colors.pink,
    child: AnimatedTextKit(
      animatedTexts: [
        WavyAnimatedText(
          'On Your Marks',
          textStyle: const TextStyle(
            fontSize: 24.0,
          ),
        ),
        FadeAnimatedText(
          'Get Set',
          textStyle: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        ScaleAnimatedText(
          'Ready',
          textStyle: const TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        RotateAnimatedText(
          'Go!',
          textStyle: const TextStyle(
            fontSize: 64.0,
          ),
          rotateOut: false,
          duration: const Duration(milliseconds: 400),
        )
      ],
    ));

typerAnimatedTextExample(VoidCallback onTap) => AnimatedTextExample(
    label: 'Typer',
    color: Colors.lightGreen.shade800,
    child: DefaultTextStyle(
      style: TextStyle( fontSize: 30.0,
        fontFamily: 'Bobbers',),
      child: AnimatedTextKit(
        onTap: onTap,
        animatedTexts: [
          TyperAnimatedText('It is not enough to do your best,'),
          TyperAnimatedText('you must know what to do,'),
          TyperAnimatedText('and then do your best'),
          TyperAnimatedText('- W.Edwards Deming'),
        ],
      ),
    ));

fadeAnimatedTextExample(VoidCallback onTap) => AnimatedTextExample(
    label: 'Fade',
    color: Colors.brown.shade600,
    child: DefaultTextStyle(
      style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      child: AnimatedTextKit(
        animatedTexts: [
          FadeAnimatedText('do IT!'),
          FadeAnimatedText('do it RIGHT!!'),
          FadeAnimatedText('do it RIGHT NOW!!!'),
        ],
        onTap: onTap,
      ),
    ));

AnimatedTextExample rotateAnimatedTextExample(VoidCallback onTap) {
  return AnimatedTextExample(
      label: 'Rotate',
      color: Colors.orange.shade100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 100,
              ),
              const Text(
                'Be',
                style: TextStyle(fontSize: 43),
              ),
              SizedBox(
                width: 20,
                height: 100,
              ),
              DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Horizon',
                  ),
                  child: AnimatedTextKit(
                    isRepeatingAnimation: true,
                    totalRepeatCount: 10,
                    animatedTexts: [
                      RotateAnimatedText('AWESOME'),
                      RotateAnimatedText('OPTIMISTIC'),
                      RotateAnimatedText('DIFFERENT',
                          textStyle: const TextStyle(
                            decoration: TextDecoration.underline,
                          ))
                    ],
                    onTap: onTap,
                  ))
            ],
          )
        ],
      ));
}

class AnimatedTextExample {
  final label;
  final color;
  final child;

  AnimatedTextExample({
    required this.label,
    required this.color,
    required this.child,
  });
}

const _colorizeTextStyle = TextStyle(fontSize: 50, fontFamily: 'Horizon');

const _colorizeColor = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];
