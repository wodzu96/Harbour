import 'dart:math';

class RandomUtil {
  static randomLatLng() {
    Random rnd;
    int min = -180;
    int max = 180;
    rnd = new Random();
    return min + rnd.nextInt(max - min);
  }
}
