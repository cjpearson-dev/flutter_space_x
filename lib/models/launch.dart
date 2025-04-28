import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch.freezed.dart';
part 'launch.g.dart';

// I would usually make each of these classes its own file and then group related classes in themed directories within,
// but in the interests of time putting them here for now.
@freezed
abstract class Launch with _$Launch {
  const factory Launch({
    required int flightNumber,
    required String missionName,
    required List<String> missionId,
    required String launchYear,
    required int launchDateUnix,
    required String launchDateUtc,
    required String launchDateLocal,
    required bool isTentative,
    required String tentativeMaxPrecision,
    required bool tbd,
    int? launchWindow,
    required LaunchRocket rocket,
    required List<String> ships,
    required LaunchTelemetry telemetry,
    required LaunchSite launchSite,
    bool? launchSuccess,
    required LaunchLinks links,
    required String? details,
    required bool upcoming,
    required String? staticFireDateUtc,
    required int? staticFireDateUnix,
  }) = _Launch;

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);
}

@freezed
abstract class LaunchRocket with _$LaunchRocket {
  const factory LaunchRocket({
    required String rocketId,
    required String rocketName,
  }) = _LaunchRocket;

  factory LaunchRocket.fromJson(Map<String, dynamic> json) =>
      _$LaunchRocketFromJson(json);
}

@freezed
abstract class LaunchTelemetry with _$LaunchTelemetry {
  const factory LaunchTelemetry({String? flightClub}) = _LaunchTelemetry;

  factory LaunchTelemetry.fromJson(Map<String, dynamic> json) =>
      _$LaunchTelemetryFromJson(json);
}

@freezed
abstract class LaunchSite with _$LaunchSite {
  const factory LaunchSite({
    required String siteId,
    required String siteName,
    required String siteNameLong,
  }) = _LaunchSite;

  factory LaunchSite.fromJson(Map<String, dynamic> json) =>
      _$LaunchSiteFromJson(json);
}

@freezed
abstract class LaunchSiteDetail with _$LaunchSiteDetail {
  const factory LaunchSiteDetail({
    required String siteId,
    required String name,
    required String siteNameLong,
    @Default(0) int attemptedLaunches,
  }) = _LaunchSiteDetail;

  factory LaunchSiteDetail.fromJson(Map<String, dynamic> json) =>
      _$LaunchSiteDetailFromJson(json);
}

@freezed
abstract class LaunchLinks with _$LaunchLinks {
  const factory LaunchLinks({
    String? missionPatch,
    String? missionPatchSmall,
    String? redditCampaign,
    String? redditLaunch,
    String? redditRecovery,
    String? redditMedia,
    String? presskit,
    String? articleLink,
    String? wikipedia,
    String? videoLink,
    String? youtubeId,
    @Default([]) List<String> flickrImages,
  }) = _LaunchLinks;

  factory LaunchLinks.fromJson(Map<String, dynamic> json) =>
      _$LaunchLinksFromJson(json);
}
