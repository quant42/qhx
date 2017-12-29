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

package qhx.ds;

import haxe.ds.ListSort;
import haxe.ds.Vector;

/**
 * A list of elements similar to haxe.ds.List. However this list
 * is a double linked list and contains additional methods not
 * available in the standard haxe list implementation.
 *
 * @author Yann Spoeri
 */
class QList<T> {
    /**
     * The head of the list.
     */
    private var head:QListNode<T>;

    /**
     * The tail of the list.
     */
    private var tail:QListNode<T>;

    /**
     * The number of elements currently stored in `this` list.
     */
    public var size(default,null):Int;

    /**
     * Create a new QList.
     */
    public function new() {
        head = null;
        tail = null;
        size = 0;
    }

    /**
     * Check if `this` list is empty.
     */
    public inline function isEmpty():Bool {
        return size == 0;
    }

    /**
     * Clear `this` list.
     */
    public function clear():Void {
        head = null;
        tail = null;
        size = 0;
    }

    /**
     * Return a copy of `this` list.
     */
    public function clone():QList<T> {
        var l:QList<T> = new QList<T>();
        var current:QListNode<T> = head;
        while(current != null) {
            l.addLast(current.ele);
            current = current.next;
        }
        return l;
    }

    /**
     * Add an element `item` to the end of `this` QList.
     */
    public function addLast(item:T):Void {
        var lstEle:QListNode<T> = new QListNode<T>(tail, item, null);
        if(tail != null) {
            tail.next = lstEle;
        } else { // tail == null -> head == null
            head = lstEle;
        }
        tail = lstEle;
        size++;
    }

    /**
     * Add an element `item`to the beginning of `this` QList.
     */
    public function addFirst(item:T):Void {
        var lstEle:QListNode<T> = new QListNode<T>(null, item, head);
        if(head != null) {
            head.prev = lstEle;
        } else { // head == null -> tail == null
            tail = lstEle;
        }
        head = lstEle;
        size++;        
    }

    /**
     * Get the first element of `this` list.
     * An exception is thrown if `this` list is empty.
     * The list itself will not be modified.
     */
    public function getFirst():T {
        if(head == null) {
            throw new NoSuchElementException();            
        }
        return head.ele;
    }

    /**
     * Get the last element of `this` list.
     * An exception is thrown if `this` list is empty.
     * The list itself will not be modified.
     */
    public function getLast():T {
        if(tail == null) {
            throw new NoSuchElementException();
        }
        return tail.ele;
    }

    /**
     * Get an element of this list by it's index.
     * An exception is thrown if there is no such element in `this` list.
     * Please note, that indization on list is relatively slow (O(n)),
     * so if you relay heavely on this method, you may want to use
     * another datastructure instead!
     */
    public function get(i:Int):T {
        return _get(i).ele;
    }

    /**
     * Internal function to fastly get the QListNode element
     * at index i.
     */
    private function _get(i:Int):QListNode<T> {
        if(!(0 <= i && i < this.size)) {
            throw new NoSuchElementException();
        }
        if(i <= this.size / 2) {
            // if the element is in the beggining half
            // of the list => iterate from the beginning
            var current:QListNode<T> = head;
            while(current != null) {
                if(i == 0) {
                    return current;
                }
                i--;
                current = current.next;
            }
        } else {
            // the element is at the end of the list,
            // go from the end of the list
            // in order to get it ...
            var current:QListNode<T> = tail;
            i = this.size - 1 - i;
            while(current != null) {
                if(i == 0) {
                    return current;
                }
                i--;
                current = current.prev;
            }
        }
        throw new NoSuchElementException();
    }

    /**
     * Remove and return the first element of `this` list.
     * An exception is thrown if `this` list is empty.
     */
    public function removeFirst():T {
        if(isEmpty()) {
            throw new NoSuchElementException();
        }
        var result:T = head.ele;
        head = head.next;
        if(head == null) {
            tail = null;
        } else { // head != null
            head.prev = null;
        }
        size--;
        return result;
    }

    /**
     * Remove and return the last element of `this` list.
     * An exception is thrown if `this` list is empty.
     */
    public function removeLast():T {
        if(isEmpty()) {
            throw new NoSuchElementException();
        }
        var result:T = tail.ele;
        tail = tail.prev;
        if(tail == null) {
            head = null;
        } else { // tail != null
            tail.next = null;
        }
        size--;
        return result;
    }

    /**
     * This is a little helper function for internal use.
     * This function removes an QListNode from the list.
     * PAY ATTENTION: This function will not explicitly
     * check if the QListNode to remove really is an
     * element of this list (or the element of another
     * list).
     */
    private inline function removeElement(n:QListNode<T>):Void {
        if(n == head) {
            removeFirst();
        } else if(n == tail) {
            removeLast();
        } else {
            var p:QListNode<T> = n.prev;
            var n:QListNode<T> = n.next;
            p.next = n;
            n.prev = p;
            n.prev = null; // speedup garbage collection
            p.prev = null;
            size--;
        }
    }

