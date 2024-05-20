part of '/katana_scoped.dart';

/// [ScopedValueListener] that targets the app.
///
/// アプリを対象にしている[ScopedValueListener]。
class AppScopedValueListener extends ScopedValueListener {
  AppScopedValueListener._({
    required super.context,
    required super.callback,
    required super.appRef,
    required super.scope,
  }) : super._();

  @override
  ScopedValueContainer get container {
    if (_containerCache != null) {
      return _containerCache!;
    }
    return _containerCache = _appRef._scopedValueContainer;
  }

  @override
  @protected
  String? get _managedBy {
    return _appRef.runtimeType.toString();
  }
}

/// [ScopedValueListener] that targets the page.
///
/// ページを対象にしている[ScopedValueListener]。
class PageScopedValueListener extends _ScopedValueListenerOnPage {
  PageScopedValueListener._({
    required super.context,
    required super.callback,
    required super.appRef,
    required super.scope,
  }) : super._();

  @override
  ScopedValueContainer get container {
    if (_containerCache != null) {
      return _containerCache!;
    }
    return _containerCache = _PageScopedScope.of(_context)._container;
  }

  @override
  @protected
  String? get _managedBy {
    return _PageScopedScope.of(_context).widget.toString();
  }
}

class _ScopedValueListenerOnPage extends ScopedValueListener {
  _ScopedValueListenerOnPage._({
    required super.context,
    required super.callback,
    required super.appRef,
    super.container,
    super.scope = ScopedLoggerScope.page,
  }) : super._();

  @override
  TResult? getAlreadtExistsScopedValueResult<TResult,
      TScopedValue extends ScopedValue<TResult>>({
    bool listen = false,
    Object? name,
    bool recursive = true,
  }) {
    final res = super.getAlreadtExistsScopedValueResult<TResult, TScopedValue>(
      listen: listen,
      name: name,
    );
    if (res != null || !recursive) {
      return res;
    }
    return _PageScopedScope.maybeOf(_context)
        ?._pageListener
        .getAlreadtExistsScopedValueResult<TResult, TScopedValue>(
          listen: listen,
          name: name,
        );
  }
}

class _ScopedValueListenerOnWidget extends ScopedValueListener {
  _ScopedValueListenerOnWidget._({
    required super.context,
    required super.callback,
    required super.appRef,
    super.container,
    super.scope,
  }) : super._();

  @override
  TResult? getAlreadtExistsScopedValueResult<TResult,
      TScopedValue extends ScopedValue<TResult>>({
    bool listen = false,
    Object? name,
    bool recursive = true,
  }) {
    final res = super.getAlreadtExistsScopedValueResult<TResult, TScopedValue>(
      listen: listen,
      name: name,
    );
    if (res != null || !recursive) {
      return res;
    }
    return _ScopedScope.maybeOf(_context)
        ?._widgetListener
        .getAlreadtExistsScopedValueResult<TResult, TScopedValue>(
          listen: listen,
          name: name,
        );
  }
}

/// An object to monitor [ScopedValue] in the widget.
///
/// [container] to obtain a [ScopedValueContainer] and pass the change notification sent from the [ScopedValue] stored in the container to the associated widget.
///
/// [getScopedValueResult] associates [ScopedValue] and reads the result.
///
/// [ScopedValue]をウィジェット中で監視するためのオブジェクト。
///
/// [container]で[ScopedValueContainer]を取得しそこに保存されている[ScopedValue]から送られた変更通知を関連付けれられたウィジェットに渡します。
///
/// [getScopedValueResult]で[ScopedValue]の関連付けと結果の読み取りを行ないます。
abstract class ScopedValueListener {
  ScopedValueListener._({
    required BuildContext context,
    required VoidCallback callback,
    required AppRef appRef,
    ScopedValueContainer? container,
    ScopedLoggerScope scope = ScopedLoggerScope.widget,
  })  : _scope = scope,
        _appRef = appRef,
        _context = context,
        _callback = callback,
        _container = container;

  final BuildContext _context;
  final VoidCallback _callback;
  final ScopedValueContainer? _container;
  ScopedValueContainer? _containerCache;
  final Set<ScopedValueState> _watched = {};

  late final AppRef _appRef;
  // AppRef get _appRef {
  //   return _AppScopedScope.of(_context).widget.appRef;
  // }

  @protected
  final ScopedLoggerScope _scope;

  @protected
  String? get _managedBy {
    return _context.widget.toString();
  }

  String? __managedBy;

  @protected
  String get _listenedBy {
    return _context.widget.toString();
  }

  String? __listendBy;

