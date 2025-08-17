// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_collections.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMetricEntryIsarCollection on Isar {
  IsarCollection<MetricEntryIsar> get metricEntryIsars => this.collection();
}

const MetricEntryIsarSchema = CollectionSchema(
  name: r'MetricEntryIsar',
  id: 3134430105870238206,
  properties: {
    r'booleanValue': PropertySchema(
      id: 0,
      name: r'booleanValue',
      type: IsarType.bool,
    ),
    r'metricId': PropertySchema(
      id: 1,
      name: r'metricId',
      type: IsarType.long,
    ),
    r'numericValue': PropertySchema(
      id: 2,
      name: r'numericValue',
      type: IsarType.double,
    ),
    r'timestamp': PropertySchema(
      id: 3,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _metricEntryIsarEstimateSize,
  serialize: _metricEntryIsarSerialize,
  deserialize: _metricEntryIsarDeserialize,
  deserializeProp: _metricEntryIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _metricEntryIsarGetId,
  getLinks: _metricEntryIsarGetLinks,
  attach: _metricEntryIsarAttach,
  version: '3.1.0+1',
);

int _metricEntryIsarEstimateSize(
  MetricEntryIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _metricEntryIsarSerialize(
  MetricEntryIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.booleanValue);
  writer.writeLong(offsets[1], object.metricId);
  writer.writeDouble(offsets[2], object.numericValue);
  writer.writeDateTime(offsets[3], object.timestamp);
}

MetricEntryIsar _metricEntryIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MetricEntryIsar();
  object.booleanValue = reader.readBoolOrNull(offsets[0]);
  object.id = id;
  object.metricId = reader.readLong(offsets[1]);
  object.numericValue = reader.readDoubleOrNull(offsets[2]);
  object.timestamp = reader.readDateTime(offsets[3]);
  return object;
}

P _metricEntryIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDoubleOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _metricEntryIsarGetId(MetricEntryIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _metricEntryIsarGetLinks(MetricEntryIsar object) {
  return [];
}

void _metricEntryIsarAttach(
    IsarCollection<dynamic> col, Id id, MetricEntryIsar object) {
  object.id = id;
}

extension MetricEntryIsarQueryWhereSort
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QWhere> {
  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MetricEntryIsarQueryWhere
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QWhereClause> {
  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MetricEntryIsarQueryFilter
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QFilterCondition> {
  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      booleanValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'booleanValue',
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      booleanValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'booleanValue',
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      booleanValueEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'booleanValue',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      metricIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'metricId',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      metricIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'metricId',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      metricIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'metricId',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      metricIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'metricId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      numericValueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'numericValue',
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      numericValueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'numericValue',
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      numericValueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'numericValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      numericValueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'numericValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      numericValueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'numericValue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      numericValueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'numericValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MetricEntryIsarQueryObject
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QFilterCondition> {}

extension MetricEntryIsarQueryLinks
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QFilterCondition> {}

extension MetricEntryIsarQuerySortBy
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QSortBy> {
  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      sortByBooleanValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'booleanValue', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      sortByBooleanValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'booleanValue', Sort.desc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      sortByMetricId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metricId', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      sortByMetricIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metricId', Sort.desc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      sortByNumericValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numericValue', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      sortByNumericValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numericValue', Sort.desc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension MetricEntryIsarQuerySortThenBy
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QSortThenBy> {
  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      thenByBooleanValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'booleanValue', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      thenByBooleanValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'booleanValue', Sort.desc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      thenByMetricId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metricId', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      thenByMetricIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'metricId', Sort.desc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      thenByNumericValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numericValue', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      thenByNumericValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'numericValue', Sort.desc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension MetricEntryIsarQueryWhereDistinct
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QDistinct> {
  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QDistinct>
      distinctByBooleanValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'booleanValue');
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QDistinct>
      distinctByMetricId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'metricId');
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QDistinct>
      distinctByNumericValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'numericValue');
    });
  }

  QueryBuilder<MetricEntryIsar, MetricEntryIsar, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension MetricEntryIsarQueryProperty
    on QueryBuilder<MetricEntryIsar, MetricEntryIsar, QQueryProperty> {
  QueryBuilder<MetricEntryIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MetricEntryIsar, bool?, QQueryOperations>
      booleanValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'booleanValue');
    });
  }

  QueryBuilder<MetricEntryIsar, int, QQueryOperations> metricIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'metricId');
    });
  }

  QueryBuilder<MetricEntryIsar, double?, QQueryOperations>
      numericValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'numericValue');
    });
  }

  QueryBuilder<MetricEntryIsar, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTimeTrackerEntryIsarCollection on Isar {
  IsarCollection<TimeTrackerEntryIsar> get timeTrackerEntryIsars =>
      this.collection();
}

