import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavItem extends StatefulWidget {
  final void Function() changePage;
  final Color;
  final String icon;
  const NavItem(
      {super.key,
      required this.icon,
      required this.Color,
      required this.changePage});

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  String switchImagePath() {
    String path = 'assets/navbar/home.svg';
    switch (widget.icon) {
      case 'Home':
        break;
      case 'Transactions':
        path = 'assets/navbar/transaction.svg';
        break;
      case 'Virements':
        path = 'assets/navbar/virement.svg';
        break;
      case 'Scanner':
        path = 'assets/navbar/scanner.svg';
        break;
      case 'Cart':
        path = 'assets/navbar/carte.svg';
        break;
      case 'Profile':
        path = 'assets/navbar/profile.svg';
        break;
    }
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 6,
      height: MediaQuery.of(context).size.width / 6,
      child: InkWell(
        onTap: () {
          widget.changePage();
        },
        child: Column(
          children: [
            Flexible(
              child: SvgPicture.asset(
                switchImagePath(),
                semanticsLabel: 'My SVG Image',
                color: widget.Color,
              ),
            ),
            Flexible(
              child: Text(
                widget.icon,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: widget.Color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
