// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:collection';

import 'package:empty_collections/empty_collections.dart';
import 'package:test/test.dart';

void main() {
//  group('ClassUnderTest tests', () {
//    ClassUnderTest classUnderTest;
//
//    setUp(() {
//      //setup code
//      classUnderTest = new ClassUnderTest();
//    });
//
//    test('First Test', () {
//      expect(classUnderTest.hasProperty, isTrue);
//    });
//
//    test('Second Test', () {
//      expect(classUnderTest.property, isNotNull);
//    });
//  });
  group("EmptyIterator tests", () {
    testEmptyIterator();
  });
  group("EmptyIterable tests", () {
    var emptyIterable = const EmptyIterable();
    testEmptyIterable(emptyIterable, "base class");
  });
  group("EmptySet tests", () {
    testEmptySet();
  });
  group("EmptyList tests", () {
    testEmptyList();
  });
  group("EmptyLinkedList tests", () {
    testEmptyLinkedList();
  });
  group("EmptyQueue tests", () {
    testEmptyQueue();
  });
  group("EmptyMap tests", () {
    testEmptyMap();
  });
}

void testEmptyIterator() {
  var emptyIterator = const EmptyIterator();

  test('EmptyIterator.current-before hasNext', () {
    expect(emptyIterator.current, isNull);
  });
  test('EmptyIterator.hasNext()', () {
    expect(emptyIterator.moveNext(), isFalse);
  });
  test('EmptyIterator.current-after hasNext', () {
    expect(emptyIterator.current, isNull);
  });
}

void testEmptySet() {
  var emptySet = const EmptySet();
  const name = "EmptySet";
  testEmptyIterable(emptySet, name);
  testEmptyBasicCollectionMethods(emptySet, name);
  testEmptyRemoveRetainWhereCollectionMethods(emptySet, name);
}

void testEmptyList() {
  var emptyList = const EmptyList();
  const name = "EmptyList";
  testEmptyIterable(emptyList, name);
  testEmptyBasicCollectionMethods(emptyList, name);
  testEmptyRemoveRetainWhereCollectionMethods(emptyList, name);
  testOperators(emptyList, name, shouldAccessReturnNull: false, key: 1);
}

void testEmptyLinkedList() {
  var emptyLinkedList = const EmptyLinkedList();
  const name = "EmptyLinkedList";
  testEmptyIterable(emptyLinkedList, name);
  testEmptyBasicCollectionMethods(emptyLinkedList, name);
}

void testEmptyQueue() {
  var emptyQueue = const EmptyQueue();
  const name = "EmptyQueue";
  testEmptyIterable(emptyQueue, name);
  testEmptyBasicCollectionMethods(emptyQueue, name);
  testEmptyRemoveRetainWhereCollectionMethods(emptyQueue, name);
}

void testEmptyMap() {
  var emptyMap = const EmptyMap();
  const name = "EmptyMap";
  testIsEmpty(emptyMap, name);
  testOperators(emptyMap, name, shouldAccessReturnNull: true, key: 1);

  test("EmptyMap has no keys", ()  {
    expect(emptyMap.keys.length, equals(0));
  });
  test("EmptyMap has no values", ()  {
    expect(emptyMap.values.length, equals(0));
  });
  test("EmptyMap putIfAbsent() fails", ()  {
    expect(()=>emptyMap.putIfAbsent(1, ()=>"shouldn't be added"), throws);
  });
}

