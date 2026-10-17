import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract interface class const BannersRepository() {
  Future<Either<Failure,List<String>>> getBanners();
}