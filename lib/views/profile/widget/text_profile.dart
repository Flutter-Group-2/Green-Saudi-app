import 'package:flutter/material.dart';
import 'package:green_saudi_app/resources/utils/colors.dart';
import 'package:green_saudi_app/resources/utils/spacing.dart';

class TextProfile extends StatelessWidget {
  final String title;
  final String data;
  final IconData? icon;
  final bool isClickable;
  const TextProfile({
    required this.title,
    required this.data,
    super.key,
    this.icon,
    this.isClickable = false,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            (isClickable)
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: green,
                        ),
                      ),
                    ),
                    child: Text(
                      'See History Hours',
                      style: TextStyle(color: green, fontSize: 14),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        Container(
          width: 350,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: grey)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
              ),
              width16,
              SizedBox(
                width: 250,
                child: Text(
                  data,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
