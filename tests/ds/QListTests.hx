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

import haxe.ds.Vector;

import haxe.unit.TestRunner;
import haxe.unit.TestCase;

import qhx.ds.NoSuchElementException;
import qhx.ds.QList;
import qhx.ds.QList.QListIterator;

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
        var l1:QList<String> = new QList<String>();
        try {
            l1.get(-1);
            assertEquals(1, 2);
        } catch(e:NoSuchElementException) {
        }
        try {
            l1.get(0);
            assertEquals(1, 2);
        } catch(e:NoSuchElementException) {
        }
        try {
            l1.get(1);
            assertEquals(1, 2);
        } catch(e:NoSuchElementException) {
        }
        l1.addFirst("A");
        try {
            l1.get(-1);
            assertEquals(1, 2);
        } catch(e:NoSuchElementException) {
        }
        assertEquals("A", l1.get(0));
        try {
            l1.get(11);
            assertEquals(1, 2);
        } catch(e:NoSuchElementException) {
        }
        l1.addLast("B");
        assertEquals("A", l1.get(0));
        assertEquals("B", l1.get(1));
        l1.addLast("C");
        assertEquals("A", l1.get(0));
        assertEquals("B", l1.get(1));
        assertEquals("C", l1.get(2));
        l1.addLast("D");
        assertEquals("A", l1.get(0));
        assertEquals("B", l1.get(1));
        assertEquals("C", l1.get(2));
        assertEquals("D", l1.get(3));
        l1.addLast("E");
        assertEquals("A", l1.get(0));
        assertEquals("B", l1.get(1));
        assertEquals("C", l1.get(2));
        assertEquals("D", l1.get(3));
        assertEquals("E", l1.get(4));
        l1.addLast("F");
        assertEquals("A", l1.get(0));
        assertEquals("B", l1.get(1));
        assertEquals("C", l1.get(2));
        assertEquals("D", l1.get(3));
        assertEquals("E", l1.get(4));
        assertEquals("F", l1.get(5));
        l1.addLast("G");
        assertEquals("A", l1.get(0));
        assertEquals("B", l1.get(1));
        assertEquals("C", l1.get(2));
        assertEquals("D", l1.get(3));
        assertEquals("E", l1.get(4));
        assertEquals("F", l1.get(5));
        assertEquals("G", l1.get(6));
        try {
            l1.get(11);
            assertEquals(1, 2);
        } catch(e:NoSuchElementException) {
        }
    }

    public function testListRemoveFirst():Void {
        var l:QList<Int> = new QList<Int>();
        try {
            l.removeFirst();
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
        for(i in 0...10) {
            l.addLast(i);
        }
        assertEquals(false, l.isEmpty());
        for(i in 0...9) {
            var x:Int = l.removeFirst();
            assertEquals(i, x);
            assertEquals(false, l.isEmpty());
            assertEquals(10-1-i, l.size);
        }
        var x:Int = l.removeFirst();
        assertEquals(9, x);
        assertEquals(true, l.isEmpty());
        assertEquals(0, l.size);
        try {
            l.removeFirst();
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
    }

    public function testListRemoveLast():Void {
        var l:QList<Int> = new QList<Int>();
        try {
            l.removeLast();
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
        for(i in 0...10) {
            l.addLast(i);
        }
        assertEquals(false, l.isEmpty());
        for(i in 0...9) {
            var x:Int = l.removeLast();
            assertEquals(i, 9-x);
            assertEquals(false, l.isEmpty());
            assertEquals(10-1-i, l.size);
        }
        var x:Int = l.removeLast();
        assertEquals(0, x);
        assertEquals(true, l.isEmpty());
        assertEquals(0, l.size);
        try {
            l.removeLast();
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
    }

    public function testListRemove():Void {
        var l:QList<Int> = new QList<Int>();
        try {
            l.remove(0);
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
        try {
            l.remove(-1);
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
        try {
            l.remove(1);
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
        assertEquals(true, l.isEmpty());
        for(i in 1...11) {
            l.addLast(i);
        }
        for(i in 0...10) {
            var l2:QList<Int> = l.clone();
            assertEquals(i+1, l2.remove(i));
            assertEquals(9, l2.size);
        }
        try {
            l.remove(-1);
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
        try {
            l.remove(12);
            assertEquals(1, 0);
        } catch(e:NoSuchElementException) {
        }
    }

    public function testListRemoveLastElementOccurance():Void {
        var l:QList<Int> = new QList<Int>();
        assertEquals(-1, l.removeLastElementOccurance(1));
        l.addLast(2);
        l.addLast(1);
        l.addLast(2);
        l.addLast(3);
        l.addLast(1);
        l.addLast(4);
        l.addLast(8);
        assertEquals(4, l.removeLastElementOccurance(1));
        assertEquals("2,1,2,3,4,8", l.join(","));
    }

    public function testListRemoveFirstElementOccurance():Void {
        var l:QList<Int> = new QList<Int>();
        assertEquals(-1, l.removeFirstElementOccurance(1));
        l.addLast(2);
        l.addLast(1);
        l.addLast(2);
        l.addLast(3);
        l.addLast(1);
        l.addLast(4);
        l.addLast(8);
        assertEquals(1, l.removeFirstElementOccurance(1));
        assertEquals("2,2,3,1,4,8", l.join(","));
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
        var l:QList<Int> = new QList<Int>();
        l.sort(function(i:Int, j:Int) { return i - j; });
        assertEquals("", l.join(","));
        l.addFirst(1);
        l.sort(function(i:Int, j:Int) { return i - j; });
        assertEquals("1", l.join(","));
        l.addFirst(2);
        l.sort(function(i:Int, j:Int) { return i - j; });
        assertEquals("1,2", l.join(","));
        l.addFirst(3);
        l.sort(function(i:Int, j:Int) { return i - j; });
        assertEquals("1,2,3", l.join(","));
        assertEquals(1, l.getFirst());
        assertEquals(3, l.getLast());
        l.clear();
        l.addFirst(9);
        l.addFirst(3);
        l.addFirst(7);
        l.addFirst(8);
        l.addFirst(5);
        l.addFirst(1);
        l.addFirst(-1);
        l.addFirst(2);
        l.sort(function(i:Int, j:Int) { return i - j; });
        assertEquals("-1,1,2,3,5,7,8,9", l.join(","));
        assertEquals(-1, l.getFirst());
        assertEquals(9, l.getLast());
    }

    public function testListShuffle():Void {
        var l:QList<Int> = new QList<Int>();
        l.shuffle(); // should not fail on empty list
        for(i in 0...20) {
            l.addLast(i);
            l.shuffle(); // nor here!
            assertEquals(i + 1, l.size);
            assertEquals(false, l.isEmpty());
        }
        l.clear();
        l.addLast(1);
        l.addLast(2);
        var found1:Bool = false;
        var found2:Bool = false;
        for(i in 0...1000) {
            l.shuffle();
            if(l.getFirst() == 1) {
                found1 = true;
            }
            if(l.getFirst() == 2) {
                found2 = true;
            }
            if(found1 && found2) {
                break;
            }
        }
        assertEquals(true, found1 && found2);
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

    public function testListIterFrom():Void {
        var l:QList<Int> = new QList<Int>();
        for(ele in 0...20) {
            l.addLast(ele);
        }
        var s:String = "";
        for(ele in l.iteratorFrom(4)) {
            s = s + "," + ele;
        }
        assertEquals(",4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19", s);
        var s:String = "";
        for(ele in l.iteratorFrom(4, false)) {
            s = s + "," + ele;
        }
        assertEquals(",4,3,2,1,0", s);
    }

    public function testListIteratorNextIndex():Void {
        var l:QList<Int> = new QList<Int>();
        for(ele in 0...20) {
            l.addLast(ele * ele);
        }
        // normal usage
        var it:QListIterator<Int> = l.iterator();
        while(it.hasNext()) {
            var index:Int = it.index;
            var ele = it.next();
            assertEquals(index * index, ele);
        }
        // index forward
        var it:QListIterator<Int> = l.iterator();
        var pos:Int = 0;
        for(ele in it) {
            assertEquals(++pos, it.index);
        }
        // reverse iterator
        var it:QListIterator<Int> = l.reverseIterator();
        var pos:Int = 19;
        for(ele in it) {
            assertEquals(--pos, it.index);
        }
        // from forward iterator
        var it:QListIterator<Int> = l.iteratorFrom(4);
        var pos:Int = 4;
        for(ele in it) {
            assertEquals(++pos, it.index);
        }
        // from reversed iterator
        var it:QListIterator<Int> = l.iteratorFrom(4, false);
        var pos:Int = 4;
        for(ele in it) {
            assertEquals(--pos, it.index);
        }
    }

    public function testListIteratorClone():Void {
        var l:QList<Int> = new QList<Int>();
        for(ele in 0...5) {
            l.addLast(ele * ele);
        }
        // 2
        var s:String = "";
        var it:QListIterator<Int> = l.iterator();
        while(it.hasNext()) {
            var ele1:Int = it.next();
            var it2:QListIterator<Int> = it.clone();
            while(it2.hasNext()) {
                var ele2:Int = it2.next();
                s = s + "(" + ele1 + "," + ele2 + ")";
            }
        }
        assertEquals("(0,1)(0,4)(0,9)(0,16)(1,4)(1,9)(1,16)(4,9)(4,16)(9,16)", s);
        // 2r
        var s:String = "";
        var it:QListIterator<Int> = l.reverseIterator();
        while(it.hasNext()) {
            var ele1:Int = it.next();
            var it2:QListIterator<Int> = it.clone();
            while(it2.hasNext()) {
                var ele2:Int = it2.next();
                s = s + "(" + ele1 + "," + ele2 + ")";
            }
        }
        assertEquals("(16,9)(16,4)(16,1)(16,0)(9,4)(9,1)(9,0)(4,1)(4,0)(1,0)", s);
        // 3
        var s:String = "";
        var it:QListIterator<Int> = l.iterator();
        while(it.hasNext()) {
            var ele1:Int = it.next();
            var it2:QListIterator<Int> = it.clone();
            while(it2.hasNext()) {
                var ele2:Int = it2.next();
                var it3:QListIterator<Int> = it2.clone();
                while(it3.hasNext()) {
                    var ele3:Int = it3.next();
                    s = s + "(" + ele1 + "," + ele2 + "," + ele3 + ")";
                }
            }
        }
        assertEquals("(0,1,4)(0,1,9)(0,1,16)(0,4,9)(0,4,16)(0,9,16)(1,4,9)(1,4,16)(1,9,16)(4,9,16)", s);
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QListTests());
        tr.run();
    }
}
