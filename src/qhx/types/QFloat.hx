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

abstract QFloat(Float) to Float {
    
    inline function new(i:Float) {
        this = i;
    }
    
    @:from
    public static inline function fromFloat(i:Float):QFloat {
        return new QFloat(i);
    }
    
    @:to
    public inline function toFloat():Float {
        return this;
    }

    public inline function hashCode():Int {
        return Math.ceil(this);
    }

    public inline function equals(i:Float) {
        return this == i;
    }

}
