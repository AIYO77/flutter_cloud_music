/// Creator: Xing Wei
/// Email: 654206017@qq.com
/// Date: 2022/4/25 4:50 下午
/// Des:

class Collections {
  static bool compareIsSame<T>(List<T> list1, List<T> list2) {
    if (list1.length != list2.length) return false;

    for (int i = 0; i < list1.length; i++) {
      if (list1.elementAt(i).toString() != list2.elementAt(i).toString()) {
        return false;
      }
    }
    return true;
  }
}
