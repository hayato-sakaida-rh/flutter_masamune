import 'dart:io';

import 'package:katana/katana.dart';

/// Class for retrieving and saving files in `android/app/build.gradle`.
///
/// `android/app/build.gradle`のファイルを取得して保存するためのクラス。
class AppGradle {
  AppGradle();

  /// Original text data.
  ///
  /// 元のテキストデータ。
  String get rawData => _rawData;
  late String _rawData;

  /// Data reading part of `xxx.properties`.
  ///
  /// `xxx.properties`のデータ読み込み部分。
  List<GradleLoadProperties> get loadProperties => _loadProperties;
  late List<GradleLoadProperties> _loadProperties;

  /// Data in the `android` section.
  ///
  /// `android`セクションのデータ。
  GradleAndroid? get android => _android;
  GradleAndroid? _android;

  /// Data loading.
  ///
  /// データの読み込み。
  Future<void> load() async {
    final gradle = File("android/app/build.gradle");
    _rawData = await gradle.readAsString();
    _loadProperties = GradleLoadProperties._load(_rawData);
    _android = GradleAndroid._load(_rawData);
  }

  /// Data storage.
  ///
  /// データの保存。
  Future<void> save() async {
    if (_rawData.isEmpty) {
      throw Exception("No value. Please load data with [load].");
    }
    _rawData = GradleLoadProperties._save(_rawData, _loadProperties);
    if (_android != null) {
      _rawData = GradleAndroid._save(_rawData, _android!);
    }
    final gradle = File("android/app/build.gradle");
    await gradle.writeAsString(_rawData);
  }
}

/// Data reading part of `xxx.properties`.
///
/// `xxx.properties`のデータ読み込み部分。
class GradleLoadProperties {
  /// Data reading part of `xxx.properties`.
  ///
  /// `xxx.properties`のデータ読み込み部分。
  factory GradleLoadProperties({
    required String path,
    required String name,
    required String file,
  }) {
    return GradleLoadProperties._(
      name: name,
      path: path,
      file: file,
    );
  }
  GradleLoadProperties._({
    required this.name,
    required this.file,
    required this.path,
  });

  static List<GradleLoadProperties> _load(String content) {
    final region = RegExp(
      r"^([\s\S]*?)def localProperties = new Properties\(\)",
    ).firstMatch(content);
    if (region == null) {
      return [];
    }
    return RegExp(
      r"def (?<name>[a-zA-Z_-]+) = new Properties\(\)([\s\S]*?)def (?<file>[a-zA-Z_-]+) = rootProject.file\('(?<path>[a-zA-Z./_-]+)'\)([\s\S]*?)if \(([a-zA-Z_-]+).exists\(\)\) {([\s\S]*?)([a-zA-Z_-]+).withReader\('UTF-8'\) { reader ->([\s\S]*?)([a-zA-Z_-]+).load\(reader\)([\s\S]*?)}([\s\S]*?)}",
    ).allMatches(region.group(1) ?? "").mapAndRemoveEmpty((e) {
      return GradleLoadProperties._(
        file: e.namedGroup("file") ?? "",
        name: e.namedGroup("name") ?? "",
        path: e.namedGroup("path") ?? "",
      );
    });
  }

  static String _save(String content, List<GradleLoadProperties> list) {
    final code = list.map((e) => e.toString()).join("\n");
    return content.replaceAll(
      RegExp(
        r"^([\s\S]*?)def localProperties = new Properties\(\)",
      ),
      "$code\n\ndef localProperties = new Properties()",
    );
  }

  /// Variable name of the property file.
  ///
  /// プロパティファイルの変数名。
  final String name;

  /// Property file name.
  ///
  /// プロパティファイル名。
  final String file;

  /// Path of the property file.
  ///
  /// プロパティファイルのパス。
  final String path;

  @override
  String toString() {
    return "def $name = new Properties()\ndef $file = rootProject.file('$path')\nif ($file.exists()) {\n    $file.withReader('UTF-8') { reader ->\n        $name.load(reader)\n    }\n}";
  }
}

