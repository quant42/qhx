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

package ds;

import haxe.unit.TestRunner;
import haxe.unit.TestCase;

import qhx.ds.QPair;

/**
 * Tests to verify that the implementation of the QPair works fine.
 */
class QPairTests extends haxe.unit.TestCase {
    
    public function testPairBasic():Void {
        var p:QPair<Int, String> = new QPair<Int, String>(1, "hello");
        assertEquals(1, p.first);
        assertEquals("hello", p.second);
        p.first = 2;
        p.second = "foobar";
        assertEquals(2, p.first);
        assertEquals("foobar", p.second);
    }

    public static function main():Void {
        var tr = new TestRunner();
        tr.add(new QPairTests());
        tr.run();
    }
}
