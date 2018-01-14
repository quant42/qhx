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

package types;

import haxe.unit.TestRunner;
import haxe.unit.TestCase;

import qhx.types.QBool;

/**
 * Tests to verify that the implementation of the QBool type works fine.
 */
class QBoolTests extends haxe.unit.TestCase {
    
    public function testQBoolBasic():Void {
        var f:QBool = false;
        var t:QBool = true;
        assertEquals(false, f);
        assertEquals(true, t);
        if(f.toBool()) {
            assertEquals("a", "b");
        }
        if(!t) {
            assertEquals("a", "b");
        }
        assertEquals(0, f.hashCode());
        assertEquals(1, t.hashCode());
        var f2:QBool = false;
        var t2:QBool = true;
        assertEquals(false, f == t2);
        assertEquals(true, f == f2);
        assertEquals(true, t == t2);
        assertEquals(false, t == f2);

        assertEquals(false, f.equals(t2));
        assertEquals(true, f.equals(f2));
        assertEquals(true, t.equals(t2));
        assertEquals(false, t.equals(f2));
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QBoolTests());
        tr.run();
    }
}