void testEmptyIterable(Iterable emptyIterable, String className) {
  testIsEmpty(emptyIterable, "EmptyIterable ($className)");
  test("EmptyIterable ($className) has empty iterator", () {
    expect(emptyIterable.iterator.moveNext(), isFalse);
  });
  test("EmptyIterable ($className) any() is always false", () {
    expect(emptyIterable.any((e)=>true), isFalse);
  });
  test("EmptyIterable ($className) doesnt contain the null element", () {
    expect(emptyIterable.contains(null), isFalse);
  });
  test("EmptyIterable ($className) can't use elementAt", () {
    expect(()=>emptyIterable.elementAt(0), throws);
  });
  test("EmptyIterable ($className) every() is always true", () {
    expect(emptyIterable.every((e)=>false), isTrue);
  });
  test("EmptyIterable ($className) expands to empty list", () {
    expect(emptyIterable.expand((e)=>[e, e]).isEmpty, isTrue);
  });
  test("EmptyIterable ($className) has no first element", () {
    expect(()=>emptyIterable.first, throws);
  });
  test("EmptyIterable ($className) firstWhere() returns orElse()", () {
    expect(
    emptyIterable.firstWhere(
        (e)=>true,
            orElse: ()=>"orElseResult"),
    equals("orElseResult")
  );
  });
  test("EmptyIterable ($className) fold() returns initial value", () {
    expect(
    emptyIterable.fold(
        "initialValue",
        (previousValue, newValue)=>"$previousValue-$newValue"),
    equals("initialValue")
  );
  });
  test("EmptyIterable ($className) forEach() has nothing to iterate over ", () {
    int count = 0;
    emptyIterable.forEach((e){count++;});
    expect(count, equals(0));
  });
  test("EmptyIterable ($className) join() has nothing to join ", () {
    expect(emptyIterable.join("-"), equals(""));
  });
  test("EmptyIterable ($className) has no last element", () {
    expect(()=>emptyIterable.last, throws);
  });
  test("EmptyIterable ($className) lastWhere() returns orElse()", () {
    expect(
        emptyIterable.lastWhere(
            (e)=>true,
            orElse: ()=>"orElseResult"),
        equals("orElseResult")
    );
  });
  test("EmptyIterable ($className) has zero length", () {
    expect(emptyIterable.length, equals(0));
  });
  test("EmptyIterable ($className) mapping returns empty iterable ", () {
    var mappedIterable = emptyIterable.map((elem)=>"-$elem-");
    expect(mappedIterable.length, equals(0));
  });
  test("EmptyIterable ($className) reduce() fails", () {
    expect(
        ()=>emptyIterable.reduce((first, second)=>"$first-$second"),
        throws
    );
  });
  test("EmptyIterable ($className) has no single element", () {
    expect(()=>emptyIterable.single, throws);
  });
  test("EmptyIterable ($className) has no single element with check", () {
    expect(()=>emptyIterable.singleWhere((e)=>true), throws);
  });
  test("EmptyIterable ($className) can skip ", () {
    expect(emptyIterable.skip(4).length, equals(0));
  });
  test("EmptyIterable ($className) can skip where", () {
    expect(emptyIterable.skipWhile((e)=>false).length, equals(0));
  });
  test("EmptyIterable ($className) can take ", () {
    expect(emptyIterable.take(4).length, equals(0));
  });
  test("EmptyIterable ($className) can take where ", () {
    expect(emptyIterable.takeWhile((e)=>true).length, equals(0));
  });
  test("EmptyIterable ($className) toGrowableList works ", () {
    var growableList = emptyIterable.toList(growable: true);
    expect(growableList.add(1), anything);
  });
  test("EmptyIterable ($className) toFixedList works ", () {
    var fixedList = emptyIterable.toList(growable: false);
    expect(()=>fixedList.add(1), throws);
  });
  test("EmptyIterable ($className) toSet creates empty set ", () {
    Set emptySet = emptyIterable.toSet();
    expect(emptySet.isEmpty, isTrue);
  });
  test("EmptyIterable ($className) where() creates empty iterable ", () {
    expect(emptyIterable.where((e)=>true).isEmpty, isTrue);
  });
}

// disable the type system to test by duck-typing
void testEmptyBasicCollectionMethods(
    dynamic emptyBasicCollection, String name) {
  test("$name add shouldn't work", () {
    expect(()=>emptyBasicCollection.add(1), throws);
  });
  test("$name addAll shouldn't work", () {
    expect(()=>emptyBasicCollection.add([1, 2]), throws);
  });
  test("$name clear should work", () {
    expect(emptyBasicCollection.clear(), anything);
  });
  test("$name remove shouldn't fail but return false", () {
    expect(emptyBasicCollection.remove(1), isFalse);
  });
}

// disable the type system to test by duck-typing
void testEmptyRemoveRetainWhereCollectionMethods(
    dynamic emptyCollection, String name) {
  test("$name removeWhere(predicate) should work", () {
    expect(emptyCollection.removeWhere((e)=>true), anything);
  });
  test("$name retainWhere(predicate) should work", () {
    expect(emptyCollection.retainWhere((e)=>false), anything);
  });
}

// disable the type system to test by duck-typing
void testIsEmpty(dynamic emptyCollection, String name) {
  test("$name isEmpty", () {
    expect(emptyCollection.isEmpty, isTrue);
  });
  test("$name isNotEmpty", () {
    expect(emptyCollection.isNotEmpty, isFalse);
  });
  test("$name length should be null", () {
    expect(emptyCollection.length, equals(0));
  });
}

// disable the type system to test by duck-typing
void testOperators(dynamic emptyCollection, String name,
    {bool shouldAccessReturnNull, key}) {
  // []= should always fail
  test("$name []= should fail", () {
    expect(()=>emptyCollection[key]="element", throws);
  });
  //[] fails or returns null
  if(shouldAccessReturnNull) {
    test("$name [$key] should reurn null", () {
      expect(emptyCollection[key], equals(null));
    });
  }else{
    test("$name [$key] should fail", () {
      expect(()=>emptyCollection[key], throws);
    });
  }
}