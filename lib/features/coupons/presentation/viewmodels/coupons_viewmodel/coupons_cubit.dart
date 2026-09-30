import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/enums/coupon_status.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/coupon_entity.dart';
import '../../../domain/usecases/get_coupons_usecase.dart';
import 'coupons_state.dart';

final class CouponsCubit extends Cubit<CouponsState>{
  final GetCouponsUsecase _getCouponsUsecase;

  CouponsCubit(this._getCouponsUsecase): super(const CouponsInitialState());

  void init() async{
    emit(const CouponsLoadingState());

    final Either<Failure, List<CouponEntity>> result = await _getCouponsUsecase();

    if(isClosed)
      return;

    result.fold(
      (Failure failure) => emit(CouponsGetFailureState(failure)),
      (List<CouponEntity> coupons) => emit(CouponsGetSuccessState(
        activeCoupons: coupons.where((CouponEntity coupon) => coupon.status == CouponStatus.active).toList(),
        expiredCoupons: coupons.where((CouponEntity coupon) => coupon.status == CouponStatus.expired).toList()
      ))
    );
  }
}
