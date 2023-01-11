part of masamune;

/// Default locale.
///
/// デフォルトのロケール。
const kDefaultLocales = [Locale("en", "US")];

/// MaterialApp] for Masamune Framework.
///
/// It encompasses the XXScope widget used in a series of katana packages.
///
/// You can pass the [AppRef] used in `katana_scoped` in [appRef].
///
/// You can pass [AppThemeData] used in `katana_theme` in [theme]. You can also specify [ThemeMode] in [themeMode].
///
/// You can pass [AppLocalizeBase] used by `katana_localize` in [localize].
///
/// Other adapters for data and authentication such as [modelAdapter] and [authAdapter] can be passed.
///
/// You can pass the [AppRouter] used by `katana_router` in [routerConfig].
///
/// If you do not pass [routerConfig], you can also use Flutter"s native routing functionality as you normally would with [MaterialApp], using [routes], [initialRoute], [onGenerateRoute], [onGenerateInitialRoutes], [onUnknownRoute ], [builder], [navigatorObservers], and [scaffoldMessengerKey] to take advantage of Flutter"s native routing capabilities.
///
/// You can also use [home] to display a single widget. (available in Example, for example).
///
/// The application title can be set with [title] and [onGenerateTitle].
///
/// The debug banner can be displayed with [debugShowCheckedModeBanner] and the performance overlay can be displayed with [showPerformanceOverlay].
///
/// Masamune Framework用の[MaterialApp]。
///
/// 一連のkatanaのパッケージで利用されているXXScopeのウィジェットを内包しています。
///
/// [appRef]で`katana_scoped`で使われている[AppRef]を渡すことができます。
///
/// [theme]で`katana_theme`で使われている[AppThemeData]を渡すことができます。また、[themeMode]で[ThemeMode]をあわせて指定できます。
///
/// [localize]で`katana_localize`で利用されている[AppLocalizeBase]を渡すことができます。
///
/// その他、[modelAdapter]や[authAdapter]といったデータや認証用のアダプターを渡すことが可能です。
///
/// [routerConfig]で`katana_router`で使われている[AppRouter]を渡すことができます。
///
/// [routerConfig]を渡さなかった場合、通常の[MaterialApp]と同じ様に[routes]や[initialRoute]、[onGenerateRoute]、[onGenerateInitialRoutes]、[onUnknownRoute]、[builder]、[navigatorObservers]、[scaffoldMessengerKey]を用いてFlutterネイティブのルーティング機能を利用することも可能です。
///
/// また、[home]を用いて単一のウィジェットを表示することができます。（Exampleなどで利用可能です）
///
/// [title]、[onGenerateTitle]でアプリタイトルを設定することが可能です。
///
/// [debugShowCheckedModeBanner]でデバッグ用のバナーを表示することができ、[showPerformanceOverlay]でパフォーマンスのオーバーレイを表示することができます。
@immutable
class MasamuneApp extends StatelessWidget {
  /// MaterialApp] for Masamune Framework.
  ///
  /// It encompasses the XXScope widget used in a series of katana packages.
  ///
  /// You can pass the [AppRef] used in `katana_scoped` in [appRef].
  ///
  /// You can pass [AppThemeData] used in `katana_theme` in [theme]. You can also specify [ThemeMode] in [themeMode].
  ///
  /// You can pass [AppLocalizeBase] used by `katana_localize` in [localize].
  ///
  /// Other adapters for data and authentication such as [modelAdapter] and [authAdapter] can be passed.
  ///
  /// You can pass the [AppRouter] used by `katana_router` in [routerConfig].
  ///
  /// If you do not pass [routerConfig], you can also use Flutter"s native routing functionality as you normally would with [MaterialApp], using [routes], [initialRoute], [onGenerateRoute], [onGenerateInitialRoutes], [onUnknownRoute ], [builder], [navigatorObservers], and [scaffoldMessengerKey] to take advantage of Flutter"s native routing capabilities.
  ///
  /// You can also use [home] to display a single widget. (available in Example, for example).
  ///
  /// The application title can be set with [title] and [onGenerateTitle].
  ///
  /// The debug banner can be displayed with [debugShowCheckedModeBanner] and the performance overlay can be displayed with [showPerformanceOverlay].
  ///
  /// Masamune Framework用の[MaterialApp]。
  ///
  /// 一連のkatanaのパッケージで利用されているXXScopeのウィジェットを内包しています。
  ///
  /// [appRef]で`katana_scoped`で使われている[AppRef]を渡すことができます。
  ///
  /// [theme]で`katana_theme`で使われている[AppThemeData]を渡すことができます。また、[themeMode]で[ThemeMode]をあわせて指定できます。
  ///
  /// [localize]で`katana_localize`で利用されている[AppLocalizeBase]を渡すことができます。
  ///
  /// その他、[modelAdapter]や[authAdapter]といったデータや認証用のアダプターを渡すことが可能です。
  ///
  /// [routerConfig]で`katana_router`で使われている[AppRouter]を渡すことができます。
  ///
  /// [routerConfig]を渡さなかった場合、通常の[MaterialApp]と同じ様に[routes]や[initialRoute]、[onGenerateRoute]、[onGenerateInitialRoutes]、[onUnknownRoute]、[builder]、[navigatorObservers]、[scaffoldMessengerKey]を用いてFlutterネイティブのルーティング機能を利用することも可能です。
  ///
  /// また、[home]を用いて単一のウィジェットを表示することができます。（Exampleなどで利用可能です）
  ///
  /// [title]、[onGenerateTitle]でアプリタイトルを設定することが可能です。
  ///
  /// [debugShowCheckedModeBanner]でデバッグ用のバナーを表示することができ、[showPerformanceOverlay]でパフォーマンスのオーバーレイを表示することができます。
  const MasamuneApp({
    super.key,
    this.appRef,
    this.authAdapter,
    this.storageAdapter,
    this.theme,
    this.localize,
    this.routerConfig,
    this.modelAdapter = const RuntimeModelAdapter(),
    this.debugShowCheckedModeBanner = true,
    this.showPerformanceOverlay = false,
    this.title = "",
    this.themeMode = ThemeMode.system,
    this.routes = const <String, WidgetBuilder>{},
    this.navigatorObservers = const <NavigatorObserver>[],
    this.scaffoldMessengerKey,
    this.onGenerateTitle,
    this.home,
    this.initialRoute,
    this.onGenerateRoute,
    this.onGenerateInitialRoutes,
    this.onUnknownRoute,
    this.builder,
  });

