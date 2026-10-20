class const PaginatedListEntity<T>({
  required final int pageIndex,
  required final int pageSize,
  /// Total number of items across all pages.
  required final int count,
  required final List<T> items
});