const TimeTrackerEntryIsarSchema = CollectionSchema(
  name: r'TimeTrackerEntryIsar',
  id: -3424703004040926451,
  properties: {
    r'activity': PropertySchema(
      id: 0,
      name: r'activity',
      type: IsarType.string,
    ),
    r'endTime': PropertySchema(
      id: 1,
      name: r'endTime',
      type: IsarType.dateTime,
    ),
    r'groupInvolved': PropertySchema(
      id: 2,
      name: r'groupInvolved',
      type: IsarType.string,
    ),
    r'mood': PropertySchema(
      id: 3,
      name: r'mood',
      type: IsarType.long,
    ),
    r'peopleInvolved': PropertySchema(
      id: 4,
      name: r'peopleInvolved',
      type: IsarType.string,
    ),
    r'startTime': PropertySchema(
      id: 5,
      name: r'startTime',
      type: IsarType.dateTime,
    ),
    r'subActivity': PropertySchema(
      id: 6,
      name: r'subActivity',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 7,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _timeTrackerEntryIsarEstimateSize,
  serialize: _timeTrackerEntryIsarSerialize,
  deserialize: _timeTrackerEntryIsarDeserialize,
  deserializeProp: _timeTrackerEntryIsarDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _timeTrackerEntryIsarGetId,
  getLinks: _timeTrackerEntryIsarGetLinks,
  attach: _timeTrackerEntryIsarAttach,
  version: '3.1.0+1',
);

int _timeTrackerEntryIsarEstimateSize(
  TimeTrackerEntryIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.activity.length * 3;
  {
    final value = object.groupInvolved;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.peopleInvolved;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.subActivity;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _timeTrackerEntryIsarSerialize(
  TimeTrackerEntryIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activity);
  writer.writeDateTime(offsets[1], object.endTime);
  writer.writeString(offsets[2], object.groupInvolved);
  writer.writeLong(offsets[3], object.mood);
  writer.writeString(offsets[4], object.peopleInvolved);
  writer.writeDateTime(offsets[5], object.startTime);
  writer.writeString(offsets[6], object.subActivity);
  writer.writeDateTime(offsets[7], object.timestamp);
}

TimeTrackerEntryIsar _timeTrackerEntryIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TimeTrackerEntryIsar();
  object.activity = reader.readString(offsets[0]);
  object.endTime = reader.readDateTime(offsets[1]);
  object.groupInvolved = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.mood = reader.readLongOrNull(offsets[3]);
  object.peopleInvolved = reader.readStringOrNull(offsets[4]);
  object.startTime = reader.readDateTime(offsets[5]);
  object.subActivity = reader.readStringOrNull(offsets[6]);
  object.timestamp = reader.readDateTime(offsets[7]);
  return object;
}

P _timeTrackerEntryIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _timeTrackerEntryIsarGetId(TimeTrackerEntryIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _timeTrackerEntryIsarGetLinks(
    TimeTrackerEntryIsar object) {
  return [];
}

void _timeTrackerEntryIsarAttach(
    IsarCollection<dynamic> col, Id id, TimeTrackerEntryIsar object) {
  object.id = id;
}

extension TimeTrackerEntryIsarQueryWhereSort
    on QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QWhere> {
  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TimeTrackerEntryIsarQueryWhere
    on QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QWhereClause> {
  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimeTrackerEntryIsarQueryFilter on QueryBuilder<TimeTrackerEntryIsar,
    TimeTrackerEntryIsar, QFilterCondition> {
  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> activityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> activityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> activityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> activityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> activityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> activityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
          QAfterFilterCondition>
      activityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
          QAfterFilterCondition>
      activityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> activityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activity',
        value: '',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> activityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activity',
        value: '',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> endTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> endTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> endTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> endTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'groupInvolved',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'groupInvolved',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'groupInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'groupInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'groupInvolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'groupInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'groupInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
          QAfterFilterCondition>
      groupInvolvedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'groupInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
          QAfterFilterCondition>
      groupInvolvedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'groupInvolved',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'groupInvolved',
        value: '',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> groupInvolvedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'groupInvolved',
        value: '',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> moodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mood',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> moodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mood',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> moodEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mood',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> moodGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mood',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> moodLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mood',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> moodBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mood',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'peopleInvolved',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'peopleInvolved',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peopleInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'peopleInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'peopleInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'peopleInvolved',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'peopleInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'peopleInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
          QAfterFilterCondition>
      peopleInvolvedContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'peopleInvolved',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
          QAfterFilterCondition>
      peopleInvolvedMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'peopleInvolved',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'peopleInvolved',
        value: '',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> peopleInvolvedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'peopleInvolved',
        value: '',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> startTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> startTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> startTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> startTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'subActivity',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'subActivity',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subActivity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
          QAfterFilterCondition>
      subActivityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subActivity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
          QAfterFilterCondition>
      subActivityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subActivity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subActivity',
        value: '',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> subActivityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subActivity',
        value: '',
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar,
      QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TimeTrackerEntryIsarQueryObject on QueryBuilder<TimeTrackerEntryIsar,
    TimeTrackerEntryIsar, QFilterCondition> {}

extension TimeTrackerEntryIsarQueryLinks on QueryBuilder<TimeTrackerEntryIsar,
    TimeTrackerEntryIsar, QFilterCondition> {}

extension TimeTrackerEntryIsarQuerySortBy
    on QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QSortBy> {
  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByGroupInvolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupInvolved', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByGroupInvolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupInvolved', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByMoodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByPeopleInvolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleInvolved', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByPeopleInvolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleInvolved', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortBySubActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subActivity', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortBySubActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subActivity', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension TimeTrackerEntryIsarQuerySortThenBy
    on QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QSortThenBy> {
  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByEndTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endTime', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByGroupInvolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupInvolved', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByGroupInvolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'groupInvolved', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByMoodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mood', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByPeopleInvolved() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleInvolved', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByPeopleInvolvedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'peopleInvolved', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByStartTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startTime', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenBySubActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subActivity', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenBySubActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subActivity', Sort.desc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension TimeTrackerEntryIsarQueryWhereDistinct
    on QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct> {
  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct>
      distinctByActivity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activity', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct>
      distinctByEndTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endTime');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct>
      distinctByGroupInvolved({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'groupInvolved',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct>
      distinctByMood() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mood');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct>
      distinctByPeopleInvolved({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'peopleInvolved',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct>
      distinctByStartTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startTime');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct>
      distinctBySubActivity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subActivity', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, TimeTrackerEntryIsar, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension TimeTrackerEntryIsarQueryProperty on QueryBuilder<
    TimeTrackerEntryIsar, TimeTrackerEntryIsar, QQueryProperty> {
  QueryBuilder<TimeTrackerEntryIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, String, QQueryOperations>
      activityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activity');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, DateTime, QQueryOperations>
      endTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endTime');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, String?, QQueryOperations>
      groupInvolvedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'groupInvolved');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, int?, QQueryOperations> moodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mood');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, String?, QQueryOperations>
      peopleInvolvedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'peopleInvolved');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, DateTime, QQueryOperations>
      startTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startTime');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, String?, QQueryOperations>
      subActivityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subActivity');
    });
  }

  QueryBuilder<TimeTrackerEntryIsar, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