  /// Theme data used by `katana_theme`.
  ///
  /// `katana_theme`で利用されるテーマデータ。
  final AppThemeData? theme;

  /// Data for localization used by `katana_localize`.
  ///
  /// `katana_localize`で利用されるローカライズ用のデータ。
  final AppLocalizeBase? localize;

  /// Ref for application scope called by `katana_scoped`.
  ///
  /// `katana_scoped`で呼び出されるアプリケーションスコープ用のref。
  final AppRef? appRef;

  /// Adapter for authentication used by `katana_auth`.
  ///
  /// `katana_auth`で利用される認証用のアダプター。
  final AuthAdapter? authAdapter;

  /// Adapter for database used by `katana_model`.
  ///
  /// `katana_model`で利用されるデータベース用のアダプター。
  final ModelAdapter? modelAdapter;

  /// Adapter for file storage used by `katana_storage`.
  ///
  /// `katana_storage`で利用されるファイルストレージ用のアダプター。
  final StorageAdapter? storageAdapter;

  /// Config for router used by `katana_router`.
  ///
  /// `katana_router`で利用されるルーター用のコンフィグ。
  final RouterConfig<Object>? routerConfig;

  /// [GlobalKey] for storing [ScaffoldMessengerState].
  ///
  /// This is used when putting out a SnackBar.
  ///
  /// [ScaffoldMessengerState]を格納するための[GlobalKey]。
  ///
  /// SnackBarを出したりする場合に利用します。
  final GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey;

