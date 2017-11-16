/*
 * Copyright 2017
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import haxe.unit.TestRunner;
import haxe.unit.TestCase;

import qhx.QList;

/**
 * 
 */
class QListTests extends haxe.unit.TestCase {
    
    public function testNew():Void {
        // just check if constructors do not throw any kind of exceptions ...
        // this should never happen ...
        var l1:QList<Int> = new QList<Int>();
        var l2:QList<String> = new QList<String>();
        assertEquals(l1.size, 0);
        assertEquals(l2.size, 0);
    }

    public function testIsEmpty():Void {
        var l1:QList<Int> = new QList<Int>();
        var l2:QList<String> = new QList<String>();
        assertEquals(l1.isEmpty(), true);
        assertEquals(l2.isEmpty(), true);
        l1.addFirst(1);
        l2.addFirst("");
        assertEquals(l1.isEmpty(), false);
        assertEquals(l2.isEmpty(), false);
        l1.clear();
        l2.clear();
        assertEquals(l1.isEmpty(), true);
        assertEquals(l2.isEmpty(), true);
        l1.addLast(1);
        l2.addLast("");
        assertEquals(l1.isEmpty(), false);
        assertEquals(l2.isEmpty(), false);
    }
    
    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QListTests());
        tr.run();
    }

}
