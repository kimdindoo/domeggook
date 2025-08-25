class PaginationHelper {
  PaginationHelper({required this.pageSize});

  final int pageSize; // 한 페이지에 표시할 아이템 개수

  // 이전에 가져온 아이템 개수를 저장하는 변수
  int _previousLength = 0;

  // 마지막 페이지인지 판단하는 함수
  bool isLastPage(List? items) {
    // 아이템 리스트가 null이면 아직 데이터 없음 → 마지막 페이지 아님
    if (items == null) return false;

    // 새로 가져온 아이템 수 계산
    final int fetchedItemsCount = items.length - _previousLength;

    // _previousLength 업데이트
    _previousLength = items.length;

    // 가져온 아이템 수가 pageSize보다 작으면 마지막 페이지
    return fetchedItemsCount < pageSize;
  }

  // _previousLength 초기화
  // 주로 Pull-to-Refresh(새로고침) 시 호출
  void reset() {
    _previousLength = 0;
  }
}
