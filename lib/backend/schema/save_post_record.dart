import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'save_post_record.g.dart';

abstract class SavePostRecord
    implements Built<SavePostRecord, SavePostRecordBuilder> {
  static Serializer<SavePostRecord> get serializer =>
      _$savePostRecordSerializer;

  @nullable
  DocumentReference get postSaved;

  @nullable
  DocumentReference get user;

  @nullable
  DateTime get savedTime;

  @nullable
  @BuiltValueField(wireName: 'count_post')
  int get countPost;

  @nullable
  String get datepost;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SavePostRecordBuilder builder) => builder
    ..countPost = 0
    ..datepost = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('savePost');

  static Stream<SavePostRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<SavePostRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SavePostRecord._();
  factory SavePostRecord([void Function(SavePostRecordBuilder) updates]) =
      _$SavePostRecord;

  static SavePostRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createSavePostRecordData({
  DocumentReference postSaved,
  DocumentReference user,
  DateTime savedTime,
  int countPost,
  String datepost,
}) =>
    serializers.toFirestore(
        SavePostRecord.serializer,
        SavePostRecord((s) => s
          ..postSaved = postSaved
          ..user = user
          ..savedTime = savedTime
          ..countPost = countPost
          ..datepost = datepost));
