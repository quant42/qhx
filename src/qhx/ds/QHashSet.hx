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

import haxe.ds.Vector;

import qhx.ds.QList.QListIterator;

/**
 * A set to store elements of a certain type.
 *
 * @author Yann Spoeri
 */
class QHashSet<T:{function hashCode():Int; function equals(t:T):Bool;}> {
    /**
     * The load factor of `this` set. Once there are more elements
     * in `this` set than loadFact * storageSize, the internal
     * storeage of `this` set will get doubled.
     */
    public var loadFact(default, null):Float;

    /**
     * The number of elements currently stored in `this` set.
     */
    public var size(default, null):Int;

    /**
     * The storage in which `this` set saves its elements.
     */
    private var storage:Vector<QList<QHashSetElement<T>>>;

    /**
     * The first added element.
     */
    private var first:QHashSetElement<T>;

    /**
     * The last added element.
     */
    private var last:QHashSetElement<T>;

    /**
     * Create a new HashSet.
     */
    public function new(?size:Int=100, ?loadFact:Float=0.75) {
        // size should be at least 1
        if (size < 1) {
            throw "Size need to be bigger than 1!";
        }
        // load factor should be greater than 0
        if (loadFact <= 0 || loadFact >= 1) {
            throw "Load factor should be greater than 0 and smaller than 1!";
        }
        // now init
        this.loadFact = loadFact;
        this.size = 0;
        this.storage = new Vector<QList<QHashSetElement<T>>>(size);
        this.first = null;
        this.last = null;
    }

    /**
     * Check if `this` hashset is empty.
     */
    public inline function isEmpty():Bool {
        return size == 0;
    }

    /**
     * Remove all elements in `this` list.
     */
    public function clear(?size:Int=100):Void {
        // size should be at least 1
        if (size < 1) {
            throw "Size need to be bigger than 1!";
        }
        // ok, clear        
        this.size = 0;
        this.storage = new Vector<QList<QHashSetElement<T>>>(size);
        this.first = null;
        this.last = null;
    }

    /**
     * Helper function:
     *
     * For a given element, return the index where to store
     * the element in the storage.
     */
    private inline function getIndex(ele:T, storageSize:Int) {
        var index:Int = ele.hashCode() % storageSize;
        if(index < 0) {
            index = storageSize + index;
        }
        return index;
    }

    /**
     * Change the internal capacity of `this` hashset.
     */
    private inline function changeCapacity(newCapacity:Int):Void {
        // create a new vector with a higher capacity
        var newStorage:Vector<QList<QHashSetElement<T>>> =
            new Vector<QList<QHashSetElement<T>>>(newCapacity);
        // copy elements to newData
        var hce:QHashSetElement<T> = first;
        while (hce != null) {
            // get the position in data where to insert the object
            var index:Int = getIndex(hce.ele, newCapacity);
            // check if there's already a QList at the requested position
            // if not create one ...
            if (newStorage[index] == null) {
                newStorage[index] = new QList<QHashSetElement<T>>();
            }
            // add element to new QList
            newStorage[index].addFirst(hce);
            // next
            hce = hce.next;
        }
        // set data
        this.storage = newStorage;
    }

