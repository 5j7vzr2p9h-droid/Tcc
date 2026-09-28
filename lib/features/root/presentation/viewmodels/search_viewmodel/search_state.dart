import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/item_entity.dart';

sealed class const SearchState();

final class const SearchInitialState() extends SearchState;

final class const SearchFailureState(final Failure failure) extends SearchState;

final class const SearchSuccessState(final List<ItemEntity> items) extends SearchState;

final class const SearchCancelState() extends SearchState;