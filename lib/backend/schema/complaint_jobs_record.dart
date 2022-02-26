import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'complaint_jobs_record.g.dart';

abstract class ComplaintJobsRecord
    implements Built<ComplaintJobsRecord, ComplaintJobsRecordBuilder> {
  static Serializer<ComplaintJobsRecord> get serializer =>
      _$complaintJobsRecordSerializer;

  @nullable
  String get comment;

  @nullable
  bool get complaintCheck;

  @nullable
  DocumentReference get userComplaint;

  @nullable
  DateTime get createComplaint;

  @nullable
  DateTime get dateComment;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ComplaintJobsRecordBuilder builder) => builder
    ..comment = ''
    ..complaintCheck = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('complaintJobs');

  static Stream<ComplaintJobsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ComplaintJobsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  ComplaintJobsRecord._();
  factory ComplaintJobsRecord(
          [void Function(ComplaintJobsRecordBuilder) updates]) =
      _$ComplaintJobsRecord;

  static ComplaintJobsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createComplaintJobsRecordData({
  String comment,
  bool complaintCheck,
  DocumentReference userComplaint,
  DateTime createComplaint,
  DateTime dateComment,
}) =>
    serializers.toFirestore(
        ComplaintJobsRecord.serializer,
        ComplaintJobsRecord((c) => c
          ..comment = comment
          ..complaintCheck = complaintCheck
          ..userComplaint = userComplaint
          ..createComplaint = createComplaint
          ..dateComment = dateComment));
