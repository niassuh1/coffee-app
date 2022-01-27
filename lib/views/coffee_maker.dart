import 'dart:async';
import 'package:capulus/constants.dart';
import 'package:capulus/models/coffee.dart';
import 'package:capulus/widgets/splashy-button.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CoffeeMakerScreen extends StatefulWidget {
  const CoffeeMakerScreen({Key? key}) : super(key: key);

  @override
  State<CoffeeMakerScreen> createState() => _CoffeeMakerScreenState();
}

class _CoffeeMakerScreenState extends State<CoffeeMakerScreen> {
  late CountDownController _countdownController = new CountDownController();
  late Coffee _coffee = Coffee(weight: initialWeight);
  double initialWeight = 30;
  bool timerIsActive = false;
  bool timerIsPaused = true;
  int period = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.chevron_left),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                    onChanged: handleTextChange,
                    keyboardType: TextInputType.number,
                    cursorColor: Theme.of(context).primaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.coffee,
                        color: Colors.blueGrey[300],
                      ),
                      suffix: Text(
                        'g',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      border: InputBorder.none,
                      label: Text("Enter Coffee's Weight"),
                      floatingLabelStyle: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    initialValue: initialWeight.toString(),
                    onFieldSubmitted: handleTextChange,
                  ),
                ),
                const SizedBox(height: 25),
                Text(timerIsActive
                    ? 'Pour ${_coffee.getFullPours()[period].toStringAsFixed(1)} ml'
                    : _coffee.getFullPours()[0].toStringAsFixed(1)),
                const SizedBox(height: 15),
                CircularCountDownTimer(
                  autoStart: false,
                  strokeCap: StrokeCap.round,
                  controller: _countdownController,
                  width: 150,
                  height: 150,
                  duration: 45,
                  onStart: () {
                    setState(() {
                      period++;
                    });
                  },
                  onComplete: onCompleteHandle,
                  fillColor: Theme.of(context).primaryColor,
                  ringColor: Theme.of(context).primaryColor.withAlpha(100),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SplashyButton(
                        onTap: timerStartHandler,
                        color: timerIsActive
                            ? Colors.black87
                            : Theme.of(context).primaryColor,
                        child: Text(
                          timerIsActive
                              ? 'Restart'.toUpperCase()
                              : 'Start'.toUpperCase(),
                          style: const TextStyle(
                            letterSpacing: 1.25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: SplashyButton(
                        onTap: timerResumePauseHandler,
                        color: Colors.blueGrey[400]!,
                        child: Text(
                          timerIsPaused & timerIsActive
                              ? 'Resume'.toUpperCase()
                              : 'Pause'.toUpperCase(),
                          style: const TextStyle(
                            letterSpacing: 1.25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onCompleteHandle() {
    if (period < 5) {
      _countdownController.start();
    } else {
      _countdownController.pause();
      setState(() {
        timerIsActive = false;
      });
    }
  }

  timerStartHandler() {
    if (!timerIsActive) {
      setState(() {
        timerIsActive = true;
        timerIsPaused = false;

        period = 0;
      });
      _countdownController.start();
    } else {
      setState(() {
        timerIsActive = false;
        timerIsPaused = false;
        period = 0;
      });
      _countdownController.restart();
      _countdownController.pause();
    }
  }

  timerResumePauseHandler() {
    if (timerIsPaused & timerIsActive) {
      _countdownController.resume();
      setState(() {
        timerIsPaused = false;
      });
    } else {
      _countdownController.pause();
      setState(() {
        timerIsPaused = true;
      });
    }
  }

  handleTextChange(String value) {
    setState(() {
      try {
        initialWeight = double.parse(value);
        _coffee = Coffee(weight: initialWeight);
      } catch (e) {
        initialWeight = 20;
        _coffee = Coffee(weight: 20);
      }
    });
  }
}
