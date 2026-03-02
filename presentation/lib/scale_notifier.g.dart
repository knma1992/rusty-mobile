// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scale_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ScaleNotifier)
final scaleProvider = ScaleNotifierProvider._();

final class ScaleNotifierProvider
    extends $NotifierProvider<ScaleNotifier, double> {
  ScaleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scaleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scaleNotifierHash();

  @$internal
  @override
  ScaleNotifier create() => ScaleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$scaleNotifierHash() => r'6abd249605d40a0146aca86b4abde94ec26c32fb';

abstract class _$ScaleNotifier extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<double, double>,
              double,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
