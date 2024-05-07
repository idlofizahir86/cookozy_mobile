import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/page_cubit.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final int index;
  final String itemName;

  const CustomBottomNavigationItem({
    Key? key,
    required this.index,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<PageCubit>().setPage(index);
          },
          child: Image.asset(
            state == index
                ? "assets/icons/icon_${itemName}_ch.png"
                : "assets/icons/icon_$itemName.png",
            width: 30,
            height: 30,
          ),
        );
      },
    );
  }
}