  /// If this is set to `true`, a banner is displayed in the upper right corner in debug mode.
  ///
  /// これが`true`になっている場合、デバッグモード時右上にバナーが表示されます。
  final bool debugShowCheckedModeBanner;

  /// If this is `true`, the performance status is displayed in an overlay.
  ///
  /// これが`true`になっている場合、パフォーマンスの状況がオーバーレイで表示されます。
  final bool showPerformanceOverlay;

  /// Specify the title of the application.
  ///
  /// If you want to dynamically generate the title, use [onGenerateTitle].
  ///
  /// アプリのタイトルを指定します。
  ///
  /// タイトルを動的に出したい場合は[onGenerateTitle]を利用してください。
  final String title;

  /// Specify the title of the application dynamically.
  ///
  /// Return the title in the return value of the callback.
  ///
  /// アプリのタイトルを動的に指定します。
  ///
  /// コールバックの戻り値でタイトルを返してください。
  final String Function(BuildContext)? onGenerateTitle;

  /// Specify the theme mode for the application.
  ///
  /// If [ThemeMode.system], it follows the system settings.
  ///
  /// アプリのテーマモードを指定します。
  ///
  /// [ThemeMode.system]だとシステムの設定に従います。
  final ThemeMode? themeMode;

  /// Specify the widget to be displayed first.
  ///
  /// If this is not [Null], priority is given even if [routerConfig] is specified.
  ///
  /// 最初に表示するウィジェットを指定します。
  ///
  /// これが[Null]でない場合、[routerConfig]が指定された場合でも優先的に表示されます。
  final Widget? home;

  /// If [routerConfig] is not specified or [home] is specified, this is used to specify subsequent routing.
  ///
  /// Specify a route name as the key for [Map] and a callback that returns the widget to be displayed as the value.
  ///
  /// [routerConfig]が指定されていない場合や[home]が指定されている場合、その後のルーティングを指定する際に利用します。
  ///
  /// [Map]のキーにルート名を指定し、値に表示するウィジェットを返すコールバックを指定します。
  final Map<String, Widget Function(BuildContext)> routes;

  /// Specifies the initial route name when [routes] is used.
  ///
  /// [routes]を用いる場合の初期ルート名を指定します。
  final String? initialRoute;

  /// If [routerConfig] is not specified, a callback that is executed when the route is generated.
  ///
  /// The route information to be generated is passed to [routeSettings].
  ///
  /// Return the generated [Route] in the return value.
  ///
  /// [routerConfig]が指定されていない場合、ルートが生成される際に実行されるコールバック。
  ///
  /// [routeSettings]に生成したいルートの情報が渡されます。
  ///
  /// 戻り値に生成した[Route]を返してください。
  final Route<dynamic>? Function(RouteSettings routeSettings)? onGenerateRoute;

  /// If [routerConfig] is not specified, this callback is executed when the first route is configured.
  ///
  /// The route name is passed to [routePath] for the first time.
  ///
  /// Return a list of generated [Route] in the return value.
  ///
  /// [routerConfig]が指定されていない場合、初回のルートが設定されている場合に実行されるコールバック。
  ///
  /// [routePath]に初回のルート名が渡されます。
  ///
  /// 戻り値に生成した[Route]のリストを返してください。
  final List<Route<dynamic>> Function(String routePath)?
      onGenerateInitialRoutes;

  /// If [routerConfig] is not specified, this callback is called when a route name not listed in [routes] is queried.
  ///
  /// The route information to be generated is passed to [routeSettings].
  ///
  /// Return the generated [Route] in the return value.
  ///
  /// [routerConfig]が指定されていない場合、[routes]に記載されていないルート名がクエリされたときに呼ばれるコールバック。
  ///
  /// [routeSettings]に生成したいルートの情報が渡されます。
  ///
  /// 戻り値に生成した[Route]を返してください。
  final Route<dynamic>? Function(RouteSettings routeSettings)? onUnknownRoute;

