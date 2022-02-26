import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  String get bio;

  @nullable
  String get experienceLevel;

  @nullable
  bool get likedPosts;

  @nullable
  String get positionTitle;

  @nullable
  @BuiltValueField(wireName: 'like_count')
  int get likeCount;

  @nullable
  DateTime get dateEndComplaint;

  @nullable
  @BuiltValueField(wireName: 'ComplantDece')
  String get complantDece;

  @nullable
  @BuiltValueField(wireName: 'unlike_count')
  int get unlikeCount;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..bio = ''
    ..experienceLevel = ''
    ..likedPosts = false
    ..positionTitle = ''
    ..likeCount = 0
    ..complantDece = ''
    ..unlikeCount = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static UsersRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) => UsersRecord(
        (c) => c
          ..email = snapshot.data['email']
          ..displayName = snapshot.data['display_name']
          ..photoUrl = snapshot.data['photo_url']
          ..uid = snapshot.data['uid']
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..phoneNumber = snapshot.data['phone_number']
          ..bio = snapshot.data['bio']
          ..experienceLevel = snapshot.data['experienceLevel']
          ..likedPosts = snapshot.data['likedPosts']
          ..positionTitle = snapshot.data['positionTitle']
          ..likeCount = snapshot.data['like_count']
          ..dateEndComplaint = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(
                  snapshot.data['dateEndComplaint']))
          ..complantDece = snapshot.data['ComplantDece']
          ..unlikeCount = snapshot.data['unlike_count']
          ..reference = UsersRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<UsersRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'users',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String email,
  String displayName,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  String bio,
  String experienceLevel,
  bool likedPosts,
  String positionTitle,
  int likeCount,
  DateTime dateEndComplaint,
  String complantDece,
  int unlikeCount,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..bio = bio
          ..experienceLevel = experienceLevel
          ..likedPosts = likedPosts
          ..positionTitle = positionTitle
          ..likeCount = likeCount
          ..dateEndComplaint = dateEndComplaint
          ..complantDece = complantDece
          ..unlikeCount = unlikeCount));
