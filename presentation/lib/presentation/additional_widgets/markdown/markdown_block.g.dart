// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'markdown_block.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(markdownAsset)
final markdownAssetProvider = MarkdownAssetFamily._();

final class MarkdownAssetProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  MarkdownAssetProvider._({
    required MarkdownAssetFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'markdownAssetProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$markdownAssetHash();

  @override
  String toString() {
    return r'markdownAssetProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return markdownAsset(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MarkdownAssetProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$markdownAssetHash() => r'6fde6583577979d0aa7506a6b8415fd6af8b2099';

final class MarkdownAssetFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  MarkdownAssetFamily._()
    : super(
        retry: null,
        name: r'markdownAssetProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MarkdownAssetProvider call(String assetPath) =>
      MarkdownAssetProvider._(argument: assetPath, from: this);

  @override
  String toString() => r'markdownAssetProvider';
}
