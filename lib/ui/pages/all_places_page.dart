import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/main_cubit.dart';
import '../widgets/place_widget.dart';

class AllPlacesPage extends StatefulWidget {
  const AllPlacesPage({super.key, required this.icon, required this.label});

  final Icon icon;
  final String label;

  @override
  State<AllPlacesPage> createState() => _AllPlacesPageState();
}

class _AllPlacesPageState extends State<AllPlacesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainCubitState>(
      builder: (context, state) {
        return SingleChildScrollView(
          key: const PageStorageKey<String>('allPlaces'),
          child: Column(
            children: state.allPlaces!.map((e) {
              return PlaceWidget(place: e);
            }).toList(),
          ),
        );
      },
    );
  }
}