/// Data in the `android` section.
///
/// `android`セクションのデータ。
class GradleAndroid {
  /// Data in the `android` section.
  ///
  /// `android`セクションのデータ。
  GradleAndroid({
    required this.buildTypes,
    required this.compileOptions,
    required this.compileSdkVersion,
    required this.defaultConfig,
    required this.kotlinOptions,
    this.ndkVersion,
    this.buildToolsVersion,
    this.signingConfigs,
    required this.sourceSets,
  });
  static final _regExp = RegExp(r"android {([\s\S]+?)\n}");

  static GradleAndroid _load(String content) {
    final region = _regExp.firstMatch(content)?.group(1) ?? "";
    final compileSdkVersion = RegExp("compileSdkVersion ([a-zA-Z0-9_\"'.-]+)")
            .firstMatch(region)
            ?.group(1) ??
        "0";
    final buildToolsVersion = RegExp("buildToolsVersion ([a-zA-Z0-9_\"'.-]+)")
        .firstMatch(region)
        ?.group(1);
    final ndkVersion =
        RegExp("ndkVersion ([a-zA-Z0-9_\"'.-]+)").firstMatch(region)?.group(1);
    return GradleAndroid(
      buildTypes: GradleAndroidBuildTypes._load(region),
      signingConfigs: GradleAndroidSigningConfigs._load(region),
      compileOptions: GradleAndroidCompileOptions._load(region),
      compileSdkVersion: compileSdkVersion,
      defaultConfig: GradleAndroidDefaultConfig._load(region),
      buildToolsVersion: buildToolsVersion,
      kotlinOptions: GradleAndroidKotlinOptions._load(region),
      ndkVersion: ndkVersion,
      sourceSets: GradleAndroidSourceSet._load(region),
    );
  }

  static String _save(String content, GradleAndroid data) {
    return content.replaceAll(_regExp, "android {\n$data\n}");
  }

  /// SDK version of the compilation.
  ///
  /// コンパイルのSDKバージョン。
  String compileSdkVersion;

  /// NDK Version.
  ///
  /// NDKのバージョン。
  String? ndkVersion;

  /// Build tool version.
  ///
  /// ビルドツールのバージョン。
  String? buildToolsVersion;

  /// Compile Option Setting.
  ///
  /// コンパイルオプション設定。
  GradleAndroidCompileOptions compileOptions;

  /// Kotlin option settings.
  ///
  /// Kotlinのオプション設定。
  GradleAndroidKotlinOptions kotlinOptions;

  /// Source setting.
  ///
  /// ソースの設定。
  List<GradleAndroidSourceSet> sourceSets;

  /// Default settings.
  ///
  /// デフォルトの設定。
  GradleAndroidDefaultConfig defaultConfig;

  /// Build type setting.
  ///
  /// ビルドタイプの設定。
  GradleAndroidBuildTypes buildTypes;

  /// Signature settings.
  ///
  /// 署名の設定。
  GradleAndroidSigningConfigs? signingConfigs;

  @override
  String toString() {
    return "    compileSdkVersion $compileSdkVersion\n${buildToolsVersion != null ? "    buildToolsVersion $buildToolsVersion\n" : ""}${ndkVersion != null ? "    ndkVersion $ndkVersion\n" : ""}\n$compileOptions\n$kotlinOptions\n${sourceSets.isNotEmpty ? "    sourceSets {\n${sourceSets.map((e) => e.toString()).join("\n")}\n    }\n\n" : ""}$defaultConfig\n${signingConfigs != null ? "$signingConfigs\n" : ""}\n$buildTypes";
  }
}

/// Compile Option Setting.
///
/// コンパイルオプション設定。
class GradleAndroidCompileOptions {
  /// Compile Option Setting.
  ///
  /// コンパイルオプション設定。
  GradleAndroidCompileOptions({
    required this.sourceCompatibility,
    required this.targetCompatibility,
  });
  static final _regExp = RegExp(r"compileOptions {([\s\S]+?)}");

  /// Data for `sourceCompatibility`.
  ///
  /// `sourceCompatibility`のデータ。
  String sourceCompatibility;

  /// Data for `targetCompatibility`.
  ///
  /// `targetCompatibility`のデータ。
  String targetCompatibility;

