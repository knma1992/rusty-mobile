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

String _$frbNotifierHash() => r'9b9d8bff4ea6220e91dbc9a0939a4f000f167c58';

abstract class _$FrbNotifier extends $Notifier<FrbData> {
  FrbData build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<FrbData, FrbData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FrbData, FrbData>,
              FrbData,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
