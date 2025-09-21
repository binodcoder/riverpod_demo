// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiChatRepositoryHash() => r'18dacdb4c6dc969b517d3a5248481a6d9413d144';

/// See also [aiChatRepository].
@ProviderFor(aiChatRepository)
final aiChatRepositoryProvider = AutoDisposeProvider<AiChatRepository>.internal(
  aiChatRepository,
  name: r'aiChatRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$aiChatRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiChatRepositoryRef = AutoDisposeProviderRef<AiChatRepository>;
String _$chatControllerHash() => r'38bd5807f1039516544dd6b3d54723db238856dd';

/// See also [ChatController].
@ProviderFor(ChatController)
final chatControllerProvider =
    NotifierProvider<ChatController, ChatState>.internal(
      ChatController.new,
      name: r'chatControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$chatControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ChatController = Notifier<ChatState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
