// ⭐Note⭐: The function must be a getter, otherwise hot reload will not work
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

AdLayoutBuilder get customAdTemplateLayoutBuilder {
  return (ratingBar, media, icon, headline, advertiser, body, price, store, attribution, button) {
    return AdLinearLayout(
      decoration: AdDecoration(backgroundColor: Colors.white),
      width: MATCH_PARENT,
      height: MATCH_PARENT,
      gravity: LayoutGravity.center_vertical,
      padding: const EdgeInsets.all(8.0),
      children: [
        attribution,
        AdLinearLayout(
          padding: const EdgeInsets.only(top: 6.0),
          height: WRAP_CONTENT,
          orientation: HORIZONTAL,
          children: [
            icon,
            AdExpanded(
              flex: 2,
              child: AdLinearLayout(
                width: WRAP_CONTENT,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                children: [headline, body, advertiser],
              ),
            ),
          ],
        ),
        media,
        button
      ],
    );
  };
}
