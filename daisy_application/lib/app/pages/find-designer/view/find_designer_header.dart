import 'package:daisy_application/app/common/design/design.dart';
import 'package:daisy_application/app/common/responsive.dart';
import 'package:daisy_application/app/pages/find-designer/view/find_designer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FindDesignerHeader on FindDesignerPageState {
  Widget createHeader() {
    final currentTime = DateFormat('hh:mm a').format(DateTime.now());
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Khám phá designers',
            style:
                Design.textSmallLogo(isMobile: !Responsive.isDesktop(context)),
          ),
          const SizedBox(height: Design.contentSpacing),
          Row(
            children: [
              createItemTag('Trending designer', Colors.blueAccent),
              const SizedBox(width: Design.contentSpacing),
              if (Responsive.isDesktop(context))
                Text(' Local time: $currentTime',
                    style: Design.textCaption(
                      textColor: Design.colorNeutral.shade600,
                    ))
            ],
          ),
        ],
      ),
    );
  }

  Widget createItemTag(String text, Color color) => Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(2)),
            border: Border.all(color: color, width: 2)),
        child: Row(
          children: [
            Icon(Icons.trending_up, color: color, size: 18.0),
            const SizedBox(width: 5.0),
            Text(text, style: Design.textButtonSmall(textColor: color)),
          ],
        ),
      );
}