    /**
     * Remove an element from `this` list by it's position `i`.
     * This function throws an exception, if the corresponding
     * position is not available.
     * This function returns the element that was stored at
     * that position.
     */
    public function remove(i:Int):T {
        var qn:QListNode<T> = _get(i);
        removeElement(qn);
        return qn.ele;
    }

    /**
     * Remove the first occurence of an element in `this` list.
     *
     * If `ele` is found (by checking standard equality) in the
     * list it will be removed and the function will return the
     * position from where this element has been removed.
     * Otherwise the function will return -1.
     */
    public function removeFirstElementOccurance(ele:T):Int {
        var current:QListNode<T> = head;
        var pos:Int = 0;
        while(current != null) {
            if(current.ele == ele) {
                removeElement(current);
                return pos;
            }
            pos++;
            current = current.next;
        }
        return -1;
    }

    /**
     * Remove the last occurence of an element in `this` list.
     *
     * If `ele` is found (by checking standard equality) in the
     * list it will be removed and the function will return the
     * position from where this element has been removed.
     * Otherwise the function will return -1.
     */
    public function removeLastElementOccurance(ele:T):Int {
        var current:QListNode<T> = tail;
        var pos:Int = size - 1;
        while(current != null) {
            if(current.ele == ele) {
                removeElement(current);
                return pos;
            }
            pos--;
            current = current.prev;
        }
        return -1;
    }

    /**
     * Return whether `this` list contains an element `ele`
     * (comparison made with `==` operator).
     */
    public function contains(ele:T):Bool {
        var current:QListNode<T> = head;
        while(current != null) {
            if(current.ele == ele) {
                return true;
            }
            current = current.next;
        }
        return false;
    }

    /**
     * Find the element `ele` in `this` list and
     * return it's position.
     * If the element `ele` cannot be found -1
     * will be returned.
     */
    public function find(ele:T):Int {
        var current:QListNode<T> = head;
        var pos:Int = 0;
        while(current != null) {
            if(current.ele == ele) {
                return pos;
            }
            pos++;
            current = current.next;
        }
        return -1;
    }

    /**
     * Returns a textual representation of `this` QList.
     */
    @:to
    public function toString():String {
        var result:StringBuf = new StringBuf();
        var first = true;
        var current:QListNode<T> = head;
        result.add("[");
        while(current != null) {
            if(!first) {
                result.add(",");
            }
            result.add(Std.string(current.ele));
            first = false;
            current = current.next;
        }
        result.add("]");
        return result.toString();
    }

    /**
     * Returns a string representation of `this` List. Each element in this list will
     * be seperated by using the `sep`-String as seperator.
     */
    public function join(sep:String):String {
        var result:StringBuf = new StringBuf();
        var first = true;
        var current:QListNode<T> = head;
        while(current != null) {
            if(!first) {
                result.add(sep);
            }
            result.add(Std.string(current.ele));
            first = false;
            current = current.next;
        }
        return result.toString();
    }

    /**
     * Filter this list and return a new list containing only those
     * elements, for which `f(x) == true`.
     */
    public function filter(f:T->Bool):QList<T> {
        var l2:QList<T> = new QList<T>();
        var current:QListNode<T> = head;
        while(current != null) {
            if(f(current.ele)) {
                l2.addLast(current.ele);
            }
            current = current.next;
        }
        return l2;
    }

    /**
     * Map a function onto a list. This means a new list
     * will be returned, where each element has been converted
     * by the function f.
     */
    public function map<U>(f:T->U):QList<U> {
        var l2:QList<U> = new QList<U>();
        var current:QListNode<T> = head;
        while(current != null) {
            l2.addLast(f(current.ele));
            current = current.next;
        }
        return l2;
    }

    /**
     * Rreverse `this` list.
     */
    public function reverse():Void {
        var current:QListNode<T> = head;
        while(current != null) {
            current.swap();
            current = current.prev; // prev = next, since we reversed this element already
        }
        var swap:QListNode<T> = head;
        head = tail;
        tail = swap;
    }

    /**
     * Returns a copy of this list as ds.haxe.List.
     */
    public function toHaxeList():List<T> {
        var l2:List<T> = new List<T>();
        var current:QListNode<T> = head;
        while(current != null) {
            l2.add(current.ele);
            current = current.next;
        }
        return l2;
    }

    /**
     * Creates a QList from an haxe list.
     */
    public static function fromHaxeList<T>(l:List<T>):QList<T> {
        var l2:QList<T> = new QList<T>();
        for(ele in l) {
            l2.addLast(ele);
        }
        return l2;
    }

