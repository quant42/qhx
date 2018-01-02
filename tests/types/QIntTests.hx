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

package types;

import haxe.unit.TestRunner;
import haxe.unit.TestCase;

import qhx.types.QInt;

/**
 * Tests to verify that the implementation of the QBool type works fine.
 */
class QIntTests extends haxe.unit.TestCase {
    
    public function testQFloatBasic():Void {
        var qi1:QInt = 3;
        var qi2:QInt = 1;
        var i1:Float = 3;
        var i2:Float = 1;
        assertEquals(i1 * i2, qi1.toInt() * qi2.toInt());
        assertEquals(false, qi1.hashCode() == qi2.hashCode());
        assertEquals(false, qi1.equals(qi2));
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QIntTests());
        tr.run();
    }
}
