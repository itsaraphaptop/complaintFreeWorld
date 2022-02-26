import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_friends_record.g.dart';

abstract class UserFriendsRecord
    implements Built<UserFriendsRecord, UserFriendsRecordBuilder> {
  static Serializer<UserFriendsRecord> get serializer =>
      _$userFriendsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'Applicant_UID')
  DocumentReference get applicantUID;

  @nullable
  @BuiltValueField(wireName: 'Recipient_UID')
  DocumentReference get recipientUID;

  @nullable
  @BuiltValueField(wireName: 'Status_Request')
  String get statusRequest;

  @nullable
  @BuiltValueField(wireName: 'Recipient_Choice')
  bool get recipientChoice;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UserFriendsRecordBuilder builder) => builder
    ..statusRequest = ''
    ..recipientChoice = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user_friends');

  static Stream<UserFriendsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UserFriendsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UserFriendsRecord._();
  factory UserFriendsRecord([void Function(UserFriendsRecordBuilder) updates]) =
      _$UserFriendsRecord;

  static UserFriendsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUserFriendsRecordData({
  DocumentReference applicantUID,
  DocumentReference recipientUID,
  String statusRequest,
  bool recipientChoice,
}) =>
    serializers.toFirestore(
        UserFriendsRecord.serializer,
        UserFriendsRecord((u) => u
          ..applicantUID = applicantUID
          ..recipientUID = recipientUID
          ..statusRequest = statusRequest
          ..recipientChoice = recipientChoice));
