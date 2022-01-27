import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSliverAppbar extends StatelessWidget {
  const CustomSliverAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      shadowColor: Colors.black26,
      leading: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          'assets/images/menu-bar.svg',
        ),
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_pin,
            size: 16,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            'Dhahran, SA',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(Icons.expand_more_rounded),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
