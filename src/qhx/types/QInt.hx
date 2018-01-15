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

package qhx.types;

abstract QInt(Int) to Int {
    
    inline function new(i:Int) {
        this = i;
    }
    
    @:from
    public static inline function fromInt(i:Int):QInt {
        return new QInt(i);
    }
    
    @:to
    public inline function toInt():Int {
        return this;
    }

    public inline function hashCode():Int {
        return this;
    }

    public inline function equals(i:Int) {
        return this == i;
    }
}
