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
        assertEquals(0, hs.size);
        assertEquals("{}", hs.toString());
        var ele1:HashAble = new HashAble(0);
        var ele2:HashAble = new HashAble(0);
        hs.put(ele1);
        assertEquals(true, hs.contains(ele2));
        assertEquals(false, hs.isEmpty());
        assertEquals(1, hs.size);
        assertEquals(true, hs.contains(ele1));
        assertEquals(true, hs.contains(ele2));
        assertEquals("{1}", hs.toString());
        hs.put(ele1);
        assertEquals(false, hs.isEmpty());
        assertEquals(1, hs.size);
        hs.clear();        
        assertEquals(false, hs.contains(ele1));
        assertEquals(false, hs.contains(ele2));
        assertEquals(true, hs.isEmpty());
        assertEquals(0, hs.size);
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
    @:to
    private inline function toStr():String
    {
        return Std.string(s);
    }
    @:from
    static inline function fromInt(value:Int):HashAble
    {
        return new HashAble(value);
    }
}
