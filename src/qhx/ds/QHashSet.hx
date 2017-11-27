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

/**
 * A set to store elements of a certain type.
 *
 * @author Yann Spoeri
 */
class QHashSet<T> {
    /**
     * The load factor of `this` set. Once there are more elements
     * in `this` set than loadFact * storageSize, the internal
     * storeage of `this` set will get doubled.
     */
    private var loadFact:Float;

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
    public var first(default, null):QHashSetElement<T>;

    /**
     * The last added element.
     */
    public var last(default, null):QHashSetElement<T>;

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
    public function clear():Void {
        this.size = 0;
        this.storage = new Vector<QList<QHashSetElement<T>>>(this.storage.length);
        this.first = null;
        this.last = null;
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
            var index:Int = hce.getIndex(newCapacity);
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

    /**
     * For a given capacity, return the index where to store
     * `this` element in the storage.
     */
    public inline function getIndex(capacity:Int) {
        var index:Int = this.hashCode % capacity;
        if(index < 0) {
            index = capacity + index;
        }
        return index;
    }
}