  /// [ScopedValueContainer] that stores [ScopedValue].
  ///
  /// [ScopedValue]を保存している[ScopedValueContainer]。
  ScopedValueContainer get container {
    if (_containerCache != null) {
      return _containerCache!;
    }
    assert(_container != null, "[ScopedValueContainer] is not passed.");
    return _containerCache = _container!;
  }

  /// [TScopedValue] by passing [provider] and returns the result.
  ///
  /// If [listen] is `true`, then it should be associated with the widget to notify it of changes.
  ///
  /// [name] so that they can be recognized as different objects even if they have the same type.
  ///
  /// [provider]を渡すことにより[TScopedValue]を取得し、その結果を返します。
  ///
  /// [listen]が`true`の場合、ウィジェットに関連付けて変更を通知するようにします。
  ///
  /// [name]を指定すると型が同じ場合でも別のオブジェクトとして認識できるようにすることが可能です。
  TResult
      getScopedValueResult<TResult, TScopedValue extends ScopedValue<TResult>>(
    TScopedValue Function() provider, {
    void Function(ScopedValueState<TResult, TScopedValue> state)? onInit,
    void Function(ScopedValueState<TResult, TScopedValue> state)? onUpdate,
    bool listen = false,
    Object? name,
  }) {
    __listendBy ??= _listenedBy;
    __managedBy ??= _managedBy;
    final state = container.getScopedValueState<TResult, TScopedValue>(
      provider,
      onInit: (state) {
        if (state.disposed) {
          return;
        }
        _watched.add(state);
        state._addListener(this, listen ? _callback : null);
        state._sendLog(ScopedLoggerEvent.listen, additionalParameter: {
          ScopedLoggerEvent.listenedKey: __listendBy,
        });
        onInit?.call(state);
      },
      onUpdate: (state) {
        if (state.disposed) {
          return;
        }
        _watched.add(state);
        state._addListener(this, listen ? _callback : null);
        onUpdate?.call(state);
      },
      name: name,
      scope: _scope,
      managedBy: __managedBy,
      loggerAdapters: _appRef.loggerAdapters,
    );
    return state.build();
  }

  /// Retrieves the [ScopedValueState] associated with the [TScopedValue] already stored in the [ScopedValueContainer] and returns the result.
  ///
  /// Returns [Null] if [TScopedValue] does not exist.
  ///
  /// If [TScopedValue] was saved with [name], specify the same [name].
  ///
  /// If [listen] is `true`, then it should be associated with the widget to notify it of changes.
  ///
  /// If [recursive] is `true`, the search is recursive from child to parent in the same scope.
  ///
  /// [ScopedValueState.setState], [ScopedValueState.initValue] and [ScopedValueState.didUpdateValue] are not executed.
  ///
  /// [ScopedValueContainer]にすでに保存されている[TScopedValue]に関連する[ScopedValueState]を取得し、その結果を返します。
  ///
  /// [TScopedValue]が存在しない場合は[Null]を返します。
  ///
  /// [name]を指定して[TScopedValue]を保存していた場合、同じ[name]を指定してください。
  ///
  /// [listen]が`true`の場合、ウィジェットに関連付けて変更を通知するようにします。
  ///
  /// [recursive]が`true`な場合、同じスコープの子から親へと再帰的に検索します。
  ///
  /// [ScopedValueState.setState]や[ScopedValueState.initValue]、[ScopedValueState.didUpdateValue]は実行されません。
  TResult? getAlreadtExistsScopedValueResult<TResult,
      TScopedValue extends ScopedValue<TResult>>({
    bool listen = false,
    Object? name,
    bool recursive = true,
  }) {
    final state =
        container.getAlreadyExistsScopedValueState<TResult, TScopedValue>(
      onUpdate: (state) {
        if (state.disposed) {
          return;
        }
        _watched.add(state);
        state._addListener(this, listen ? _callback : null);
      },
      name: name,
    );
    return state?.build();
  }

  /// Executed when the widget is destroyed.
  ///
  /// ScopedValueState.dispose] is executed on the monitored [ScopedValue] and the retained [ScopedValueContainer].
  ///
  /// ウィジェットが破棄される際に実行します。
  ///
  /// 監視している[ScopedValue]と保持している[ScopedValueContainer]を対象に[ScopedValueState.dispose]が実行されます。
  void dispose() {
    for (final watched in _watched) {
      if (watched.disposed) {
        continue;
      }
      watched._removeListener(this, _callback);
      watched._sendLog(ScopedLoggerEvent.unlisten, additionalParameter: {
        ScopedLoggerEvent.listenedKey: __listendBy,
      });
      watched.deactivate();
      if (watched.autoDisposeWhenUnreferenced && watched._listeners.isEmpty) {
        container.remove(watched);
      }
    }
    _watched.clear();
    if (_container != null) {
      _container.dispose();
    }
  }
}
