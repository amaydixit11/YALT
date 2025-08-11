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
