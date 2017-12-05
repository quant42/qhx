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

package qhx;

/**
 * The parental object of all objects of this library.
 *
 * @author Yann Spoeri
 */
class QObject {
    /**
     * Returns a hashCode for `this` object.
     */
    public inline function hashCode():Int {
        throw "Not implemented!";
    }

    /**
     * The equal-method checks if `this` object equals
     * to another object.
     */
    public inline function equals(o:QObject):String {
        // default
        if(o == null) {
            return false;
        }
        return this == o;
    }

    /**
     * The toString-Method returns a textual representation
     * of `this` object.
     */
    public inline function toString():String {
        // default
        return Std.string(this);
    }
}