  /// Observer to monitor navigation transitions.
  ///
  /// Enabled when [routerConfig] is not specified.
  ///
  /// When specifying [routerConfig], specify it as an argument to [RouterConfig] such as [AppRouter].
  ///
  /// ナビゲーションの遷移を監視するためのオブザーバー。
  ///
  /// [routerConfig]が指定されていない場合に有効になります。
  ///
  /// [routerConfig]を指定する際は、[AppRouter]など[RouterConfig]の引数に指定してください。
  final List<NavigatorObserver> navigatorObservers;

  /// If [routerConfig] is not specified, a callback that is executed after the widget created by [onGenerateRoute] or other methods is generated.
  ///
  /// The build context is passed to [context] and the generated widget to [child].
  ///
  /// Return a widget with [child] wrapped in the return value.
  ///
  /// [routerConfig]が指定されていない場合、[onGenerateRoute]などで作成されたウィジェットが生成された後に実行されるコールバック。
  ///
  /// [context]にビルドコンテキスト、[child]に生成されたウィジェットが渡されます。
  ///
  /// 戻り値に[child]をラッピングしたウィジェットを返してください。
  final Widget Function(BuildContext context, Widget? child)? builder;

  @override
  Widget build(BuildContext context) {
    return _buildAppStorage(
      context,
      _buildAppAuth(
        context,
        _buildModelAdapter(
          context,
          _buildAppScoped(
            context,
            _buildAppTheme(
              context,
              _buildAppLocalize(
                context,
                _buildAppRouter(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModelAdapter(BuildContext context, Widget child) {
    if (modelAdapter != null) {
      return ModelAdapterScope(
        adapter: modelAdapter!,
        child: child,
      );
    }
    return child;
  }

  Widget _buildAppScoped(BuildContext context, Widget child) {
    if (appRef != null) {
      return AppScoped(
        appRef: appRef!,
        child: child,
      );
    }
    return child;
  }

  Widget _buildAppAuth(BuildContext context, Widget child) {
    if (authAdapter != null) {
      return AuthAdapterScope(
        adapter: authAdapter!,
        child: child,
      );
    }
    return child;
  }

  Widget _buildAppTheme(BuildContext context, Widget child) {
    if (theme != null) {
      return AppThemeScope(
        theme: theme!,
        child: child,
      );
    }
    return child;
  }

  Widget _buildAppLocalize(BuildContext context, Widget child) {
    if (localize != null) {
      return LocalizeScope(
        localize: localize!,
        builder: (context, localize) => child,
      );
    }
    return child;
  }

  Widget _buildAppStorage(BuildContext context, Widget child) {
    if (storageAdapter != null) {
      return StorageAdapterScope(
        adapter: storageAdapter!,
        child: child,
      );
    }
    return child;
  }

  Widget _buildAppRouter(BuildContext context) {
    if (home != null || routerConfig == null) {
      return MaterialApp(
        locale: localize?.locale,
        supportedLocales: localize?.supportedLocales() ?? kDefaultLocales,
        localizationsDelegates: localize?.delegates(),
        localeResolutionCallback: localize?.localeResolutionCallback(),
        theme: theme?.toThemeData(),
        darkTheme: theme?.copyWithInvert().toThemeData(),
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: title,
        onGenerateTitle: onGenerateTitle,
        themeMode: themeMode,
        home: home,
        routes: routes,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        onGenerateInitialRoutes: onGenerateInitialRoutes,
        onUnknownRoute: onUnknownRoute,
        navigatorObservers: navigatorObservers,
        builder: builder,
      );
    } else {
      return MaterialApp.router(
        routerConfig: routerConfig,
        locale: localize?.locale,
        supportedLocales: localize?.supportedLocales() ?? kDefaultLocales,
        localizationsDelegates: localize?.delegates(),
        localeResolutionCallback: localize?.localeResolutionCallback(),
        theme: theme?.toThemeData(),
        darkTheme: theme?.copyWithInvert().toThemeData(),
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        showPerformanceOverlay: showPerformanceOverlay,
        scaffoldMessengerKey: scaffoldMessengerKey,
        title: title,
        onGenerateTitle: onGenerateTitle,
        themeMode: themeMode,
        builder: builder,
      );
    }
  }
}
