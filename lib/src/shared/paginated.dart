class Paginated<T> with Iterable<T> {

  const Paginated(
    this.items, {
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  }) : assert(items.length <= limit),
      assert(page > 0),
      assert(limit > 0);

  final List<T> items;

  final int page;

  final int limit;

  final int total;

  final int totalPages;

  T operator [](int index) => items[index];
  
  @override
  Iterator<T> get iterator => items.iterator;
  
  bool get isFirstPage => page == 1;

  bool get isLastPage => page == totalPages;

  bool get hasNextPage => page < totalPages;

  bool get hasPreviousPage => page > 1;

  Paginated<T> copyWith({
    List<T>? items,
    int? page,
    int? limit,
    int? total,
    int? totalPages,
  }) => Paginated<T>(
    items ?? this.items,
    page: page ?? this.page,
    limit: limit ?? this.limit,
    total: total ?? this.total,
    totalPages: totalPages ?? this.totalPages,
  );

}
