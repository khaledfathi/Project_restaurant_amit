part of 'bag_cubit.dart';

@immutable
sealed class BagState {}

final class BagInitial extends BagState {}
final class BagChanged extends BagState {}
