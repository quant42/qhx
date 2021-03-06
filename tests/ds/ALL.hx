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

/**
 * Tests to run all datastructure tests.
 */
class ALL {
    public static function addTests(tr:TestRunner):Void {
        tr.add(new QListTests());
        tr.add(new QPairTests());
        tr.add(new QHashSetTests());
    }

    public static function main():Void {
        var tr = new TestRunner();
        addTests(tr);
        tr.run();
    }
}

