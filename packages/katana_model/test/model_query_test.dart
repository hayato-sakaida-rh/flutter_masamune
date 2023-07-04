// ignore_for_file: prefer_typing_uninitialized_variables

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:katana_model/katana_model.dart';

void main() {
  test("ModelQuery.hasMatch", () async {
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(key: "name", value: "test"),
      ],
    );
    expect(query.hasMatchAsObject("test"), true);
    expect(query.hasMatchAsMap({"name": "test", "text": "aaaa"}), true);
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "text": "bbbb"}
      ]),
      true,
    );
    expect(query.hasMatchAsObject("test2"), false);
    expect(query.hasMatchAsMap({"name": "text", "text": "aaaa"}), false);
    expect(
      query.hasMatchAsList([
        {"name": "text", "text": "aaaa"},
        {"name": "test2", "text": "bbbb"}
      ]),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(key: "name", value: "test"),
      ],
    );
    expect(query.hasMatchAsObject("test"), false);
    expect(query.hasMatchAsMap({"name": "test", "text": "aaaa"}), false);
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "text": "bbbb"}
      ]),
      true,
    );
    expect(query.hasMatchAsObject("test2"), true);
    expect(query.hasMatchAsMap({"name": "text", "text": "aaaa"}), true);
    expect(
      query.hasMatchAsList([
        {"name": "text", "text": "aaaa"},
        {"name": "test2", "text": "bbbb"}
      ]),
      true,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.lessThan(key: "count", value: 100),
      ],
    );
    expect(query.hasMatchAsObject(99), true);
    expect(query.hasMatchAsObject(100), false);
    expect(query.hasMatchAsObject(101), false);
    expect(query.hasMatchAsMap({"count": 99, "text": "aaaa"}), true);
    expect(query.hasMatchAsMap({"count": 100, "text": "aaaa"}), false);
    expect(query.hasMatchAsMap({"count": 101, "text": "aaaa"}), false);
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.greaterThan(key: "count", value: 100),
      ],
    );
    expect(query.hasMatchAsObject(99), false);
    expect(query.hasMatchAsObject(100), false);
    expect(query.hasMatchAsObject(101), true);
    expect(query.hasMatchAsMap({"count": 99, "text": "aaaa"}), false);
    expect(query.hasMatchAsMap({"count": 100, "text": "aaaa"}), false);
    expect(query.hasMatchAsMap({"count": 101, "text": "aaaa"}), true);
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.lessThanOrEqual(key: "count", value: 100),
      ],
    );
    expect(query.hasMatchAsObject(99), true);
    expect(query.hasMatchAsObject(100), true);
    expect(query.hasMatchAsObject(101), false);
    expect(query.hasMatchAsMap({"count": 99, "text": "aaaa"}), true);
    expect(query.hasMatchAsMap({"count": 100, "text": "aaaa"}), true);
    expect(query.hasMatchAsMap({"count": 101, "text": "aaaa"}), false);
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.greaterThanOrEqual(key: "count", value: 100),
      ],
    );
    expect(query.hasMatchAsObject(99), false);
    expect(query.hasMatchAsObject(100), true);
    expect(query.hasMatchAsObject(101), true);
    expect(query.hasMatchAsMap({"count": 99, "text": "aaaa"}), false);
    expect(query.hasMatchAsMap({"count": 100, "text": "aaaa"}), true);
    expect(query.hasMatchAsMap({"count": 101, "text": "aaaa"}), true);
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.contains(key: "count", value: 1),
      ],
    );
    expect(query.hasMatchAsObject([0, 1, 2]), true);
    expect(query.hasMatchAsObject([100, 101, 102]), false);
    expect(
      query.hasMatchAsMap({
        "count": [0, 1, 2],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [100, 101, 102],
        "text": "aaaa"
      }),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.containsAny(key: "count", values: [2, 3, 4]),
      ],
    );
    expect(query.hasMatchAsObject([0, 1, 2]), true);
    expect(query.hasMatchAsObject([2, 3, 4]), true);
    expect(query.hasMatchAsObject([100, 101, 102]), false);
    expect(
      query.hasMatchAsMap({
        "count": [0, 1, 2],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [2, 3, 4],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [100, 101, 102],
        "text": "aaaa"
      }),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.where(key: "count", values: [2, 3, 4]),
      ],
    );
    expect(query.hasMatchAsObject(1), false);
    expect(query.hasMatchAsObject(2), true);
    expect(query.hasMatchAsObject(3), true);
    expect(
      query.hasMatchAsMap({"count": 1, "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap({"count": 2, "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap({"count": 4, "text": "aaaa"}),
      true,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notWhere(key: "count", values: [2, 3, 4]),
      ],
    );
    expect(query.hasMatchAsObject(1), true);
    expect(query.hasMatchAsObject(2), false);
    expect(query.hasMatchAsObject(3), false);
    expect(
      query.hasMatchAsMap({"count": 1, "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap({"count": 2, "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap({"count": 4, "text": "aaaa"}),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.isNull(key: "count"),
      ],
    );
    expect(query.hasMatchAsObject(1), false);
    expect(query.hasMatchAsObject(2), false);
    expect(query.hasMatchAsObject(null), true);
    expect(
      query.hasMatchAsMap({"count": 1, "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap({"text": "aaaa"}),
      true,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.isNotNull(key: "count"),
      ],
    );
    expect(query.hasMatchAsObject(1), true);
    expect(query.hasMatchAsObject(2), true);
    expect(query.hasMatchAsObject(null), false);
    expect(
      query.hasMatchAsMap({"count": 1, "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap({"text": "aaaa"}),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(key: "text", value: "aaaa"),
        ModelQueryFilter.equal(key: "count", value: 5),
      ],
    );
    expect(query.hasMatchAsObject(5), false);
    expect(query.hasMatchAsObject("aaaa"), false);
    expect(query.hasMatchAsObject(4), false);
    expect(
      query.hasMatchAsMap({"count": 1, "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap({"count": 2, "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap({"count": 5, "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap({"count": 5, "text": "bbbb"}),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.greaterThanOrEqual(key: "count", value: 5),
        ModelQueryFilter.lessThanOrEqual(key: "count", value: 10),
      ],
    );
    expect(query.hasMatchAsObject(4), false);
    expect(query.hasMatchAsObject(5), true);
    expect(query.hasMatchAsObject(8), true);
    expect(query.hasMatchAsObject(10), true);
    expect(query.hasMatchAsObject(11), false);
    expect(
      query.hasMatchAsMap({"count": 1, "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap({"count": 2, "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap({"count": 5, "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap({"count": 11, "text": "bbbb"}),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(key: "text", value: "aaaa"),
        ModelQueryFilter.contains(key: "count", value: 10),
      ],
    );
    expect(query.hasMatchAsObject([1, 3, 10]), false);
    expect(query.hasMatchAsObject("aaaa"), false);
    expect(query.hasMatchAsObject([1, 6, 8]), false);
    expect(query.hasMatchAsObject(10), false);
    expect(query.hasMatchAsObject("bbbb"), false);
    expect(
      query.hasMatchAsMap({
        "count": [1, 3, 5],
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "count": [1, 3, 10],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [1, 3, 10],
        "text": "bbbb"
      }),
      false,
    );
  });
  test("ModelQuery.ModelCounter", () async {
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(key: "counter", value: ModelCounter(5)),
      ],
    );
    expect(query.hasMatchAsObject(const ModelCounter(4)), false);
    expect(query.hasMatchAsObject(const ModelCounter(5)), true);
    expect(
      query.hasMatchAsMap(
          {"name": "test", "counter": const ModelCounter(1).toJson()}),
      false,
    );
    expect(
      query.hasMatchAsMap(
          {"name": "test", "counter": const ModelCounter(5).toJson()}),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "counter": const ModelCounter(4).toJson()}
      ]),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "counter": const ModelCounter(5).toJson()}
      ]),
      true,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(key: "counter", value: ModelCounter(5)),
      ],
    );
    expect(query.hasMatchAsObject(const ModelCounter(4)), true);
    expect(query.hasMatchAsObject(const ModelCounter(5)), false);
    expect(
      query.hasMatchAsMap(
          {"name": "test", "counter": const ModelCounter(1).toJson()}),
      true,
    );
    expect(
      query.hasMatchAsMap(
          {"name": "test", "counter": const ModelCounter(5).toJson()}),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "counter": const ModelCounter(4).toJson()}
      ]),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "counter": const ModelCounter(5).toJson()},
        {"name": "test2", "counter": const ModelCounter(5).toJson()}
      ]),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.lessThan(key: "count", value: ModelCounter(100)),
      ],
    );
    expect(query.hasMatchAsObject(const ModelCounter(99)), true);
    expect(query.hasMatchAsObject(const ModelCounter(100)), false);
    expect(query.hasMatchAsObject(const ModelCounter(101)), false);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(99).toJson(), "text": "aaaa"}),
        true);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(100).toJson(), "text": "aaaa"}),
        false);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(101).toJson(), "text": "aaaa"}),
        false);
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.greaterThan(key: "count", value: ModelCounter(100)),
      ],
    );
    expect(query.hasMatchAsObject(const ModelCounter(99)), false);
    expect(query.hasMatchAsObject(const ModelCounter(100)), false);
    expect(query.hasMatchAsObject(const ModelCounter(101)), true);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(99).toJson(), "text": "aaaa"}),
        false);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(100).toJson(), "text": "aaaa"}),
        false);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(101).toJson(), "text": "aaaa"}),
        true);
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.lessThanOrEqual(
            key: "count", value: ModelCounter(100)),
      ],
    );
    expect(query.hasMatchAsObject(const ModelCounter(99)), true);
    expect(query.hasMatchAsObject(const ModelCounter(100)), true);
    expect(query.hasMatchAsObject(const ModelCounter(101)), false);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(99).toJson(), "text": "aaaa"}),
        true);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(100).toJson(), "text": "aaaa"}),
        true);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(101).toJson(), "text": "aaaa"}),
        false);
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.greaterThanOrEqual(
            key: "count", value: ModelCounter(100)),
      ],
    );
    expect(query.hasMatchAsObject(const ModelCounter(99)), false);
    expect(query.hasMatchAsObject(const ModelCounter(100)), true);
    expect(query.hasMatchAsObject(const ModelCounter(101)), true);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(99).toJson(), "text": "aaaa"}),
        false);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(100).toJson(), "text": "aaaa"}),
        true);
    expect(
        query.hasMatchAsMap(
            {"count": const ModelCounter(101).toJson(), "text": "aaaa"}),
        true);
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.contains(key: "count", value: ModelCounter(1)),
      ],
    );
    expect(
        query.hasMatchAsObject([0, 1, 2].map((e) => ModelCounter(e)).toList()),
        true);
    expect(
        query.hasMatchAsObject(
            [100, 101, 102].map((e) => ModelCounter(e)).toList()),
        false);
    expect(
      query.hasMatchAsMap({
        "count": [0, 1, 2].map((e) => ModelCounter(e).toJson()).toList(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [100, 101, 102].map((e) => ModelCounter(e).toJson()).toList(),
        "text": "aaaa"
      }),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.containsAny(
            key: "count",
            values: [ModelCounter(2), ModelCounter(3), ModelCounter(4)]),
      ],
    );
    expect(
        query.hasMatchAsObject([0, 1, 2].map((e) => ModelCounter(e)).toList()),
        true);
    expect(
        query.hasMatchAsObject([2, 3, 4].map((e) => ModelCounter(e)).toList()),
        true);
    expect(
        query.hasMatchAsObject(
            [100, 101, 102].map((e) => ModelCounter(e)).toList()),
        false);
    expect(
      query.hasMatchAsMap({
        "count": [0, 1, 2].map((e) => ModelCounter(e).toJson()).toList(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [2, 3, 4].map((e) => ModelCounter(e).toJson()).toList(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [100, 101, 102].map((e) => ModelCounter(e).toJson()).toList(),
        "text": "aaaa"
      }),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.where(
            key: "count",
            values: [ModelCounter(2), ModelCounter(3), ModelCounter(4)]),
      ],
    );
    expect(query.hasMatchAsObject(const ModelCounter(1)), false);
    expect(query.hasMatchAsObject(const ModelCounter(2)), true);
    expect(query.hasMatchAsObject(const ModelCounter(3)), true);
    expect(
      query.hasMatchAsMap(
          {"count": const ModelCounter(1).toJson(), "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap(
          {"count": const ModelCounter(2).toJson(), "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap(
          {"count": const ModelCounter(4).toJson(), "text": "aaaa"}),
      true,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notWhere(
            key: "count",
            values: [ModelCounter(2), ModelCounter(3), ModelCounter(4)]),
      ],
    );
    expect(query.hasMatchAsObject(const ModelCounter(1)), true);
    expect(query.hasMatchAsObject(const ModelCounter(2)), false);
    expect(query.hasMatchAsObject(const ModelCounter(3)), false);
    expect(
      query.hasMatchAsMap(
          {"count": const ModelCounter(1).toJson(), "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap(
          {"count": const ModelCounter(2).toJson(), "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap(
          {"count": const ModelCounter(4).toJson(), "text": "aaaa"}),
      false,
    );
  });
  test("ModelQuery.ModelTimestamp", () async {
    var query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(
            key: "time", value: ModelTimestamp(DateTime(2000, 1, 4))),
      ],
    );
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 3))), false);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 4))), true);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "time": ModelTimestamp(DateTime(2000, 2, 3)).toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "time": ModelTimestamp(DateTime(2000, 1, 4)).toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "time": ModelTimestamp(DateTime(2001, 1, 4)).toJson()}
      ]),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "time": ModelTimestamp(DateTime(2000, 1, 4)).toJson()}
      ]),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(
            key: "time", value: ModelTimestamp(DateTime(2000, 1, 4))),
      ],
    );
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 3))), true);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 4))), false);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "time": ModelTimestamp(DateTime(2000, 2, 4)).toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "time": ModelTimestamp(DateTime(2000, 1, 4)).toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "time": ModelTimestamp(DateTime(2000, 1, 4)).toJson()}
      ]),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "time": ModelTimestamp(DateTime(2000, 1, 4)).toJson()},
        {"name": "test2", "time": ModelTimestamp(DateTime(2000, 1, 4)).toJson()}
      ]),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.lessThan(
            key: "count", value: ModelTimestamp(DateTime(2000, 1, 4))),
      ],
    );
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 3))), true);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 4))), false);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 5))), false);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 3)).toJson(),
          "text": "aaaa"
        }),
        true);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 4)).toJson(),
          "text": "aaaa"
        }),
        false);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 5)).toJson(),
          "text": "aaaa"
        }),
        false);
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.greaterThan(
            key: "count", value: ModelTimestamp(DateTime(2000, 1, 4))),
      ],
    );
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 3))), false);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 4))), false);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 5))), true);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 3)).toJson(),
          "text": "aaaa"
        }),
        false);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 4)).toJson(),
          "text": "aaaa"
        }),
        false);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 5)).toJson(),
          "text": "aaaa"
        }),
        true);
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.lessThanOrEqual(
            key: "count", value: ModelTimestamp(DateTime(2000, 1, 4))),
      ],
    );
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 3))), true);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 4))), true);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 5))), false);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 3)).toJson(),
          "text": "aaaa"
        }),
        true);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 4)).toJson(),
          "text": "aaaa"
        }),
        true);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 5)).toJson(),
          "text": "aaaa"
        }),
        false);
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.greaterThanOrEqual(
            key: "count", value: ModelTimestamp(DateTime(2000, 1, 4))),
      ],
    );
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 3))), false);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 4))), true);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 5))), true);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 3)).toJson(),
          "text": "aaaa"
        }),
        false);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 4)).toJson(),
          "text": "aaaa"
        }),
        true);
    expect(
        query.hasMatchAsMap({
          "count": ModelTimestamp(DateTime(2000, 1, 5)).toJson(),
          "text": "aaaa"
        }),
        true);
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.contains(
            key: "count", value: ModelTimestamp(DateTime(2000, 1, 4))),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelTimestamp(DateTime(2000, 1, 3)),
          ModelTimestamp(DateTime(2000, 1, 4)),
          ModelTimestamp(DateTime(2000, 1, 5))
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelTimestamp(DateTime(2000, 2, 3)),
          ModelTimestamp(DateTime(2000, 2, 4)),
          ModelTimestamp(DateTime(2000, 2, 5))
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "count": [
          ModelTimestamp(DateTime(2000, 1, 3)).toJson(),
          ModelTimestamp(DateTime(2000, 1, 4)).toJson(),
          ModelTimestamp(DateTime(2000, 1, 5)).toJson()
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [
          ModelTimestamp(DateTime(2000, 2, 3)).toJson(),
          ModelTimestamp(DateTime(2000, 2, 4)).toJson(),
          ModelTimestamp(DateTime(2000, 2, 5)).toJson()
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.containsAny(key: "count", values: [
          ModelTimestamp(DateTime(2000, 1, 3)),
          ModelTimestamp(DateTime(2000, 2, 4)),
          ModelTimestamp(DateTime(2000, 3, 5))
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelTimestamp(DateTime(2000, 1, 3)),
          ModelTimestamp(DateTime(2000, 1, 4)),
          ModelTimestamp(DateTime(2000, 1, 5))
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelTimestamp(DateTime(2000, 2, 3)),
          ModelTimestamp(DateTime(2000, 2, 4)),
          ModelTimestamp(DateTime(2000, 2, 5))
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelTimestamp(DateTime(2000, 4, 3)),
          ModelTimestamp(DateTime(2000, 4, 4)),
          ModelTimestamp(DateTime(2000, 4, 5))
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "count": [
          ModelTimestamp(DateTime(2000, 1, 3)).toJson(),
          ModelTimestamp(DateTime(2000, 1, 4)).toJson(),
          ModelTimestamp(DateTime(2000, 1, 5)).toJson()
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [
          ModelTimestamp(DateTime(2000, 2, 3)).toJson(),
          ModelTimestamp(DateTime(2000, 2, 4)).toJson(),
          ModelTimestamp(DateTime(2000, 2, 5)).toJson()
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": [
          ModelTimestamp(DateTime(2000, 4, 3)).toJson(),
          ModelTimestamp(DateTime(2000, 4, 4)).toJson(),
          ModelTimestamp(DateTime(2000, 4, 5)).toJson()
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.where(key: "count", values: [
          ModelTimestamp(DateTime(2000, 1, 3)),
          ModelTimestamp(DateTime(2000, 1, 4)),
          ModelTimestamp(DateTime(2000, 1, 5))
        ]),
      ],
    );
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 2))), false);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 3))), true);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 4))), true);
    expect(
      query.hasMatchAsMap({
        "count": ModelTimestamp(DateTime(2000, 1, 2)).toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "count": ModelTimestamp(DateTime(2000, 1, 3)).toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": ModelTimestamp(DateTime(2000, 1, 4)).toJson(),
        "text": "aaaa"
      }),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notWhere(key: "count", values: [
          ModelTimestamp(DateTime(2000, 1, 3)),
          ModelTimestamp(DateTime(2000, 1, 4)),
          ModelTimestamp(DateTime(2000, 1, 5))
        ]),
      ],
    );
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 2))), true);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 3))), false);
    expect(query.hasMatchAsObject(ModelTimestamp(DateTime(2000, 1, 4))), false);
    expect(
      query.hasMatchAsMap({
        "count": ModelTimestamp(DateTime(2000, 1, 2)).toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "count": ModelTimestamp(DateTime(2000, 1, 3)).toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "count": ModelTimestamp(DateTime(2000, 1, 4)).toJson(),
        "text": "aaaa"
      }),
      false,
    );
  });
  test("ModelQuery.ModelUri", () async {
    var query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(
          key: "uri",
          value: ModelUri.parse("https://mathru.net"),
        ),
      ],
    );
    expect(query.hasMatchAsObject(ModelUri.parse("https://pub.dev")), false);
    expect(query.hasMatchAsObject(ModelUri.parse("https://mathru.net")), true);
    expect(
      query.hasMatchAsMap(
          {"name": "test", "uri": ModelUri.parse("https://pub.dev").toJson()}),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelUri.parse("https://mathru.net").toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "uri": ModelUri.parse("https://pub.dev").toJson()}
      ]),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "uri": ModelUri.parse("https://mathru.net").toJson()}
      ]),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(
          key: "uri",
          value: ModelUri.parse("https://mathru.net"),
        ),
      ],
    );
    expect(query.hasMatchAsObject(ModelUri.parse("https://pub.dev")), true);
    expect(query.hasMatchAsObject(ModelUri.parse("https://mathru.net")), false);
    expect(
      query.hasMatchAsMap(
          {"name": "test", "uri": ModelUri.parse("https://pub.dev").toJson()}),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelUri.parse("https://mathru.net").toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "uri": ModelUri.parse("https://mathru.net").toJson()}
      ]),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "uri": ModelUri.parse("https://mathru.net").toJson()},
        {"name": "test2", "uri": ModelUri.parse("https://mathru.net").toJson()}
      ]),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.contains(
            key: "uri", value: ModelUri.parse("https://mathru.net")),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelUri.parse("https://mathru.net"),
          ModelUri.parse("https://puv.dev"),
          ModelUri.parse("https://mathru.net/ja"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelUri.parse("https://mathru.net/en"),
          ModelUri.parse("https://puv.dev"),
          ModelUri.parse("https://mathru.net/ja"),
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelUri.parse("https://mathru.net").toJson(),
          ModelUri.parse("https://puv.dev").toJson(),
          ModelUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelUri.parse("https://mathru.net/en").toJson(),
          ModelUri.parse("https://puv.dev").toJson(),
          ModelUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.containsAny(key: "uri", values: [
          ModelUri.parse("https://mathru.net/en"),
          ModelUri.parse("https://mathru.net/zh"),
          ModelUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelUri.parse("https://mathru.net/en"),
          ModelUri.parse("https://puv.dev"),
          ModelUri.parse("https://mathru.net"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelUri.parse("https://mathru.net/en"),
          ModelUri.parse("https://puv.dev"),
          ModelUri.parse("https://mathru.net/ja"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelUri.parse("https://mathru.net"),
          ModelUri.parse("https://puv.dev"),
          ModelUri.parse("https://mathru.net/de"),
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelUri.parse("https://mathru.net/en").toJson(),
          ModelUri.parse("https://puv.dev").toJson(),
          ModelUri.parse("https://mathru.net").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelUri.parse("https://mathru.net/en").toJson(),
          ModelUri.parse("https://puv.dev").toJson(),
          ModelUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelUri.parse("https://mathru.net").toJson(),
          ModelUri.parse("https://puv.dev").toJson(),
          ModelUri.parse("https://mathru.net/de").toJson(),
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.where(key: "uri", values: [
          ModelUri.parse("https://mathru.net/en"),
          ModelUri.parse("https://mathru.net/zh"),
          ModelUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject(ModelUri.parse("https://mathru.net/de")), false);
    expect(
        query.hasMatchAsObject(ModelUri.parse("https://mathru.net/zh")), true);
    expect(
        query.hasMatchAsObject(ModelUri.parse("https://mathru.net/ja")), true);
    expect(
      query.hasMatchAsMap({
        "uri": ModelUri.parse("https://mathru.net/de").toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelUri.parse("https://mathru.net/zh").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelUri.parse("https://mathru.net/ja").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notWhere(key: "uri", values: [
          ModelUri.parse("https://mathru.net/en"),
          ModelUri.parse("https://mathru.net/zh"),
          ModelUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject(ModelUri.parse("https://mathru.net/de")), true);
    expect(
        query.hasMatchAsObject(ModelUri.parse("https://mathru.net/zh")), false);
    expect(
        query.hasMatchAsObject(ModelUri.parse("https://mathru.net/ja")), false);
    expect(
      query.hasMatchAsMap({
        "uri": ModelUri.parse("https://mathru.net/de").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelUri.parse("https://mathru.net/zh").toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelUri.parse("https://mathru.net/ja").toJson(),
        "text": "aaaa"
      }),
      false,
    );
  });
  test("ModelQuery.ModelImageUri", () async {
    var query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(
          key: "uri",
          value: ModelImageUri.parse("https://mathru.net"),
        ),
      ],
    );
    expect(
        query.hasMatchAsObject(ModelImageUri.parse("https://pub.dev")), false);
    expect(query.hasMatchAsObject(ModelImageUri.parse("https://mathru.net")),
        true);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelImageUri.parse("https://pub.dev").toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelImageUri.parse("https://mathru.net").toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "uri": ModelImageUri.parse("https://pub.dev").toJson()
        }
      ]),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "uri": ModelImageUri.parse("https://mathru.net").toJson()
        }
      ]),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(
          key: "uri",
          value: ModelImageUri.parse("https://mathru.net"),
        ),
      ],
    );
    expect(
        query.hasMatchAsObject(ModelImageUri.parse("https://pub.dev")), true);
    expect(query.hasMatchAsObject(ModelImageUri.parse("https://mathru.net")),
        false);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelImageUri.parse("https://pub.dev").toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelImageUri.parse("https://mathru.net").toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "uri": ModelImageUri.parse("https://mathru.net").toJson()
        }
      ]),
      true,
    );
    expect(
      query.hasMatchAsList([
        {
          "name": "test",
          "uri": ModelImageUri.parse("https://mathru.net").toJson()
        },
        {
          "name": "test2",
          "uri": ModelImageUri.parse("https://mathru.net").toJson()
        }
      ]),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.contains(
            key: "uri", value: ModelImageUri.parse("https://mathru.net")),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelImageUri.parse("https://mathru.net"),
          ModelImageUri.parse("https://puv.dev"),
          ModelImageUri.parse("https://mathru.net/ja"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelImageUri.parse("https://mathru.net/en"),
          ModelImageUri.parse("https://puv.dev"),
          ModelImageUri.parse("https://mathru.net/ja"),
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelImageUri.parse("https://mathru.net").toJson(),
          ModelImageUri.parse("https://puv.dev").toJson(),
          ModelImageUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelImageUri.parse("https://mathru.net/en").toJson(),
          ModelImageUri.parse("https://puv.dev").toJson(),
          ModelImageUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.containsAny(key: "uri", values: [
          ModelImageUri.parse("https://mathru.net/en"),
          ModelImageUri.parse("https://mathru.net/zh"),
          ModelImageUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelImageUri.parse("https://mathru.net/en"),
          ModelImageUri.parse("https://puv.dev"),
          ModelImageUri.parse("https://mathru.net"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelImageUri.parse("https://mathru.net/en"),
          ModelImageUri.parse("https://puv.dev"),
          ModelImageUri.parse("https://mathru.net/ja"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelImageUri.parse("https://mathru.net"),
          ModelImageUri.parse("https://puv.dev"),
          ModelImageUri.parse("https://mathru.net/de"),
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelImageUri.parse("https://mathru.net/en").toJson(),
          ModelImageUri.parse("https://puv.dev").toJson(),
          ModelImageUri.parse("https://mathru.net").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelImageUri.parse("https://mathru.net/en").toJson(),
          ModelImageUri.parse("https://puv.dev").toJson(),
          ModelImageUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelImageUri.parse("https://mathru.net").toJson(),
          ModelImageUri.parse("https://puv.dev").toJson(),
          ModelImageUri.parse("https://mathru.net/de").toJson(),
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.where(key: "uri", values: [
          ModelImageUri.parse("https://mathru.net/en"),
          ModelImageUri.parse("https://mathru.net/zh"),
          ModelImageUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(query.hasMatchAsObject(ModelImageUri.parse("https://mathru.net/de")),
        false);
    expect(query.hasMatchAsObject(ModelImageUri.parse("https://mathru.net/zh")),
        true);
    expect(query.hasMatchAsObject(ModelImageUri.parse("https://mathru.net/ja")),
        true);
    expect(
      query.hasMatchAsMap({
        "uri": ModelImageUri.parse("https://mathru.net/de").toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelImageUri.parse("https://mathru.net/zh").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelImageUri.parse("https://mathru.net/ja").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notWhere(key: "uri", values: [
          ModelImageUri.parse("https://mathru.net/en"),
          ModelImageUri.parse("https://mathru.net/zh"),
          ModelImageUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(query.hasMatchAsObject(ModelImageUri.parse("https://mathru.net/de")),
        true);
    expect(query.hasMatchAsObject(ModelImageUri.parse("https://mathru.net/zh")),
        false);
    expect(query.hasMatchAsObject(ModelImageUri.parse("https://mathru.net/ja")),
        false);
    expect(
      query.hasMatchAsMap({
        "uri": ModelImageUri.parse("https://mathru.net/de").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelImageUri.parse("https://mathru.net/zh").toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelImageUri.parse("https://mathru.net/ja").toJson(),
        "text": "aaaa"
      }),
      false,
    );
  });
  test("ModelQuery.ModelVideoUri", () async {
    var query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(
          key: "uri",
          value: ModelVideoUri.parse("https://mathru.net"),
        ),
      ],
    );
    expect(
        query.hasMatchAsObject(ModelVideoUri.parse("https://pub.dev")), false);
    expect(query.hasMatchAsObject(ModelVideoUri.parse("https://mathru.net")),
        true);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelVideoUri.parse("https://pub.dev").toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelVideoUri.parse("https://mathru.net").toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "uri": ModelVideoUri.parse("https://pub.dev").toJson()
        }
      ]),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "uri": ModelVideoUri.parse("https://mathru.net").toJson()
        }
      ]),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(
          key: "uri",
          value: ModelVideoUri.parse("https://mathru.net"),
        ),
      ],
    );
    expect(
        query.hasMatchAsObject(ModelVideoUri.parse("https://pub.dev")), true);
    expect(query.hasMatchAsObject(ModelVideoUri.parse("https://mathru.net")),
        false);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelVideoUri.parse("https://pub.dev").toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "uri": ModelVideoUri.parse("https://mathru.net").toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "uri": ModelVideoUri.parse("https://mathru.net").toJson()
        }
      ]),
      true,
    );
    expect(
      query.hasMatchAsList([
        {
          "name": "test",
          "uri": ModelVideoUri.parse("https://mathru.net").toJson()
        },
        {
          "name": "test2",
          "uri": ModelVideoUri.parse("https://mathru.net").toJson()
        }
      ]),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.contains(
            key: "uri", value: ModelVideoUri.parse("https://mathru.net")),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelVideoUri.parse("https://mathru.net"),
          ModelVideoUri.parse("https://puv.dev"),
          ModelVideoUri.parse("https://mathru.net/ja"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelVideoUri.parse("https://mathru.net/en"),
          ModelVideoUri.parse("https://puv.dev"),
          ModelVideoUri.parse("https://mathru.net/ja"),
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelVideoUri.parse("https://mathru.net").toJson(),
          ModelVideoUri.parse("https://puv.dev").toJson(),
          ModelVideoUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelVideoUri.parse("https://mathru.net/en").toJson(),
          ModelVideoUri.parse("https://puv.dev").toJson(),
          ModelVideoUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.containsAny(key: "uri", values: [
          ModelVideoUri.parse("https://mathru.net/en"),
          ModelVideoUri.parse("https://mathru.net/zh"),
          ModelVideoUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelVideoUri.parse("https://mathru.net/en"),
          ModelVideoUri.parse("https://puv.dev"),
          ModelVideoUri.parse("https://mathru.net"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelVideoUri.parse("https://mathru.net/en"),
          ModelVideoUri.parse("https://puv.dev"),
          ModelVideoUri.parse("https://mathru.net/ja"),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelVideoUri.parse("https://mathru.net"),
          ModelVideoUri.parse("https://puv.dev"),
          ModelVideoUri.parse("https://mathru.net/de"),
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelVideoUri.parse("https://mathru.net/en").toJson(),
          ModelVideoUri.parse("https://puv.dev").toJson(),
          ModelVideoUri.parse("https://mathru.net").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelVideoUri.parse("https://mathru.net/en").toJson(),
          ModelVideoUri.parse("https://puv.dev").toJson(),
          ModelVideoUri.parse("https://mathru.net/ja").toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": [
          ModelVideoUri.parse("https://mathru.net").toJson(),
          ModelVideoUri.parse("https://puv.dev").toJson(),
          ModelVideoUri.parse("https://mathru.net/de").toJson(),
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.where(key: "uri", values: [
          ModelVideoUri.parse("https://mathru.net/en"),
          ModelVideoUri.parse("https://mathru.net/zh"),
          ModelVideoUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(query.hasMatchAsObject(ModelVideoUri.parse("https://mathru.net/de")),
        false);
    expect(query.hasMatchAsObject(ModelVideoUri.parse("https://mathru.net/zh")),
        true);
    expect(query.hasMatchAsObject(ModelVideoUri.parse("https://mathru.net/ja")),
        true);
    expect(
      query.hasMatchAsMap({
        "uri": ModelVideoUri.parse("https://mathru.net/de").toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelVideoUri.parse("https://mathru.net/zh").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelVideoUri.parse("https://mathru.net/ja").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notWhere(key: "uri", values: [
          ModelVideoUri.parse("https://mathru.net/en"),
          ModelVideoUri.parse("https://mathru.net/zh"),
          ModelVideoUri.parse("https://mathru.net/ja"),
        ]),
      ],
    );
    expect(query.hasMatchAsObject(ModelVideoUri.parse("https://mathru.net/de")),
        true);
    expect(query.hasMatchAsObject(ModelVideoUri.parse("https://mathru.net/zh")),
        false);
    expect(query.hasMatchAsObject(ModelVideoUri.parse("https://mathru.net/ja")),
        false);
    expect(
      query.hasMatchAsMap({
        "uri": ModelVideoUri.parse("https://mathru.net/de").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelVideoUri.parse("https://mathru.net/zh").toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "uri": ModelVideoUri.parse("https://mathru.net/ja").toJson(),
        "text": "aaaa"
      }),
      false,
    );
  });
  test("ModelQuery.ModelSearch", () async {
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(
          key: "search",
          value: ModelSearch(["aaaa", "bbbb"]),
        ),
      ],
    );
    expect(query.hasMatchAsObject(const ModelSearch(["dddd", "cccc"])), false);
    expect(query.hasMatchAsObject(const ModelSearch(["aaaa", "bbbb"])), true);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "search": const ModelSearch(["dddd", "cccc"]).toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "search": const ModelSearch(["aaaa", "bbbb"]).toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "search": const ModelSearch(["eeee", "cccc"]).toJson()
        }
      ]),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "search": const ModelSearch(["bbbb", "cccc"]).toJson()
        }
      ]),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(
          key: "search",
          value: ModelSearch(["aaaa", "bbbb"]),
        ),
      ],
    );
    expect(query.hasMatchAsObject(const ModelSearch(["dddd", "cccc"])), true);
    expect(query.hasMatchAsObject(const ModelSearch(["aaaa", "bbbb"])), false);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "search": const ModelSearch(["dddd", "cccc"]).toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "search": const ModelSearch(["aaaa", "bbbb"]).toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "search": const ModelSearch(["eeee", "cccc"]).toJson()
        }
      ]),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {
          "name": "test2",
          "search": const ModelSearch(["bbbb", "cccc"]).toJson()
        }
      ]),
      true,
    );
  });
  test("ModelQuery.ModelGeoValue", () async {
    const nijyuBashi = GeoValue(
      latitude: 35.68177834908552,
      longitude: 139.75310000426765,
    );
    const sakasitaMon = GeoValue(
      latitude: 35.68338744577881,
      longitude: 139.75543340290164,
    );
    const kasumigaseki = GeoValue(
      latitude: 35.67389581850969,
      longitude: 139.75049296820384,
    );
    const gaien = GeoValue(
      latitude: 35.68035473318286,
      longitude: 139.7589095455294,
    );
    const tokyoEki = GeoValue(
      latitude: 35.681400509168085,
      longitude: 139.76573308476165,
    );
    const kokudoKotusho = GeoValue(
      latitude: 35.6764460550141,
      longitude: 139.75011795538524,
    );
    const kokurituKyogijyo = GeoValue(
      latitude: 35.67505647159709,
      longitude: 139.71676807084754,
    );
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(key: "geo", value: ModelGeoValue(nijyuBashi)),
      ],
    );
    expect(query.hasMatchAsObject(const ModelGeoValue(kasumigaseki)), false);
    expect(query.hasMatchAsObject(const ModelGeoValue(sakasitaMon)), true);
    expect(
      query.hasMatchAsMap(
          {"name": "test", "geo": const ModelGeoValue(kasumigaseki).toJson()}),
      false,
    );
    expect(
      query.hasMatchAsMap(
          {"name": "test", "geo": const ModelGeoValue(sakasitaMon).toJson()}),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "geo": const ModelGeoValue(kasumigaseki).toJson()}
      ]),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "geo": const ModelGeoValue(sakasitaMon).toJson()}
      ]),
      true,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(key: "geo", value: ModelGeoValue(nijyuBashi)),
      ],
    );
    expect(query.hasMatchAsObject(const ModelGeoValue(kasumigaseki)), true);
    expect(query.hasMatchAsObject(const ModelGeoValue(sakasitaMon)), false);
    expect(
      query.hasMatchAsMap(
          {"name": "test", "geo": const ModelGeoValue(kasumigaseki).toJson()}),
      true,
    );
    expect(
      query.hasMatchAsMap(
          {"name": "test", "geo": const ModelGeoValue(sakasitaMon).toJson()}),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "geo": const ModelGeoValue(kasumigaseki).toJson()}
      ]),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test2", "geo": const ModelGeoValue(nijyuBashi).toJson()},
        {"name": "test2", "geo": const ModelGeoValue(sakasitaMon).toJson()}
      ]),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.contains(key: "geo", value: ModelGeoValue(nijyuBashi)),
      ],
    );
    expect(
        query.hasMatchAsObject([
          const ModelGeoValue(kasumigaseki),
          const ModelGeoValue(sakasitaMon),
          const ModelGeoValue(gaien),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          const ModelGeoValue(kasumigaseki),
          const ModelGeoValue(tokyoEki),
          const ModelGeoValue(gaien),
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "geo": [
          const ModelGeoValue(kasumigaseki).toJson(),
          const ModelGeoValue(sakasitaMon).toJson(),
          const ModelGeoValue(gaien).toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "geo": [
          const ModelGeoValue(kasumigaseki).toJson(),
          const ModelGeoValue(tokyoEki).toJson(),
          const ModelGeoValue(gaien).toJson(),
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.containsAny(key: "geo", values: [
          ModelGeoValue(kokudoKotusho),
          ModelGeoValue(nijyuBashi),
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject([
          const ModelGeoValue(kasumigaseki),
          const ModelGeoValue(sakasitaMon),
          const ModelGeoValue(gaien),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          const ModelGeoValue(kasumigaseki),
          const ModelGeoValue(tokyoEki),
          const ModelGeoValue(gaien),
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          const ModelGeoValue(tokyoEki),
          const ModelGeoValue(gaien),
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "geo": [
          const ModelGeoValue(kasumigaseki).toJson(),
          const ModelGeoValue(sakasitaMon).toJson(),
          const ModelGeoValue(gaien).toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "geo": [
          const ModelGeoValue(kasumigaseki).toJson(),
          const ModelGeoValue(tokyoEki).toJson(),
          const ModelGeoValue(gaien).toJson(),
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "geo": [
          const ModelGeoValue(tokyoEki).toJson(),
          const ModelGeoValue(gaien).toJson(),
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.where(key: "geo", values: [
          ModelGeoValue(kokudoKotusho),
          ModelGeoValue(nijyuBashi),
        ]),
      ],
    );
    expect(query.hasMatchAsObject(const ModelGeoValue(tokyoEki)), false);
    expect(query.hasMatchAsObject(const ModelGeoValue(kasumigaseki)), true);
    expect(query.hasMatchAsObject(const ModelGeoValue(sakasitaMon)), true);
    expect(
      query.hasMatchAsMap(
          {"geo": const ModelGeoValue(tokyoEki).toJson(), "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap(
          {"geo": const ModelGeoValue(kasumigaseki).toJson(), "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap(
          {"geo": const ModelGeoValue(sakasitaMon).toJson(), "text": "aaaa"}),
      true,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notWhere(key: "geo", values: [
          ModelGeoValue(kokudoKotusho),
          ModelGeoValue(nijyuBashi),
        ]),
      ],
    );
    expect(query.hasMatchAsObject(const ModelGeoValue(tokyoEki)), true);
    expect(query.hasMatchAsObject(const ModelGeoValue(kasumigaseki)), false);
    expect(query.hasMatchAsObject(const ModelGeoValue(sakasitaMon)), false);
    expect(
      query.hasMatchAsMap(
          {"geo": const ModelGeoValue(tokyoEki).toJson(), "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap(
          {"geo": const ModelGeoValue(kasumigaseki).toJson(), "text": "aaaa"}),
      false,
    );
    expect(
      query.hasMatchAsMap(
          {"geo": const ModelGeoValue(sakasitaMon).toJson(), "text": "aaaa"}),
      false,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.geo(key: "geo", geoValues: [
          GeoValue(latitude: 35.662, longitude: 139.768, radiusKm: 2.0),
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject(const ModelGeoValue(kokurituKyogijyo)), false);
    expect(query.hasMatchAsObject(const ModelGeoValue(kasumigaseki)), true);
    expect(query.hasMatchAsObject(const ModelGeoValue(sakasitaMon)), true);
    expect(
      query.hasMatchAsMap({
        "geo": const ModelGeoValue(kokurituKyogijyo).toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap(
          {"geo": const ModelGeoValue(kasumigaseki).toJson(), "text": "aaaa"}),
      true,
    );
    expect(
      query.hasMatchAsMap(
          {"geo": const ModelGeoValue(sakasitaMon).toJson(), "text": "aaaa"}),
      true,
    );
  });
  test("ModelQuery.ModelRef", () async {
    var query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.equal(
            key: "path", value: ModelRefBase.fromPath("cccc/dddd")),
      ],
    );
    expect(query.hasMatchAsObject(ModelRefBase.fromPath("eeee/ffff")), false);
    expect(query.hasMatchAsObject(ModelRefBase.fromPath("cccc/dddd")), true);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "path": ModelRefBase.fromPath("eeee/ffff").toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "path": ModelRefBase.fromPath("cccc/dddd").toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "path": ModelRefBase.fromPath("eeee/ffff").toJson()}
      ]),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "path": ModelRefBase.fromPath("cccc/dddd").toJson()}
      ]),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notEqual(
            key: "path", value: ModelRefBase.fromPath("cccc/dddd")),
      ],
    );
    expect(query.hasMatchAsObject(ModelRefBase.fromPath("eeee/ffff")), true);
    expect(query.hasMatchAsObject(ModelRefBase.fromPath("cccc/dddd")), false);
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "path": ModelRefBase.fromPath("eeee/ffff").toJson()
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "name": "test",
        "path": ModelRefBase.fromPath("cccc/dddd").toJson()
      }),
      false,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "text": "aaaa"},
        {"name": "test2", "path": ModelRefBase.fromPath("eeee/ffff").toJson()}
      ]),
      true,
    );
    expect(
      query.hasMatchAsList([
        {"name": "test", "path": ModelRefBase.fromPath("cccc/dddd").toJson()},
        {"name": "test2", "path": ModelRefBase.fromPath("cccc/dddd").toJson()}
      ]),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.contains(
            key: "path", value: ModelRefBase.fromPath("cccc/dddd")),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelRefBase.fromPath("aaaa/bbbb"),
          ModelRefBase.fromPath("cccc/dddd"),
          ModelRefBase.fromPath("eeee/ffff")
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelRefBase.fromPath("1111/bbbb"),
          ModelRefBase.fromPath("2222/dddd"),
          ModelRefBase.fromPath("3333/ffff")
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "path": [
          ModelRefBase.fromPath("aaaa/bbbb").toJson(),
          ModelRefBase.fromPath("cccc/dddd").toJson(),
          ModelRefBase.fromPath("eeee/ffff").toJson()
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "path": [
          ModelRefBase.fromPath("1111/bbbb").toJson(),
          ModelRefBase.fromPath("2222/dddd").toJson(),
          ModelRefBase.fromPath("3333/ffff").toJson()
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.containsAny(key: "path", values: [
          ModelRefBase.fromPath("aaaa/bbbb"),
          ModelRefBase.fromPath("cccc/dddd"),
          ModelRefBase.fromPath("eeee/ffff")
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject([
          ModelRefBase.fromPath("aaaa/bbbb"),
          ModelRefBase.fromPath("2222/dddd"),
          ModelRefBase.fromPath("3333/ffff")
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelRefBase.fromPath("1111/bbbb"),
          ModelRefBase.fromPath("cccc/dddd"),
          ModelRefBase.fromPath("3333/ffff")
        ]),
        true);
    expect(
        query.hasMatchAsObject([
          ModelRefBase.fromPath("1111/bbbb").toJson(),
          ModelRefBase.fromPath("2222/dddd").toJson(),
          ModelRefBase.fromPath("3333/ffff").toJson()
        ]),
        false);
    expect(
      query.hasMatchAsMap({
        "path": [
          ModelRefBase.fromPath("aaaa/bbbb").toJson(),
          ModelRefBase.fromPath("2222/dddd").toJson(),
          ModelRefBase.fromPath("3333/ffff").toJson()
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "path": [
          ModelRefBase.fromPath("1111/bbbb").toJson(),
          ModelRefBase.fromPath("cccc/dddd").toJson(),
          ModelRefBase.fromPath("3333/ffff").toJson()
        ],
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "path": [
          ModelRefBase.fromPath("1111/bbbb").toJson(),
          ModelRefBase.fromPath("2222/dddd").toJson(),
          ModelRefBase.fromPath("3333/ffff").toJson()
        ],
        "text": "aaaa"
      }),
      false,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.where(key: "path", values: [
          ModelRefBase.fromPath("aaaa/bbbb"),
          ModelRefBase.fromPath("cccc/dddd"),
          ModelRefBase.fromPath("eeee/ffff")
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject(
          ModelRefBase.fromPath("1111/bbbb"),
        ),
        false);
    expect(
        query.hasMatchAsObject(
          ModelRefBase.fromPath("cccc/dddd"),
        ),
        true);
    expect(
        query.hasMatchAsObject(
          ModelRefBase.fromPath("eeee/ffff"),
        ),
        true);
    expect(
      query.hasMatchAsMap({
        "path": ModelRefBase.fromPath("1111/bbbb").toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "path": ModelRefBase.fromPath("cccc/dddd").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "path": ModelRefBase.fromPath("eeee/ffff").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    query = ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.notWhere(key: "path", values: [
          ModelRefBase.fromPath("aaaa/bbbb"),
          ModelRefBase.fromPath("cccc/dddd"),
          ModelRefBase.fromPath("eeee/ffff")
        ]),
      ],
    );
    expect(
        query.hasMatchAsObject(
          ModelRefBase.fromPath("1111/bbbb"),
        ),
        true);
    expect(
        query.hasMatchAsObject(
          ModelRefBase.fromPath("cccc/dddd"),
        ),
        false);
    expect(
        query.hasMatchAsObject(
          ModelRefBase.fromPath("eeee/ffff"),
        ),
        false);
    expect(
      query.hasMatchAsMap({
        "path": ModelRefBase.fromPath("1111/bbbb").toJson(),
        "text": "aaaa"
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        "path": ModelRefBase.fromPath("cccc/dddd").toJson(),
        "text": "aaaa"
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        "path": ModelRefBase.fromPath("eeee/ffff").toJson(),
        "text": "aaaa"
      }),
      false,
    );
  });
  test("ModelQuery.sort", () async {
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.orderByAsc(key: "count"),
      ],
    );
    expect(
      query.sort(
        const [
          MapEntry("dddd", {"count": 10, "text": "a"}),
          MapEntry("dddd", {"count": 4, "text": "a"}),
          MapEntry("dddd", {"count": 8, "text": "a"}),
          MapEntry("dddd", {"count": 1, "text": "a"}),
        ],
      ).toString(),
      const [
        MapEntry("dddd", {"count": 1, "text": "a"}),
        MapEntry("dddd", {"count": 4, "text": "a"}),
        MapEntry("dddd", {"count": 8, "text": "a"}),
        MapEntry("dddd", {"count": 10, "text": "a"}),
      ].toString(),
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.orderByDesc(key: "count"),
      ],
    );
    expect(
      query.sort(
        const [
          MapEntry("dddd", {"count": 10, "text": "a"}),
          MapEntry("dddd", {"count": 4, "text": "a"}),
          MapEntry("dddd", {"count": 8, "text": "a"}),
          MapEntry("dddd", {"count": 1, "text": "a"}),
        ],
      ).toString(),
      const [
        MapEntry("dddd", {"count": 10, "text": "a"}),
        MapEntry("dddd", {"count": 8, "text": "a"}),
        MapEntry("dddd", {"count": 4, "text": "a"}),
        MapEntry("dddd", {"count": 1, "text": "a"}),
      ].toString(),
    );
  });
  test("ModelQuery.sort.ModelCounter", () async {
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.orderByAsc(key: "count"),
      ],
    );
    expect(
      query.sort(
        const [
          MapEntry("dddd", {"count": ModelCounter(10), "text": "a"}),
          MapEntry("dddd", {"count": ModelCounter(4), "text": "a"}),
          MapEntry("dddd", {"count": ModelCounter(8), "text": "a"}),
          MapEntry("dddd", {"count": ModelCounter(1), "text": "a"}),
        ],
      ).toString(),
      const [
        MapEntry("dddd", {"count": ModelCounter(1), "text": "a"}),
        MapEntry("dddd", {"count": ModelCounter(4), "text": "a"}),
        MapEntry("dddd", {"count": ModelCounter(8), "text": "a"}),
        MapEntry("dddd", {"count": ModelCounter(10), "text": "a"}),
      ].toString(),
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.orderByDesc(key: "count"),
      ],
    );
    expect(
      query.sort(
        [
          MapEntry(
              "dddd", {"count": const ModelCounter(10).toJson(), "text": "a"}),
          MapEntry(
              "dddd", {"count": const ModelCounter(4).toJson(), "text": "a"}),
          MapEntry(
              "dddd", {"count": const ModelCounter(8).toJson(), "text": "a"}),
          MapEntry(
              "dddd", {"count": const ModelCounter(1).toJson(), "text": "a"}),
        ],
      ).toString(),
      [
        MapEntry(
            "dddd", {"count": const ModelCounter(10).toJson(), "text": "a"}),
        MapEntry(
            "dddd", {"count": const ModelCounter(8).toJson(), "text": "a"}),
        MapEntry(
            "dddd", {"count": const ModelCounter(4).toJson(), "text": "a"}),
        MapEntry(
            "dddd", {"count": const ModelCounter(1).toJson(), "text": "a"}),
      ].toString(),
    );
  });
  test("ModelQuery.sort.ModelTimestamp", () async {
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.orderByAsc(key: "count"),
      ],
    );
    expect(
      query.sort(
        [
          MapEntry("dddd",
              {"count": ModelTimestamp(DateTime(2010, 1, 1)), "text": "a"}),
          MapEntry("dddd",
              {"count": ModelTimestamp(DateTime(2008, 1, 1)), "text": "a"}),
          MapEntry("dddd",
              {"count": ModelTimestamp(DateTime(2004, 1, 1)), "text": "a"}),
          MapEntry("dddd",
              {"count": ModelTimestamp(DateTime(2001, 1, 1)), "text": "a"}),
        ],
      ).toString(),
      [
        MapEntry("dddd",
            {"count": ModelTimestamp(DateTime(2001, 1, 1)), "text": "a"}),
        MapEntry("dddd",
            {"count": ModelTimestamp(DateTime(2004, 1, 1)), "text": "a"}),
        MapEntry("dddd",
            {"count": ModelTimestamp(DateTime(2008, 1, 1)), "text": "a"}),
        MapEntry("dddd",
            {"count": ModelTimestamp(DateTime(2010, 1, 1)), "text": "a"}),
      ].toString(),
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.orderByDesc(key: "count"),
      ],
    );
    expect(
      query.sort(
        [
          MapEntry("dddd", {
            "count": ModelTimestamp(DateTime(2010, 1, 1)).toJson(),
            "text": "a"
          }),
          MapEntry("dddd", {
            "count": ModelTimestamp(DateTime(2004, 1, 1)).toJson(),
            "text": "a"
          }),
          MapEntry("dddd", {
            "count": ModelTimestamp(DateTime(2008, 1, 1)).toJson(),
            "text": "a"
          }),
          MapEntry("dddd", {
            "count": ModelTimestamp(DateTime(2001, 1, 1)).toJson(),
            "text": "a"
          }),
        ],
      ).toString(),
      [
        MapEntry("dddd", {
          "count": ModelTimestamp(DateTime(2010, 1, 1)).toJson(),
          "text": "a"
        }),
        MapEntry("dddd", {
          "count": ModelTimestamp(DateTime(2008, 1, 1)).toJson(),
          "text": "a"
        }),
        MapEntry("dddd", {
          "count": ModelTimestamp(DateTime(2004, 1, 1)).toJson(),
          "text": "a"
        }),
        MapEntry("dddd", {
          "count": ModelTimestamp(DateTime(2001, 1, 1)).toJson(),
          "text": "a"
        }),
      ].toString(),
    );
  });
  test("ModelQuery.seekIndex", () async {
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.orderByAsc(key: "count"),
      ],
    );
    expect(
      query.seekIndex(
        query.sort(
          const [
            MapEntry("dddd", {"count": 10, "text": "a"}),
            MapEntry("dddd", {"count": 4, "text": "a"}),
            MapEntry("dddd", {"count": 8, "text": "a"}),
            MapEntry("dddd", {"count": 1, "text": "a"}),
          ],
        ),
        {"count": 5, "text": "a"},
      ),
      2,
    );
    expect(
      query.seekIndex(
        query.sort(
          const [
            MapEntry("dddd", {"count": 10, "text": "a"}),
            MapEntry("dddd", {"count": 4, "text": "a"}),
            MapEntry("dddd", {"count": 8, "text": "a"}),
            MapEntry("dddd", {"count": 1, "text": "a"}),
          ],
        ),
        {"count": 15, "text": "a"},
      ),
      4,
    );
    expect(
      query.seekIndex(
        query.sort(
          const [
            MapEntry("dddd", {"count": 10, "text": "a"}),
            MapEntry("dddd", {"count": 4, "text": "a"}),
            MapEntry("dddd", {"count": 8, "text": "a"}),
            MapEntry("dddd", {"count": 1, "text": "a"}),
          ],
        ),
        {"count": 0, "text": "a"},
      ),
      0,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.orderByDesc(key: "count"),
      ],
    );
    expect(
      query.seekIndex(
        query.sort(
          const [
            MapEntry("dddd", {"count": 10, "text": "a"}),
            MapEntry("dddd", {"count": 4, "text": "a"}),
            MapEntry("dddd", {"count": 8, "text": "a"}),
            MapEntry("dddd", {"count": 1, "text": "a"}),
          ],
        ),
        {"count": 5, "text": "a"},
      ),
      2,
    );
    expect(
      query.seekIndex(
        query.sort(
          const [
            MapEntry("dddd", {"count": 10, "text": "a"}),
            MapEntry("dddd", {"count": 4, "text": "a"}),
            MapEntry("dddd", {"count": 8, "text": "a"}),
            MapEntry("dddd", {"count": 1, "text": "a"}),
          ],
        ),
        {"count": 15, "text": "a"},
      ),
      0,
    );
    expect(
      query.seekIndex(
        query.sort(
          const [
            MapEntry("dddd", {"count": 10, "text": "a"}),
            MapEntry("dddd", {"count": 4, "text": "a"}),
            MapEntry("dddd", {"count": 8, "text": "a"}),
            MapEntry("dddd", {"count": 1, "text": "a"}),
          ],
        ),
        {"count": 0, "text": "a"},
      ),
      4,
    );
  });
  test("ModelQuery.search", () async {
    var query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.like(key: kDefaultSearchableFieldKey, text: "mas"),
      ],
    );
    expect(
      query.hasMatchAsObject({
        "ma": true,
        "as": true,
        "sa": true,
        "am": true,
        "mu": true,
        "un": true,
        "ne": true,
      }),
      true,
    );
    expect(
      query.hasMatchAsMap({
        kDefaultSearchableFieldKey: {
          "ma": true,
          "as": true,
          "sa": true,
          "am": true,
          "mu": true,
          "un": true,
          "ne": true,
        },
      }),
      true,
    );
    query = const ModelQuery(
      "aaaa/bbbb",
      filters: [
        ModelQueryFilter.like(key: kDefaultSearchableFieldKey, text: "oooo"),
      ],
    );
    expect(
      query.hasMatchAsObject({
        "ma": true,
        "as": true,
        "sa": true,
        "am": true,
        "mu": true,
        "un": true,
        "ne": true,
      }),
      false,
    );
    expect(
      query.hasMatchAsMap({
        kDefaultSearchableFieldKey: {
          "ma": true,
          "as": true,
          "sa": true,
          "am": true,
          "mu": true,
          "un": true,
          "ne": true,
        },
      }),
      false,
    );
  });
}
