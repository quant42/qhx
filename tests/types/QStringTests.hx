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

import qhx.types.QString;

/**
 * Tests to verify that the implementation of the QBool type works fine.
 */
class QStringTests extends haxe.unit.TestCase {
    
    public function testQFloatBasic():Void {
        var qs1:QString = "HELLO";
        var qs2:QString = "WORLD";
        var is:String = "HELLO";
        var is:String = "WORLD";
        assertEquals(false, qs1.hashCode() == qs2.hashCode());
        assertEquals(false, qs1.equals(qs2));
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QStringTests());
        tr.run();
    }
}
