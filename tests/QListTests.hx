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

import haxe.ds.Vector;

import haxe.unit.TestRunner;
import haxe.unit.TestCase;

import qhx.NoSuchElementException;
import qhx.QList;

/**
 * Tests to verify that the implementation of the QList works fine.
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

    public function testListIsEmpty():Void {
        var l1:QList<Int> = new QList<Int>();
        assertEquals(true, l1.isEmpty());
        l1.addLast(1);
        assertEquals(false, l1.isEmpty());
        l1.clear();
        assertEquals(true, l1.isEmpty());
        l1.addFirst(1);
        assertEquals(false, l1.isEmpty());
        l1.removeFirst();
        assertEquals(true, l1.isEmpty());
        l1.addLast(1);
        assertEquals(false, l1.isEmpty());
        l1.removeLast();
        assertEquals(true, l1.isEmpty());
        l1.addFirst(1);
        assertEquals(false, l1.isEmpty());
        l1.removeFirstElementOccurance(2);
        assertEquals(false, l1.isEmpty());
        l1.removeFirstElementOccurance(1);
        assertEquals(true, l1.isEmpty());
        l1.addFirst(1);
        assertEquals(false, l1.isEmpty());
        l1.removeLastElementOccurance(2);
        assertEquals(false, l1.isEmpty());
        l1.removeLastElementOccurance(1);
        assertEquals(true, l1.isEmpty());
        assertEquals(true, l1.isEmpty());
    }

    public function testListClear():Void {
        var l1:QList<Int> = new QList<Int>();
        assertEquals("", l1.join(","));
        l1.clear();
        l1.addFirst(1);
        assertEquals("1", l1.join(","));
        l1.clear();
        assertEquals("", l1.join(","));
    }

    public function testListClone():Void {
        var l1:QList<Int> = new QList<Int>();
        var l2:QList<Int> = l1.clone();
        assertEquals("", l2.join(","));
        l1.addFirst(1);
        assertEquals("1", l1.join(","));
        assertEquals("", l2.join(","));
        l2 = l1.clone();
        assertEquals("1", l1.join(","));
        assertEquals("1", l2.join(","));
        l1.addLast(2);
        l2 = l1.clone();
        assertEquals("1,2", l1.join(","));
        assertEquals("1,2", l2.join(","));
        l1.addLast(3);
        l2 = l1.clone();
        assertEquals("1,2,3", l1.join(","));
        assertEquals("1,2,3", l2.join(","));
        l1.addLast(4);
        l2 = l1.clone();
        assertEquals("1,2,3,4", l1.join(","));
        assertEquals("1,2,3,4", l2.join(","));
    }

    public function testListAddFirst():Void {
        var l1:QList<Int> = new QList<Int>();
        assertEquals(0, l1.size);
        assertEquals(true, l1.isEmpty());
        assertEquals("", l1.join(","));
        l1.addFirst(1);
        assertEquals(1, l1.size);
        assertEquals(false, l1.isEmpty());
        assertEquals("1", l1.join(","));
        var s:String = "1";
        for(i in 2...10) {
            l1.addFirst(i);
            assertEquals(i, l1.size);
            assertEquals(false, l1.isEmpty());
            s = i + "," + s;
            assertEquals(s, l1.join(","));
        }
    }

    public function testListAddLast():Void {
        var l1:QList<Int> = new QList<Int>();
        assertEquals(0, l1.size);
        assertEquals(true, l1.isEmpty());
        assertEquals("", l1.join(","));
        l1.addLast(1);
        assertEquals(1, l1.size);
        assertEquals(false, l1.isEmpty());
        assertEquals("1", l1.join(","));
        var s:String = "1";
        for(i in 2...10) {
            l1.addLast(i);
            assertEquals(i, l1.size);
            assertEquals(false, l1.isEmpty());
            s = s + "," + i;
            assertEquals(s, l1.join(","));
        }
    }

    public function testListGetFirst():Void {
        var l1:QList<Int> = new QList<Int>();
        try {
            l1.getFirst();
            assertEquals(1, 2);
        } catch(e:NoSuchElementException) {
        }
        l1.addFirst(1);
        assertEquals(1, l1.getFirst());
        for(i in 2...10) {
            l1.addFirst(i);
            assertEquals(i, l1.getFirst());
        }
        for(i in 99...110) {
            l1.addLast(i);
            assertEquals(9, l1.getFirst());
        }
    }

    public function testListGetLast():Void {
        var l1:QList<Int> = new QList<Int>();
        try {
            l1.getLast();
            assertEquals(1, 2);
        } catch(e:NoSuchElementException) {
        }
        l1.addFirst(1);
        assertEquals(1, l1.getLast());
        for(i in 2...10) {
            l1.addFirst(i);
            assertEquals(1, l1.getLast());
        }
        for(i in 99...110) {
            l1.addLast(i);
            assertEquals(i, l1.getLast());
        }
    }

    public function testListGet():Void {
        
    }

    public function testListRemoveFirst():Void {
    }

    public function testListRemoveLast():Void {
    }

    public function testListRemoveLastElementOccurance():Void {
    }

    public function testListRemoveFirstElementOccurance():Void {
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
        l.addLast(5);
        assertEquals(1, l.find(5));
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

    public function testListToHaxeList():Void {
        var l:QList<Int> = new QList<Int>();
        assertEquals(l.toHaxeList().join(","), l.join(","));
        for(i in 1...10) {
            l.addFirst(i);
            assertEquals(l.toHaxeList().join(","), l.join(","));
        }
    }

    public function testListFromHaxeList():Void {
        var l:List<Int> = new List<Int>();
        assertEquals(QList.fromHaxeList(l).join(","), l.join(","));
        for(i in 1...10) {
            l.push(i);
            assertEquals(QList.fromHaxeList(l).join(","), l.join(","));
        }
    }

    public function testListToHaxeVector():Void {
        var l:QList<Int> = new QList<Int>();
        assertEquals(l.toHaxeVector().join(","), l.join(","));
        for(i in 1...10) {
            l.addFirst(i);
            assertEquals(l.toHaxeVector().join(","), l.join(","));
        }
    }

    public function testListFromHaxeVector():Void {
        var l:Vector<Int> = new Vector<Int>(0);
        assertEquals(QList.fromHaxeVector(l).join(","), l.join(","));
        for(i in 1...10) {
            var l:Vector<Int> = new Vector<Int>(i);
            for(pos in 0...i) {
                l[pos] = pos+1;
            }
            assertEquals(QList.fromHaxeVector(l).join(","), l.join(","));
        }
    }

    public function testListSort():Void {
    }

    public function testListIterator():Void {
        var l:QList<Int> = new QList<Int>();
        for(ele in l) {
            assertEquals(1, 2);
        }
        l.addLast(1);
        var s:String = "";
        for(ele in l) {
            s = s + "," + ele;
        }
        assertEquals(",1", s);
        var exp:String = ",1";
        for(i in 2...10) {
            l.addLast(i);
            exp = exp + "," + i;
            var s:String = "";
            for(ele in l) {
                s = s + "," + ele;
            }
            assertEquals(exp, s);
        }
    }

    public function testListReverseIterator():Void {
        var l:QList<Int> = new QList<Int>();
        for(ele in l) {
            assertEquals(1, 2);
        }
        l.addFirst(1);
        var s:String = "";
        for(ele in l.reverseIterator()) {
            s = s + "," + ele;
        }
        assertEquals(",1", s);
        var exp:String = ",1";
        for(i in 2...10) {
            l.addFirst(i);
            exp = exp + "," + i;
            var s:String = "";
            for(ele in l.reverseIterator()) {
                s = s + "," + ele;
            }
            assertEquals(exp, s);
        }
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QListTests());
        tr.run();
    }
}
