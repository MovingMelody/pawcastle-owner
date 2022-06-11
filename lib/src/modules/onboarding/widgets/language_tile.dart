import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';

class LanguageSelectionGridItem extends StatelessWidget {
  final String languageName, languageText;
  final bool isSelected;
  final Function onSelected;

  const LanguageSelectionGridItem(
      {Key? key,
      required this.languageName,
      required this.languageText,
      required this.onSelected,
      required this.isSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width / 2 - 25,
      child: Material(
        type: MaterialType.card,
        color: isSelected ? kCoreColor : kSurfaceColor,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        elevation: 2,
        child: InkWell(
          onTap: () => onSelected(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIText.heading(
                      languageText,
                      size: TxtSize.Small,
                      color: selectedColor(isSelected),
                    ),
                    if (isSelected)
                      Container(
                        padding: EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                            color: kSurfaceColor,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Icon(
                          Icons.done,
                          size: 20.0,
                          color: kCoreColor,
                        ),
                      )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                UIText.paragraph(
                  languageName,
                  color: selectedColor(isSelected),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color selectedColor(bool isSelected) {
    return isSelected ? kTextPrimaryDarkColor : kTextPrimaryLightColor;
  }
}