  static GradleAndroidCompileOptions _load(String content) {
    final region = _regExp.firstMatch(content)?.group(1) ?? "";
    final sourceCompatibility =
        RegExp("sourceCompatibility ([a-zA-Z0-9_\"'.-]+)")
                .firstMatch(region)
                ?.group(1) ??
            "";
    final targetCompatibility =
        RegExp("targetCompatibility ([a-zA-Z0-9_\"'.-]+)")
                .firstMatch(region)
                ?.group(1) ??
            "";
    return GradleAndroidCompileOptions(
      sourceCompatibility: sourceCompatibility,
      targetCompatibility: targetCompatibility,
    );
  }

  @override
  String toString() {
    return "    compileOptions {\n        sourceCompatibility $sourceCompatibility\n        targetCompatibility $targetCompatibility\n    }\n";
  }
}

/// Kotlin option settings.
///
/// Kotlinのオプション設定。
class GradleAndroidKotlinOptions {
  /// Kotlin option settings.
  ///
  /// Kotlinのオプション設定。
  GradleAndroidKotlinOptions({
    required this.jvmTarget,
  });
  static final _regExp = RegExp(r"kotlinOptions {([\s\S]+?)}");

  /// Setting of `jvmTarget`.
  ///
  /// `jvmTarget`の設定。
  String jvmTarget;

  static GradleAndroidKotlinOptions _load(String content) {
    final region = _regExp.firstMatch(content)?.group(1) ?? "";
    final jvmTarget = RegExp("jvmTarget = ([a-zA-Z0-9_\"'.-]+)")
            .firstMatch(region)
            ?.group(1) ??
        "";
    return GradleAndroidKotlinOptions(
      jvmTarget: jvmTarget,
    );
  }

  @override
  String toString() {
    return "    kotlinOptions {\n        jvmTarget = $jvmTarget\n    }\n";
  }
}

/// Source setting.
///
/// ソースの設定。
class GradleAndroidSourceSet {
  /// Source setting.
  ///
  /// ソースの設定。
  GradleAndroidSourceSet({
    required this.source,
    required this.target,
    required this.symbol,
  });
  static final _regExp = RegExp(r"sourceSets {([\s\S]+?)}");

  /// Source Target.
  ///
  /// ソースのターゲット。
  String target;

  /// Additive Method.
  ///
  /// 加算方法。
  String symbol;

  /// Path of the source data.
  ///
  /// ソースデータのパス。
  String source;

  static List<GradleAndroidSourceSet> _load(String content) {
    final region = _regExp.firstMatch(content)?.group(1) ?? "";
    return RegExp(
      "(?<target>[a-zA-Z_.-]+) (?<symbol>[+=]+) (?<source>[a-zA-Z0-9_/\"'.-]+)",
    ).allMatches(region).mapAndRemoveEmpty((e) {
      return GradleAndroidSourceSet(
        source: e.namedGroup("source") ?? "",
        symbol: e.namedGroup("symbol") ?? "",
        target: e.namedGroup("target") ?? "",
      );
    });
  }

  @override
  String toString() {
    return "        $target $symbol $source";
  }
}

/// Default settings.
///
/// デフォルトの設定。
class GradleAndroidDefaultConfig {
  /// Default settings.
  ///
  /// デフォルトの設定。
  GradleAndroidDefaultConfig({
    required this.applicationId,
    required this.minSdkVersion,
    required this.targetSdkVersion,
    required this.versionCode,
    required this.versionName,
    this.testInstrumentationRunner,
    this.multiDexEnabled,
    this.resValues = const [],
  });
  static final _regExp = RegExp(r"defaultConfig {([\s\S]+?)}");

  /// Application ID.
  ///
  /// アプリケーションID。
  String applicationId;

  /// Minimum SDK version.
  ///
  /// 最小のSDKバージョン。
  String minSdkVersion;

  /// SDK version of the main target.
  ///
  /// メインターゲットのSDKバージョン。
  String targetSdkVersion;

  /// App version code.
  ///
  /// アプリのバージョンコード。
  String versionCode;

  /// Version name of the application.
  ///
  /// アプリのバージョン名。
  String versionName;

  /// Configuration of `testInstrumentationRunner`.
  ///
  /// `testInstrumentationRunner`の設定。
  String? testInstrumentationRunner;

  /// Set `multiDexEnabled`.
  ///
  /// `multiDexEnabled`の設定。
  String? multiDexEnabled;

  /// Setting of `resValue` (multiple settings possible).
  ///
  /// `resValue`の設定（複数設定可能）。
  List<String> resValues;

