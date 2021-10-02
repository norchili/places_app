import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:places_app/Place/model/place.dart';
import 'package:places_app/Place/ui/widgets/card_image.dart';
import 'package:places_app/User/model/user.dart';
import 'package:places_app/User/repository/cloud_firestore_api.dart';
import 'package:places_app/User/ui/widgets/profile_place.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreApi = CloudFirestoreApi();
  void updateUserDataFirestore(User user) =>
      _cloudFirestoreApi.updateUserData(user);

  Future<void> updateUserPlaceData(Place place) =>
      _cloudFirestoreApi.updateUserPlaceData(place);

  List<ProfilePlace> buildMyPlaces(List<DocumentSnapshot> placesListSnapshot) =>
      _cloudFirestoreApi.buildMyPlaces(placesListSnapshot);

  List<Place> buildPlaces(
          List<DocumentSnapshot> placesListSnapshot, User user) =>
      _cloudFirestoreApi.buildPlaces(placesListSnapshot, user);

  Future likePlace(Place place, String userId) =>
      _cloudFirestoreApi.likePlace(place, userId);

  Stream<QuerySnapshot<Map<String, dynamic>>> myPlacesListStream(String uid) =>
      _cloudFirestoreApi.myPlacesListStream(uid);
}
