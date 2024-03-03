import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/main_cubit.dart';
import '../widgets/hotel_widget.dart';

class AllHotelsPage extends StatefulWidget {
  const AllHotelsPage({super.key, required this.icon, required this.label});

  final Icon icon;
  final String label;

  @override
  State<AllHotelsPage> createState() => _AllHotelsPageState();
}

class _AllHotelsPageState extends State<AllHotelsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainCubitState>(
      builder: (context, state) {
        return SingleChildScrollView(
          key: const PageStorageKey<String>('allHotels'),
          child: Column(
            children: state.allHotels!.map((e) {
              return HotelWidget(hotel: e);
            }).toList(),
          ),
        );
      },
    );
  }
}
