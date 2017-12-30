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

abstract QString(String) {
    
    inline function new(s:String) {
        this = s;
    }
    
    @:from
    public static inline function fromStr(s:String):QString {
        return new QString(s);
    }
    
    @:to
    public inline function toStr():String {
        return this;
    }

    public inline function hashCode():Int {
        var result:Int = 5;
        for(i in 0...this.length) {
            result += 7 + 31 * this.charCodeAt(i);
        }
        return result;
    }

    public inline function equals(s:String) {
        return s == this;
    }
}