    @:from
    public function fromHaxeListC<T>(l:List<T>):QList<T> {
        var l2:QList<T> = new QList<T>();
        for(ele in l) {
            l2.addLast(ele);
        }
        return l2;
    }

    /**
     * Create a haxe vector that contains the elements of `this` list.
     */
    public function toHaxeVector():Vector<T> {
        var result:Vector<T> = new Vector<T>(this.size);
        var i:Int = 0;
        var current:QListNode<T> = head;
        while(current != null) {
            result[i++] = current.ele;
            current = current.next;
        }
        return result;
    }

    /**
     * Creates a QList from a haxe vector.
     */
    public static function fromHaxeVector<T>(l:Vector<T>):QList<T> {
        var l2:QList<T> = new QList<T>();
        for(i in 0...l.length) {
            l2.addLast(l[i]);
        }
        return l2;
    }

    /**
     * Sort the elements in `this` QList according to a
     * comparator function `f`.
     *
     * `f(x,y)` should return 0 if x == y,
     * `f(x,y)` should return >0 if x > y and
     * `f(x,y)` should return <0 if x < y.
     *
     * This function modifies the list inplace.
     */
    public function sort(f:T->T->Int):Void {
        // trivial cases for sorting
        // (maximal one element in list)
        if(this.size <= 1) {
            return;
        }
        // ok, use haxes default listsort for this
        head = ListSort.sort(head, function(e1:QListNode<T>, e2:QListNode<T>) { return f(e1.ele, e2.ele); });
        while(tail.next != null) {
            tail = tail.next;
        }
    }

    /**
     * Shuffles the elements in `this` list.
     */
    public function shuffle():Void {
        sort(function(t1:T, t2:T) { return (Math.random() > 0.5) ? -1 : 1; });
    }

    /**
     * Returns an iterator to iterate over the elements in `this` list.
     */
    public inline function iterator():QListIterator<T> {
        return new QListIterator<T>(this.head, DIRECTION.FORWARD, 0);
    }

    /**
     * Returns an iterator to iterate in reversed direction over the
     * elements in `this` lis.
     */
    public inline function reverseIterator():QListIterator<T> {
        return new QListIterator<T>(this.tail, DIRECTION.REVERSED, size - 1);
    }

    /**
     * Returns an iterator that starts to iterate over a list
     * beginning from position `pos` in `this` list.
     * This method will throw an exception, if `this` list has
     * no element at the given position `pos`.
     */
    public inline function iteratorFrom(pos:Int, ?forward:Bool=true):QListIterator<T> {
        return (forward) ?
            new QListIterator<T>(_get(pos), DIRECTION.FORWARD, pos) :
            new QListIterator<T>(_get(pos), DIRECTION.REVERSED, pos);
    }

    // Just for compilation check test
    public static function main() {}
}

/**
 * A QListNode-Element represents a single list element that stores
 * a single list item.
 */
private class QListNode<T> {
    /**
     * The element of this list node.
     */
    public var ele:T;

    /**
     * The next element in the list.
     */
    public var next:QListNode<T>;

    /**
     * The previous element in the list.
     */
    public var prev:QListNode<T>;

    /**
     * Create a new QListNode-Element for storing the element.
     */
    public inline function new(prev:QListNode<T>, ele:T, next:QListNode<T>) {
        this.prev = prev;
        this.ele = ele;
        this.next = next;
    }

    /**
     * Swap next and prev.
     */
    public inline function swap():Void {
        var swap:QListNode<T> = this.prev;
        this.prev = this.next;
        this.next = swap;
    }
}

/**
 * An enum to set the direction of the iteration.
 */
enum DIRECTION {
    FORWARD;
    REVERSED;
}

/**
 * An iterator to iterate over the elements in the list.
 */
class QListIterator<T> {
    /**
     * The current element of `this` iterator.
     */
    private var current:QListNode<T>;

    /**
     * The direction of the iteration.
     */
    public var direction(default, null):DIRECTION;

    /**
     * The index of the current element.
     */
    public var index(default, null):Int;

    /**
     * Create a new iterator.
     */
    public inline function new(current:QListNode<T>, direction:DIRECTION, index:Int) {
        this.current = current;
        this.direction = direction;
        this.index = index;
    }

    /**
     * Whether there is a next element in the iterator.
     */
    public inline function hasNext():Bool {
        return current != null;
    }

    /**
     * Get the next element.
     */
    public inline function next():T {
        var val:T = current.ele;
        if(direction == DIRECTION.FORWARD) {
            current = current.next;
            index++;
        } else {
            current = current.prev;
            index--;
        }
        return val;
    }

    /**
     * Clone (the current state of) this iterator.
     */
    public inline function clone():QListIterator<T> {
        return new QListIterator<T>(this.current, this.direction, this.index);
    }
}