  static GradleAndroidDefaultConfig _load(String content) {
    final region = _regExp.firstMatch(content)?.group(1) ?? "";
    final applicationId =
        RegExp("applicationId (.+)").firstMatch(region)?.group(1) ?? "";
    final minSdkVersion =
        RegExp("minSdkVersion (.+)").firstMatch(region)?.group(1) ?? "";
    final targetSdkVersion =
        RegExp("targetSdkVersion (.+)").firstMatch(region)?.group(1) ?? "";
    final versionCode =
        RegExp("versionCode (.+)").firstMatch(region)?.group(1) ?? "";
    final versionName =
        RegExp("versionName (.+)").firstMatch(region)?.group(1) ?? "";
    final testInstrumentationRunner =
        RegExp("testInstrumentationRunner (.+)").firstMatch(region)?.group(1);
    final multiDexEnabled =
        RegExp("multiDexEnabled (.+)").firstMatch(region)?.group(1);
    final resValues = RegExp("resValue (.+)")
        .allMatches(region)
        .mapAndRemoveEmpty((e) => e.group(1));
    return GradleAndroidDefaultConfig(
      applicationId: applicationId,
      minSdkVersion: minSdkVersion,
      targetSdkVersion: targetSdkVersion,
      versionCode: versionCode,
      versionName: versionName,
      testInstrumentationRunner: testInstrumentationRunner,
      multiDexEnabled: multiDexEnabled,
      resValues: resValues,
    );
  }

  @override
  String toString() {
    return "    defaultConfig {\n        applicationId $applicationId\n        minSdkVersion $minSdkVersion\n        targetSdkVersion $targetSdkVersion\n        versionCode $versionCode\n        versionName $versionName\n${testInstrumentationRunner.isNotEmpty ? "        testInstrumentationRunner $testInstrumentationRunner\n" : ""}${multiDexEnabled.isNotEmpty ? "        multiDexEnabled $multiDexEnabled\n" : ""}${resValues.isNotEmpty ? "${resValues.map((e) => "        resValue $e").join("\n")}\n" : ""}    }\n";
  }
}

/// Build type setting.
///
/// ビルドタイプの設定。
class GradleAndroidBuildTypes {
  /// Build type setting.
  ///
  /// ビルドタイプの設定。
  GradleAndroidBuildTypes({
    this.release,
    this.debug,
  });
  static final _regExp = RegExp(r"buildTypes {([\s\S]+)}");
  static final _releaseRegExp = RegExp(r"release {([\s\S]+?)}");
  static final _debugRegExp = RegExp(r"debug {([\s\S]+?)}");

  /// Settings at the time of release.
  ///
  /// リリース時の設定。
  GradleAndroidBuildType? release;

  /// Settings during debugging.
  ///
  /// デバッグ時の設定。
  GradleAndroidBuildType? debug;

  static GradleAndroidBuildTypes _load(String content) {
    final region = _regExp.firstMatch(content)?.group(1) ?? "";
    final release = _releaseRegExp.firstMatch(region)?.group(1);
    final debug = _debugRegExp.firstMatch(region)?.group(1);
    return GradleAndroidBuildTypes(
      release: release != null ? GradleAndroidBuildType._load(release) : null,
      debug: debug != null ? GradleAndroidBuildType._load(debug) : null,
    );
  }

  @override
  String toString() {
    if (release == null && debug == null) {
      return "";
    }
    return "    buildTypes {\n${release != null ? "        release {\n$release        }\n" : ""}${debug != null ? "        debug {\n$debug        }\n" : ""}    }\n";
  }
}

/// Configuration class for the contents of [GradleAndroidBuildTypes].
///
/// [GradleAndroidBuildTypes]の中身の設定クラス。
class GradleAndroidBuildType {
  /// Configuration class for the contents of [GradleAndroidBuildTypes].
  ///
  /// [GradleAndroidBuildTypes]の中身の設定クラス。
  GradleAndroidBuildType({
    required this.signingConfig,
    this.minifyEnabled,
    this.shrinkResources,
  });

  /// Signature Method.
  ///
  /// 署名方法。
  String signingConfig;

  /// Set `minifyEnabled`.
  ///
  /// `minifyEnabled`の設定。
  String? minifyEnabled;

