import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDrobDown extends StatefulWidget {
  const CustomDrobDown(
      {super.key,
      required this.values,
      required this.titles,
      required this.onSelected});

  final List<String> values;
  final List<String> titles;
  final Function(String) onSelected;
  @override
  State<CustomDrobDown> createState() => _CustomDrobDownState();
}

class _CustomDrobDownState extends State<CustomDrobDown> {
  late String selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.titles[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white.withOpacity(0.21)
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
          child: PopupMenuButton(
            itemBuilder: (context) => List.generate(
              widget.titles.length,
              (int index) => PopupMenuItem<String>(
                value: widget.values[index],
                child: Text(
                  widget.titles[index],
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            onSelected: (p0) {
              setState(() {
                selectedValue = widget.titles[widget.values.indexOf(p0)];
              });
              widget.onSelected(p0);
            },
            offset: Offset.fromDirection(1.5, 44.h),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: 120.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedValue,
                    style: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white,
                            )
                        : Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.black,
                            ),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: 26.sp,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
