import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'job_posts_record.g.dart';

abstract class JobPostsRecord
    implements Built<JobPostsRecord, JobPostsRecordBuilder> {
  static Serializer<JobPostsRecord> get serializer =>
      _$jobPostsRecordSerializer;

  @nullable
  String get jobCompany;

  @nullable
  String get jobDescription;

  @nullable
  LatLng get jobLocation;

  @nullable
  String get jobName;

  @nullable
  String get jobPreferredSkills;

  @nullable
  String get jobRequirements;

  @nullable
  bool get likedPost;

  @nullable
  bool get myJob;

  @nullable
  DocumentReference get postedBy;

  @nullable
  String get salary;

  @nullable
  DateTime get timeCreated;

  @nullable
  @BuiltValueField(wireName: 'Photo_url')
  String get photoUrl;

  @nullable
  @BuiltValueField(wireName: 'like_count')
  int get likeCount;

  @nullable
  @BuiltValueField(wireName: 'user_approve')
  BuiltList<DocumentReference> get userApprove;

  @nullable
  String get dateCreated;

  @nullable
  @BuiltValueField(wireName: 'unlike_count')
  int get unlikeCount;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(JobPostsRecordBuilder builder) => builder
    ..jobCompany = ''
    ..jobDescription = ''
    ..jobName = ''
    ..jobPreferredSkills = ''
    ..jobRequirements = ''
    ..likedPost = false
    ..myJob = false
    ..salary = ''
    ..photoUrl = ''
    ..likeCount = 0
    ..userApprove = ListBuilder()
    ..dateCreated = ''
    ..unlikeCount = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('jobPosts');

  static Stream<JobPostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<JobPostsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  JobPostsRecord._();
  factory JobPostsRecord([void Function(JobPostsRecordBuilder) updates]) =
      _$JobPostsRecord;

  static JobPostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createJobPostsRecordData({
  String jobCompany,
  String jobDescription,
  LatLng jobLocation,
  String jobName,
  String jobPreferredSkills,
  String jobRequirements,
  bool likedPost,
  bool myJob,
  DocumentReference postedBy,
  String salary,
  DateTime timeCreated,
  String photoUrl,
  int likeCount,
  String dateCreated,
  int unlikeCount,
}) =>
    serializers.toFirestore(
        JobPostsRecord.serializer,
        JobPostsRecord((j) => j
          ..jobCompany = jobCompany
          ..jobDescription = jobDescription
          ..jobLocation = jobLocation
          ..jobName = jobName
          ..jobPreferredSkills = jobPreferredSkills
          ..jobRequirements = jobRequirements
          ..likedPost = likedPost
          ..myJob = myJob
          ..postedBy = postedBy
          ..salary = salary
          ..timeCreated = timeCreated
          ..photoUrl = photoUrl
          ..likeCount = likeCount
          ..userApprove = null
          ..dateCreated = dateCreated
          ..unlikeCount = unlikeCount));
