// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_counter_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$helloWorldHash() => r'024de4a22e4c8f627596ceb03f74263f353037db';

/// See also [helloWorld].
@ProviderFor(helloWorld)
final helloWorldProvider = AutoDisposeProvider<String>.internal(
  helloWorld,
  name: r'helloWorldProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$helloWorldHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HelloWorldRef = AutoDisposeProviderRef<String>;
String _$fakeCounterHash() => r'87cabd89e461e387f7982681e2b6b43ebee8fc8c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fakeCounter].
@ProviderFor(fakeCounter)
const fakeCounterProvider = FakeCounterFamily();

/// See also [fakeCounter].
class FakeCounterFamily extends Family<AsyncValue<int>> {
  /// See also [fakeCounter].
  const FakeCounterFamily();

  /// See also [fakeCounter].
  FakeCounterProvider call(int start) {
    return FakeCounterProvider(start);
  }

  @override
  FakeCounterProvider getProviderOverride(
    covariant FakeCounterProvider provider,
  ) {
    return call(provider.start);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fakeCounterProvider';
}

/// See also [fakeCounter].
class FakeCounterProvider extends StreamProvider<int> {
  /// See also [fakeCounter].
  FakeCounterProvider(int start)
    : this._internal(
        (ref) => fakeCounter(ref as FakeCounterRef, start),
        from: fakeCounterProvider,
        name: r'fakeCounterProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fakeCounterHash,
        dependencies: FakeCounterFamily._dependencies,
        allTransitiveDependencies: FakeCounterFamily._allTransitiveDependencies,
        start: start,
      );

  FakeCounterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.start,
  }) : super.internal();

  final int start;

  @override
  Override overrideWith(Stream<int> Function(FakeCounterRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: FakeCounterProvider._internal(
        (ref) => create(ref as FakeCounterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        start: start,
      ),
    );
  }

  @override
  StreamProviderElement<int> createElement() {
    return _FakeCounterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FakeCounterProvider && other.start == start;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, start.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FakeCounterRef on StreamProviderRef<int> {
  /// The parameter `start` of this provider.
  int get start;
}

class _FakeCounterProviderElement extends StreamProviderElement<int>
    with FakeCounterRef {
  _FakeCounterProviderElement(super.provider);

  @override
  int get start => (origin as FakeCounterProvider).start;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
