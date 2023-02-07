import "package:feel_the_art/theme/theme.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";

class ColumnLabel extends StatelessWidget {
  final String icon;
  final String text;

  const ColumnLabel({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        border: Border.all(color: bgColor, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        children: [
          Expanded(
            child: (icon.contains(".svg"))
                ? SvgPicture.asset(
                    icon,
                    height: 40,
                  )
                : Image.asset(icon, height: 40),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 50,
            decoration: BoxDecoration(
              color: primaryColor,
              border: Border.all(color: bgColor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
            ),
          ),
          Expanded(
            flex: 4,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
