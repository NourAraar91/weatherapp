
extension ListExtinsion<T extends List> on T {
  T everyNthElement(int n) {
    return this.where((item) => (this.indexOf(item) + 1) % n == 0).toList();
  }
}
