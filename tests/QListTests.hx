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
    
    public function testListFctionsBasic():Void {
        // Check the constructors
        var l1:QList<Int> = new QList<Int>();
        var l2:QList<String> = new QList<String>();
        assertEquals(0, l1.size);
        assertEquals(0, l2.size);
        var l1:QList<Int> = new QList<Int>();
        var l2:QList<String> = new QList<String>();
        assertEquals(true, l1.isEmpty());
        assertEquals(true, l2.isEmpty());
        l1.addFirst(1);
        l2.addFirst("");
        assertEquals(1, l1.size);
        assertEquals(1, l2.size);
        assertEquals(false, l1.isEmpty());
        assertEquals(false, l2.isEmpty());
        l1.clear();
        l2.clear();
        assertEquals(0, l1.size);
        assertEquals(0, l2.size);
        assertEquals(true, l1.isEmpty());
        assertEquals(true, l2.isEmpty());
        l1.addLast(1);
        l2.addLast("");
        assertEquals(1, l1.size);
        assertEquals(1, l2.size);
        assertEquals(false, l1.isEmpty());
        assertEquals(false, l2.isEmpty());
        l1.addLast(2);
        l2.addLast("a");
        assertEquals(false, l1.isEmpty());
        assertEquals(false, l2.isEmpty());
        assertEquals(2, l1.size);
        assertEquals(2, l2.size);
    }

    public function testListContains():Void {
        var l:QList<Int> = new QList<Int>();
        assertEquals(false, l.contains(1));
        assertEquals(false, l.contains(3));
        l.addLast(1);
        assertEquals(true, l.contains(1));
        l.addLast(1);
        l.addLast(1);
        assertEquals(false, l.contains(3));
        l.addLast(1);
        l.addLast(3);
        l.addLast(1);
        assertEquals(true, l.contains(3));
    }

    public function testListFind():Void {
        var l:QList<Int> = new QList<Int>();
        assertEquals(-1, l.find(1));
        assertEquals(-1, l.find(2));
        assertEquals(-1, l.find(3));
        l.addLast(1);
        assertEquals(0, l.find(1));
        assertEquals(-1, l.find(2));
        assertEquals(-1, l.find(3));
        l.addLast(5);
        assertEquals(0, l.find(1));
        assertEquals(1, l.find(5));
        assertEquals(-1, l.find(3));
        l.addLast(-1);
        assertEquals(0, l.find(1));
        assertEquals(1, l.find(5));
        assertEquals(2, l.find(-1));
    }

    public function testListToString():Void {
        var l:QList<Int> = new QList<Int>();
        assertEquals("[]", l.toString());
        l.addLast(1);
        assertEquals("[1]", l.toString());
        l.addLast(2);
        assertEquals("[1,2]", l.toString());
    }

    public function testListJoin():Void {
        var l:QList<Int> = new QList<Int>();
        assertEquals("", l.join(","));
        assertEquals("", l.join(";"));
        assertEquals("", l.join("|"));
        l.addLast(1);
        assertEquals("1", l.join(","));
        assertEquals("1", l.join(";"));
        assertEquals("1", l.join("|"));
        l.addLast(2);
        assertEquals("1,2", l.join(","));
        assertEquals("1;2", l.join(";"));
        assertEquals("1|2", l.join("|"));
    }

    public function testListFilter():Void {
        var l:QList<Int> = new QList<Int>();
        var lF:QList<Int> = l.filter(function(i:Int):Bool { return i % 2 == 0; });
        assertEquals("", lF.join(","));

        for(i in 0...10) {
            l.addLast(i);
        }
        assertEquals("0,1,2,3,4,5,6,7,8,9", l.join(","));

        var lF:QList<Int> = l.filter(function(i:Int):Bool { return i % 2 == 0; });
        assertEquals("0,2,4,6,8", lF.join(","));

        l.clear();
        l.addLast(1);
        var lF:QList<Int> = l.filter(function(i:Int):Bool { return i % 2 == 0; });
        assertEquals("", lF.join(","));
    }

    public function testListMap():Void {
        var l:QList<Int> = new QList<Int>();

        assertEquals("", l.join(","));
        var lM:QList<Int> = l.map(function(i:Int):Int { return i * i; });
        assertEquals("", lM.join(","));

        l.addLast(1);
        assertEquals("1", l.join(","));
        var lM:QList<Int> = l.map(function(i:Int):Int { return i * i; });
        assertEquals("1", lM.join(","));

        l.addLast(2);
        assertEquals("1,2", l.join(","));
        var lM:QList<Int> = l.map(function(i:Int):Int { return i * i; });
        assertEquals("1,4", lM.join(","));

        l.addLast(3);
        assertEquals("1,2,3", l.join(","));
        var lM:QList<Int> = l.map(function(i:Int):Int { return i * i; });
        assertEquals("1,4,9", lM.join(","));        
    }

    public function testListReverse():Void {
        var l:QList<Int> = new QList<Int>();

        assertEquals("", l.join(","));
        l.reverse();
        assertEquals("", l.join(","));
        l.reverse();
        assertEquals("", l.join(","));
        assertEquals(0, l.size);

        l.addLast(1);
        assertEquals("1", l.join(","));
        l.reverse();
        assertEquals("1", l.join(","));
        l.reverse();
        assertEquals("1", l.join(","));
        assertEquals(1, l.size);

        var lF:String = "1";
        var lR:String = "1";
        var count:Int = 1;
        for(nr in 2...20) {
            l.addLast(nr);
            lF = lF + "," + nr;
            lR = nr + "," + lR;
            count++;
            assertEquals(lF, l.join(","));
            l.reverse();
            assertEquals(lR, l.join(","));
            l.reverse();
            assertEquals(lF, l.join(","));
            assertEquals(count, l.size);
        }
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QListTests());
        tr.run();
    }
}
