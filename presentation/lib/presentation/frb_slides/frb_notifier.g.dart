// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'frb_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FrbNotifier)
final frbProvider = FrbNotifierProvider._();

final class FrbNotifierProvider
    extends $NotifierProvider<FrbNotifier, FrbData> {
  FrbNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'frbProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$frbNotifierHash();

  @$internal
  @override
  FrbNotifier create() => FrbNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FrbData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FrbData>(value),
    );
  }
}

String _$frbNotifierHash() => r'850e05fa432d4b1521ddbe05e7b07c90e1dee790';

abstract class _$FrbNotifier extends $Notifier<FrbData> {
  FrbData build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FrbData, FrbData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FrbData, FrbData>,
              FrbData,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
