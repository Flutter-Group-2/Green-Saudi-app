import 'package:flutter/material.dart';
import 'package:green_saudi_app/extensions/screen_handler.dart';
import 'package:green_saudi_app/utils/colors.dart';
import 'package:green_saudi_app/utils/spacing.dart';

import '../views/deatils_offer_view.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          context.push(view: const DetailsOfferView(), isPush: true);
        },
        child: Card(
          color: pureWhite,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            alignment: Alignment.center,
            color: pureWhite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(10)),
                    child: Image.asset(
                      'assets/images/HalfMillionLogo-Black-croppped-extras.jpg',
                      fit: BoxFit.cover,
                    )),
                height10,
                Divider(
                  height: 3,
                  thickness: 4,
                  color: green,
                ),
                height10,
                Text(
                  "هاف مليون",
                  style: TextStyle(
                    fontSize: 18,
                    color: black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
