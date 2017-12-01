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

package ds;

import haxe.unit.TestRunner;
import haxe.unit.TestCase;

import qhx.ds.QHashSet;

/**
 * Tests to verify that the implementation of the QHashSet works fine.
 */
class QHashSetTests extends haxe.unit.TestCase {

    public function testHashSetBasic():Void {
        var hs:QHashSet<HashAble> = new QHashSet<HashAble>();
        assertEquals(true, hs.isEmpty());
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QHashSetTests());
        tr.run();
    }
}

private class HashAble {
    var s:Int = 0;
    public function new(i:Int) {
        s = i;
    }
    public function equals(o:HashAble):Bool {
        return o.s == this.s;
    }
    public function hashCode():Int {
        return s;
    }
}
