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

/**
 * A pair object can hold exactly two objects of different
 * types.
 *
 * @author Yann Spoeri
 */
class QPair<U, V> {
    /**
     * The first element of `this` pair.
     */
    public var first:U = null;

    /**
     * The second element of `this` pair.
     */
    public var second:V = null;

    /**
     * Create a new pair object.
     */
    public function new(u:U, v:V) {
        this.first = u;
        this.second = v;
    }

}
