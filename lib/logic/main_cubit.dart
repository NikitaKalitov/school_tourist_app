import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/hotel_model.dart';
import '../data/models/place_model.dart';
import '../data/storage/storage_provider.dart';

enum AppStatus {
  isLoading,
  loaded,
}

class MainCubit extends Cubit<MainCubitState> {
  MainCubit()
      : super(MainCubitState(
          appStatus: AppStatus.isLoading,
          allHotels: [],
          allPlaces: [],
          favPlaces: [],
          favHotels: [],
        ));

  void initCubit() async {
    var [allHotels, allPlaces, favHotels, favPlaces] =
        await SPrefProvider.getAllData();
    emit(state.copyWith(
      appStatus: AppStatus.loaded,
      allHotels: allHotels,
      allPlaces: allPlaces,
      favHotels: favHotels,
      favPlaces: favPlaces,
    ));
  }

  void addOrRemoveFav(var object) {
    if(object is Hotel){
      _addOrRemoveFavHotel(object);
    } else {
      _addOrRemoveFavPlace(object);
    }
  }

  bool checkIfInFav(var object) {
    if(object is Hotel){
      return _checkIfInFavHotel(object);
    } else {
      return _checkIfInFavPlace(object);
    }
  }

  bool _checkIfInFavHotel(Hotel hotel) {
    bool contains = false;
    for(int i = 0; i < state.favHotels!.length; i++) {
      if(state.favHotels![i].id == hotel.id) {
        contains = true;
      }
    }
    return contains;
  }

  bool _checkIfInFavPlace(Place place) {
    bool contains = false;
    for(int i = 0; i < state.favPlaces!.length; i++) {
      if(state.favPlaces![i].id == place.id) {
        contains = true;
      }
    }
    return contains;
  }

  void _addOrRemoveFavHotel(Hotel hotel) {
    if(_checkIfInFavHotel(hotel)){
      _removeHotelFromFav(hotel);
    } else {
      _addHotelToFav(hotel);
    }
  }

  void _addHotelToFav(Hotel hotel) async {
    List<Hotel> favHotels = [...state.favHotels!, hotel];
    await SPrefProvider.saveFavHotels(favHotels);
    emit(state.copyWith(favHotels: favHotels));
  }

  void _removeHotelFromFav(Hotel hotel) async {
    List<Hotel> favHotels = [...state.favHotels!];
    favHotels.removeWhere((element) => element.id == hotel.id);
    await SPrefProvider.saveFavHotels(favHotels);
    emit(state.copyWith(favHotels: favHotels));
  }

  void _addOrRemoveFavPlace(Place place) {
    if(_checkIfInFavPlace(place)){
      _removePlaceFromFav(place);
    } else {
      _addPlaceToFav(place);
    }
  }

  void _addPlaceToFav(Place place) async {
    List<Place> favPlaces = [...state.favPlaces!, place];
    await SPrefProvider.saveFavPlaces(favPlaces);
    emit(state.copyWith(favPlaces: favPlaces));
  }

  void _removePlaceFromFav(Place place) async {
    List<Place> favPlaces = [...state.favPlaces!];
    favPlaces.removeWhere((element) => element.id == place.id);
    await SPrefProvider.saveFavPlaces(favPlaces);
    emit(state.copyWith(favPlaces: favPlaces));
  }
}

class MainCubitState {
  AppStatus? appStatus;
  List<Hotel>? allHotels;
  List<Hotel>? favHotels;
  List<Place>? allPlaces;
  List<Place>? favPlaces;

  MainCubitState({
    this.appStatus,
    this.allHotels,
    this.allPlaces,
    this.favHotels,
    this.favPlaces,
  });

  MainCubitState copyWith({
    AppStatus? appStatus,
    List<Hotel>? allHotels,
    List<Hotel>? favHotels,
    List<Place>? allPlaces,
    List<Place>? favPlaces,
  }) {
    return MainCubitState(
      appStatus: appStatus ?? this.appStatus,
      allHotels: allHotels ?? this.allHotels,
      allPlaces: allPlaces ?? this.allPlaces,
      favHotels: favHotels ?? this.favHotels,
      favPlaces: favPlaces ?? this.favPlaces,
    );
  }
}