  /// Set `shrinkResources`.
  ///
  /// `shrinkResources`の設定。
  String? shrinkResources;

  static GradleAndroidBuildType _load(String content) {
    final signingConfig =
        RegExp("signingConfig (.+)").firstMatch(content)?.group(1) ?? "";
    final minifyEnabled =
        RegExp("minifyEnabled (.+)").firstMatch(content)?.group(1);
    final shrinkResources =
        RegExp("shrinkResources (.+)").firstMatch(content)?.group(1);
    return GradleAndroidBuildType(
      signingConfig: signingConfig,
      minifyEnabled: minifyEnabled,
      shrinkResources: shrinkResources,
    );
  }

  @override
  String toString() {
    return "            signingConfig $signingConfig\n${minifyEnabled != null ? "            minifyEnabled $minifyEnabled\n" : ""}${shrinkResources != null ? "            shrinkResources $shrinkResources\n" : ""}";
  }
}

/// Signature settings.
///
/// 署名の設定。
class GradleAndroidSigningConfigs {
  /// Signature settings.
  ///
  /// 署名の設定。
  GradleAndroidSigningConfigs({
    this.release,
    this.debug,
  });
  static final _regExp = RegExp(r"signingConfigs {([\s\S]+)}");
  static final _releaseRegExp = RegExp(r"release {([\s\S]+?)}");
  static final _debugRegExp = RegExp(r"debug {([\s\S]+?)}");

  /// Settings at the time of release.
  ///
  /// リリース時の設定。
  GradleAndroidSigningConfig? release;

  /// Settings during debugging.
  ///
  /// デバッグ時の設定。
  GradleAndroidSigningConfig? debug;

  static GradleAndroidSigningConfigs _load(String content) {
    final region = _regExp.firstMatch(content)?.group(1) ?? "";
    final release = _releaseRegExp.firstMatch(region)?.group(1);
    final debug = _debugRegExp.firstMatch(region)?.group(1);
    return GradleAndroidSigningConfigs(
      release:
          release != null ? GradleAndroidSigningConfig._load(release) : null,
      debug: debug != null ? GradleAndroidSigningConfig._load(debug) : null,
    );
  }

  @override
  String toString() {
    if (release == null && debug == null) {
      return "";
    }
    return "    signingConfigs {\n${release != null ? "        release {\n$release        }\n" : ""}${debug != null ? "        debug {\n$debug        }\n" : ""}    }\n";
  }
}

/// Configuration class for the contents of [GradleAndroidSigningConfigs].
///
/// [GradleAndroidSigningConfigs]の中身の設定クラス。
class GradleAndroidSigningConfig {
  /// Configuration class for the contents of [GradleAndroidSigningConfigs].
  ///
  /// [GradleAndroidSigningConfigs]の中身の設定クラス。
  GradleAndroidSigningConfig({
    required this.keyAlias,
    required this.keyPassword,
    required this.storeFile,
    required this.storePassword,
  });

  /// Keystore alias.
  ///
  /// Keystoreのエイリアス。
  String keyAlias;

  /// Keystore alias password.
  ///
  /// Keystoreのエイリアスパスワード。
  String keyPassword;

  /// Keystore file path.
  ///
  /// Keystoreのファイルパス。
  String storeFile;

  /// Keystore password.
  ///
  /// Keystoreのパスワード。
  String storePassword;

  static GradleAndroidSigningConfig _load(String content) {
    final keyAlias =
        RegExp("keyAlias (.+)").firstMatch(content)?.group(1) ?? "";
    final keyPassword =
        RegExp("keyPassword (.+)").firstMatch(content)?.group(1) ?? "";
    final storeFile =
        RegExp("storeFile (.+)").firstMatch(content)?.group(1) ?? "";
    final storePassword =
        RegExp("storePassword (.+)").firstMatch(content)?.group(1) ?? "";
    return GradleAndroidSigningConfig(
      keyAlias: keyAlias,
      keyPassword: keyPassword,
      storeFile: storeFile,
      storePassword: storePassword,
    );
  }

  @override
  String toString() {
    return "            keyAlias $keyAlias\n            keyPassword $keyPassword\n            storeFile $storeFile\n            storePassword $storePassword\n";
  }
}
