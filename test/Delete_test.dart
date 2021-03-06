//Copyright (C) 2013 Potix Corporation. All Rights Reserved.
//History: Fri, Feb 22, 2013  04:33:48 PM
// Author: henrichen

import 'dart:async';
import 'dart:convert' show UTF8;
import 'package:logging/logging.dart';
import 'package:unittest/unittest.dart';
import 'package:memcached_client/memcached_client.dart';
import 'package:couchclient/couchclient.dart';
import 'CouchbaseTestUtil.dart' as cc;

//delete key3
void testDelete1(CouchClient client) {
  expect(client.set('key3', UTF8.encode('va13')), completion(isTrue));
  expect(client.delete('key3'), completion(isTrue));
}

//delete inexist key3; should throw NOT_FOUND
void testDelete2(CouchClient client) {
  expect(client.delete('key3'), throwsA(equals(OPStatus.KEY_NOT_FOUND)));
}

void main() {
  setupLogger(level: Level.ALL);
  group('CouchDeleteTest:', () {
    CouchClient client;
    setUp(() => cc.prepareCouchClient().then((c) => client = c));
    tearDown(() => client.close());
    test('TestDelete1', () => testDelete1(client));
    test('TestDelete2', () => testDelete2(client));
  });
}



