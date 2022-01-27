import 'dart:async';
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
  double initialWeight = 30;
  late Coffee _coffee = Coffee(weight: initialWeight);
  bool timerIsActive = false;
  int period = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  onChanged: handleTextChange,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
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
                  : _coffee.getFullPours()[period].toStringAsFixed(1)),
              const SizedBox(height: 15),
              CircularCountDownTimer(
                autoStart: false,
                controller: _countdownController,
                width: 200,
                height: 200,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: SplashyButton(
                        onTap: timerStartHandler,
                        child: Text(
                          'Start'.toUpperCase(),
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
                        onTap: () {
                          _countdownController.pause();
                        },
                        color: Colors.blueGrey[400]!,
                        child: Text(
                          'Pause'.toUpperCase(),
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
                    Expanded(
                      child: SplashyButton(
                        onTap: () {
                          _countdownController.resume();
                        },
                        color: Colors.blueGrey[400]!,
                        child: Text(
                          'Resume'.toUpperCase(),
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
                        onTap: () {
                          if (timerIsActive) {
                            _countdownController.restart();
                            setState(() {
                              period = 1;
                            });
                          }
                        },
                        color: Colors.blueGrey[400]!,
                        child: Text(
                          'Restart'.toUpperCase(),
                          style: const TextStyle(
                            letterSpacing: 1.25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
        period = 0;
        timerIsActive = true;
      });
      _countdownController.start();
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
