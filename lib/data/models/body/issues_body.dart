import 'package:github_apps_deall/data/models/body/user_body.dart';
import 'package:json_annotation/json_annotation.dart';
part 'issues_body.g.dart';

@JsonSerializable()
class ResponseIssuesBody {
  final int? total_count;
  final List<IssuesBody>? items;

  ResponseIssuesBody({this.total_count, this.items});

  Map<String, dynamic> toJson() => _$ResponseIssuesBodyToJson(this);

  factory ResponseIssuesBody.fromJson(Map<String, dynamic> json) =>
      _$ResponseIssuesBodyFromJson(json);
}

@JsonSerializable()
class IssuesBody {
  final String? created_at;
  final String? state;
  final UserBody? user;
  final String? title;
  final String? author_association;
  final String? html_url;

  IssuesBody(
      {this.created_at,
      this.state,
      this.user,
      this.title,
      this.html_url,
      this.author_association});

  Map<String, dynamic> toJson() => _$IssuesBodyToJson(this);

  factory IssuesBody.fromJson(Map<String, dynamic> json) =>
      _$IssuesBodyFromJson(json);
}