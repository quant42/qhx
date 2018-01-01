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

import qhx.types.QFloat;

/**
 * Tests to verify that the implementation of the QBool type works fine.
 */
class QFloatTests extends haxe.unit.TestCase {
    
    public function testQFloatBasic():Void {
        var qf1:QFloat = 3.141592;
        var qf2:QFloat = 1.618;
        var f1:Float = 3.141592;
        var f2:Float = 1.618;
        assertEquals(f1 * f2, qf1.toFloat() * qf2.toFloat());
        assertEquals(false, qf1.hashCode() == qf2.hashCode());
        assertEquals(false, qf1.equals(qf2));
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QFloatTests());
        tr.run();
    }
}
