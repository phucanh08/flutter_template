class BaseResponse<T> {
  final T? data;

  const BaseResponse({this.data});
}

class PaginationResponse<T> {
  final List<T> data;
  final String? nextPage;

  const PaginationResponse({
    required this.data,
    this.nextPage,
  });
}
