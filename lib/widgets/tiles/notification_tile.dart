import 'package:flutter/material.dart';
import 'package:timberr/constants.dart';

class NotificationTile extends StatelessWidget {
  final String name;
  final String description;
  final bool isNew;
  const NotificationTile(
      {super.key,
      required this.name,
      required this.description,
      required this.isNew});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 95,
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
          color: (isNew) ? kSnowFlakeWhite : Colors.white,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  "assets/sample.png",
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: kNunitoSans12Grey.copyWith(
                        color: kOffBlack,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      description,
                      style: kNunitoSans10Grey,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        if (isNew)
          Positioned(
            bottom: 10,
            right: 20,
            child: Text(
              "New",
              style: kNunitoSans14.copyWith(
                fontWeight: FontWeight.w800,
                color: kCrayolaGreen,
              ),
            ),
          ),
      ],
    );
  }
}