    /**
     * This is a helper function that checks whether a given item
     * may be found in list at index i.
     */
    private inline function listContains(item:T, index:Int):Bool {
        var result:Bool = false;
        if(this.storage[index] != null) {
            for(sItem in this.storage[index]) {
                if(sItem.ele.equals(item)) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }

    /**
     * Put an item into `this` hashset.
     */
    public function put(item:T):Bool {
        // get the hashCode of the item to add.
        var index:Int = getIndex(item, this.storage.length);
        // check if this element is already in `this` hashset.
        // if yes, we do not have to do anything.
        if(listContains(item, index)) {
            return false;
        }
        // ok, we have to add the item to `this` hashset.
        // check if we have to resize
        if(this.size * loadFact > this.size) {
            changeCapacity(this.storage.length * 2);
        }
        // create a new hashset element to add to this set
        var hce = new QHashSetElement(this.last, item, item.hashCode(), null);
        // now actually add it to storage
        this.size++;
        if(this.storage[index] == null) {
            var myList:QList<QHashSetElement<T>> = new QList<QHashSetElement<T>>();
            myList.addLast(hce);
            this.storage[index] = myList;
        } else {
            this.storage[index].addLast(hce);
        }
        // actual add it to list
        if(this.last != null) {
            this.last.next = hce;
        } else {
            this.first = hce;
        }
        this.last = hce;
        return true;
    }

    /**
     * Remove an element from `this` set.
     */
    public function remove(item:T):Bool {
        // get the hashCode of the item to remove.
        var index:Int = getIndex(item, this.storage.length);
        // check if this element is really in `this` hashset.
        // if no, we do not have to do anything.
        if(this.storage[index] != null) {
            var it:QListIterator<QHashSetElement<T>> = this.storage[index].iterator();
            while(it.hasNext()) {
                var index:Int = it.index;
                var sItem:QHashSetElement<T> = it.next();
                if(sItem.ele.equals(item)) {
                    // ok, we found the item ...
                    // now we have to remove this item ...
                    // ... from the storage
                    // TODO: speed this step up ...
                    var hce:QHashSetElement<T> = this.storage[index].remove(index);
                    // ... from size
                    this.size--;
                    // ... first and last
                    if(first == hce) {
                        first = hce.next;
                    }
                    if(last == hce) {
                        last = hce.prev;
                    }
                    // ... hce.prev and hce.next
                    if(hce.prev != null) {
                        hce.prev.next = hce.next;
                    }
                    if(hce.next != null) {
                        hce.next.prev = hce.prev;
                    }
                    // everything worked fine
                    return true;
                }
            }
        }
        // not found ... there is no such item in this set.
        return false;
    }

    /**
     * Check if `this` hashset contains an item.
     */
    public function contains(item:T):Bool {
        var index:Int = getIndex(item, this.storage.length);
        return listContains(item, index);
    }

    /**
     * Returns a textual representation of `this` set.
     */
    @:to
    public function toString():String {
        var result:StringBuf = new StringBuf();
        var firstE = true;
        var current:QHashSetElement<T> = first;
        result.add("{");
        while(current != null) {
            if(!firstE) {
                result.add(";");
            }
            result.add(Std.string(current.ele));
            firstE = false;
            current = current.next;
        }
        result.add("}");
        return result.toString();
    }

    /**
     * Create an iterator to iterate over `this` set.
     */
    public function iterator():Iterator<T> {
        return new QHashSetIterator(this.first);
    }

    // Just for compilation check test
    public static function main() {}
}

/**
 * A QHashSet-Element represents a single list element that can be
 * stored in an hashset.
 */
private class QHashSetElement<T> {
    /**
     * The element of that is stored.
     */
    public var ele(default, null):T;

    /**
     * The hashCode of the element of that is stored.
     */
    public var hashCode(default, null):Int;

    /**
     * The previous element in the set.
     */
    public var prev:QHashSetElement<T>;

    /**
     * The next element in the set.
     */
    public var next:QHashSetElement<T>;

    /**
     * Create a new QHashSetElement for storing the element.
     */
    public inline function new(prev:QHashSetElement<T>, ele:T, hashCode:Int, next:QHashSetElement<T>) {
        this.prev = prev;
        this.ele = ele;
        this.hashCode = hashCode;
        this.next = next;
    }
}

/**
 * An iterator to iterate over the elements in the hashset.
 */
class QHashSetIterator<T> {
    /**
     * The current element of `this` iterator.
     */
    private var current:QHashSetElement<T>;

    /**
     * Create a new iterator.
     */
    public inline function new(current:QHashSetElement<T>) {
        this.current = current;
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
        current = current.next;
        return val;
    }

    /**
     * Clone (the current state of) this iterator.
     */
    public inline function clone():QHashSetIterator<T> {
        return new QHashSetIterator<T>(this.current);
    }
}
