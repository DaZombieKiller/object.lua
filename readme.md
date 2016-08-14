# object.lua
## Object system for Lua
Designed for use with Love2D  
written by TheZombieKiller

## Dependencies
[deepcopy.lua](https://gist.github.com/DaZombieKiller/1b5690842b8138a4024c55760e2d253f#file-deepcopy-lua) (included)

## Usage
    object: <object name>
    {
        member = default_value;
        
        construct = function(...)
        end;
        
        destruct = function(...)
        end;
        
        <et cetera>
    }

    local instance = new: <object name>(...)
    print(typeof(instance))
    instance.method(...)
    event: update() -- calls update method on all instances that have it
    delete(instance)

An object cannot contain a member named "self".  

Usage of self.\<member name\> inside a member function is not necessary, as you can access the member directly, without using "self".  

However, you can optionally use it anyway, because self is automatically assigned to the instance.

## License
Copyright (c) 2016 Benjamin Moir

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
