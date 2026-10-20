import '../entities/paginated_list_entity.dart';

final class const PaginatedListModel<T>({
  required super.pageIndex,
  required super.pageSize,
  required super.count,
  required super.items
}) extends PaginatedListEntity<T> {

  factory PaginatedListModel.fromJson(dynamic json, T Function(dynamic json) fromJsonT)
  => PaginatedListModel<T>(
    pageIndex: json["pageIndex"],
    pageSize: json["pageSize"],
    count: json["count"],
    items: (json["data"] as List).map<T>(fromJsonT).toList()
  );
}
