import 'package:equatable/equatable.dart';

import 'package:urrevs_ui_mobile/domain/failure.dart';

abstract class GetCuttentUserImageUrlState extends Equatable {}

class GetCuttentUserImageUrlInitialState extends GetCuttentUserImageUrlState {
  @override
  List<Object?> get props => [];
}

class GetCuttentUserImageUrlLoadingState extends GetCuttentUserImageUrlState {
  @override
  List<Object?> get props => [];
}

class GetCuttentUserImageUrlLoadedState extends GetCuttentUserImageUrlState {
  final String? imageUrl;
  GetCuttentUserImageUrlLoadedState({
    required this.imageUrl,
  });
  @override
  List<Object?> get props => [imageUrl];
}

class GetCuttentUserImageUrlErrorState extends GetCuttentUserImageUrlState {
  final Failure failure;
  GetCuttentUserImageUrlErrorState({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure.message];
}
