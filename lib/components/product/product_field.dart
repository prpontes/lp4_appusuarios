import 'package:flutter/material.dart';

class ProductField extends StatelessWidget {
  final String field;
  final String value;

  final TextStyle fieldStyle;
  final TextStyle valueStyle;

  final bool fieldShadowEnable;
  final bool valueShadowEnable;

  final VoidCallback? onValueTap;

  const ProductField({
    Key? key,
    required this.field,
    required this.value,
    this.onValueTap,
    this.fieldShadowEnable = true,
    this.valueShadowEnable = false,
    this.fieldStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.valueStyle = const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field,
          textAlign: TextAlign.justify,
          style: fieldStyle.copyWith(
            shadows: fieldShadowEnable
                ? [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(-0.2, 0.5),
                      blurRadius: 5,
                    ),
                  ]
                : [],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          child: Text(
            value,
            textAlign: TextAlign.start,
            style: valueStyle.copyWith(
              shadows: valueShadowEnable
                  ? [
                      Shadow(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        offset: Offset(0, 0),
                        blurRadius: 2,
                      )
                    ]
                  : [],
            ),
          ),
          onTap: onValueTap,
        ),
      ],
    );
  }
}
