import 'package:capulus/constants.dart';
import 'package:capulus/views/coffee_maker.dart';
import 'package:capulus/widgets/custom-sliverappbar.dart';
import 'package:capulus/widgets/headline-text.dart';
import 'package:capulus/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _controller;

  void initState() {
    super.initState();
    _controller = new ScrollController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          const CustomSliverAppbar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadlineText(
                    title: 'Enjoy Your\n',
                    subtitle: 'Coffee',
                    titleStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Inter',
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                    subtitleStyle: TextStyle(
                      fontSize: 24,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const CustomTextfield(hintText: 'Search Here'),
                  const SizedBox(
                    height: 700,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    double scrollThreshold = 90;
    return Material(
      color: Theme.of(context).primaryColor,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30),
      child: AnimatedContainer(
        clipBehavior: Clip.antiAlias,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _controller.hasClients && _controller.offset > scrollThreshold
            ? 150
            : 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: InkWell(
          splashColor: Colors.white.withOpacity(.2),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CoffeeMakerScreen();
              },
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.coffee,
                size: 16,
                color: Colors.white,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: _controller.hasClients &&
                        _controller.offset > scrollThreshold
                    ? 8
                    : 0,
                curve: Curves.easeInOut,
              ),
              Container(
                width: _controller.hasClients &&
                        _controller.offset > scrollThreshold
                    ? null
                    : 0,
                child: const Text(
                  'Make Coffee',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
