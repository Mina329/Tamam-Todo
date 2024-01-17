import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoAndName extends StatelessWidget {
  const LogoAndName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: Align(
        alignment: Alignment.center,
        child: FittedBox(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
              ),
              Text(
                'Tamam',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
