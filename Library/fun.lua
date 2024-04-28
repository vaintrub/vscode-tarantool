---@meta

--luacheck:ignore
---@class fun
local fun = {}

---@class fun.iterator:table
---@operator call: any
---@field gen any
---@field param any
---@field state any
local i = {}

---Wraps generator into fun.iterator
---@generic P,S
---@param gen any
---@param param? P
---@param state? S
---@return fun.iterator, P, S
function fun.wrap(gen, param, state) end

---Unwraps iterator to gen, param, state
---@generic P,S
---@return any gen, P param, S state
function i:unwrap() end

---@generic P,S
---@alias G<T> fun(param:T,state):_,any

---@alias fun.iterable string|function|table|any[]|fun.iterator

---@generic P,S
---@param obj fun.iterable
---@param param? P
---@param state? S
---@return fun.iterator, P, S
function fun.iter(obj, param, state) end

---@param f fun(item: any, ...)
---@param g fun.iterable
---@param p? any
---@param s? any
function fun.each(f, g, p, s) end
fun.for_each = fun.each
fun.foreach = fun.each


---@param f fun(item: any, ...)
function i:each(f) end
i.for_each = i.each
i.foreach = i.each


--#region generators

---The iterator to create arithmetic progressions.
---
---Iteration values are generated within closed interval [start, stop] (i.e. stop is included).
---
---@param start number
---@param stop? number (default: start)
---@param step? number (default: 1)
---@return fun.iterator, {[1]:number, [2]:number }, number
function fun.range(start, stop, step) end

---The iterator returns values over and over again indefinitely.
---
---All values that passed to the iterator are returned as-is during the iteration.
---@param ... any
---@return fun.iterator
function fun.duplicate(...) end
fun.replicate = fun.duplicate
fun.xrepeat = fun.duplicate

---The iterator that returns fun(0), fun(1), fun(2), ... values indefinitely.
---@generic F:fun(n: number): ...
---@param f F
---@return fun.iterator, F, number
function fun.tabulate(f) end

---The iterator returns 0 indefinitely.
---@return fun.iterator, number, number
function fun.zeros() end

---The iterator that returns 1 indefinitely.
---@return fun.iterator, number, number
function fun.ones() end

---The iterator returns random values using math.random().
---
---If the n and m are set then the iterator returns pseudo-random integers in the [n, m) interval (i.e. m is not included)
---
---If the m is not set then the iterator generates pseudo-random integers in the [0, n) interval.
---@param n? number
---@param m? number
---@return fun.iterator, any, number
function fun.rands(n, m) end

--#endregion generators

--#region slicers

---This function returns the n-th element of gen, param, state iterator.
---
---If the iterator does not have n items then nil is returned.
---@param n number a sequential number (indexed starting from 1, like Lua tables)
---@param g fun.iterable
---@param p? any
---@param s? any
---@return any? nth n-th element of gen, param, state iterator
function fun.nth(n, g, p, s) end

---This function returns the n-th element of iterator
---@param n number a sequential number (indexed starting from 1, like Lua tables)
---@return any? nth n-th element of the iterator
function i:nth(n) end

---Extract the first element of gen, param, state iterator. If the iterator is empty then an error is raised.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return any head a first element of gen, param, state iterator
function fun.head(g, p, s) end
fun.car = fun.head

---Extract the first element from the iterator. If the iterator is empty then an error is raised.
---@return any head a first element of gen, param, state iterator
function i:head() end
i.car = i.head

---Return a copy of gen, param, state iterator without its first element.
---If the iterator is empty then an empty iterator is returned.
---@generic P, S
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, P, S
function fun.tail(g, p, s) end
fun.cdr = fun.tail

---Return a copy of gen, param, state iterator without its first element.
---If the iterator is empty then an empty iterator is returned.
---@return fun.iterator, any, any
function i:tail() end
i.cdr = i.tail

---@generic P, S
---@param n number a number of elements to take
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, P, S
function fun.take_n(n, g, p, s) end

---@param n number a number of elements to take
---@return fun.iterator, any, any
function i:take_n(n) end

---@alias fun.predicate fun(...):boolean?

---Returns an iterator on the longest prefix of gen, param, state elements that satisfy predicate.
---@generic P, S
---@param predicate fun.predicate
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, P, S
function fun.take_while(predicate, g, p, s) end

---Returns an iterator on the longest prefix of the iterator's elements that satisfy predicate.
---@param predicate fun.predicate
---@return fun.iterator, any, any
function i:take_while(predicate) end

---Alias for `fun.take_while` and `fun.take_n`
---@generic P, S
---@param n_or_predicate fun.predicate|number
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, P, S
function fun.take(n_or_predicate, g, p, s) end

---Alias for `i:take_while` and `i:take_n`
---@param n_or_predicate fun.predicate|number
---@return fun.iterator, any, any
function i:take_while(n_or_predicate) end

---@generic P, S
---@param n number a number of elements to drop
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, P, S
function fun.drop_n(n, g, p, s) end

---@param n number a number of elements to drop
---@return fun.iterator, any, any
function i:drop_n(n) end

---Returns an iterator of gen, param, state after skipping the longest prefix of elements that satisfy predicate.
---@generic P, S
---@param predicate fun.predicate
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, P, S
function fun.drop_while(predicate, g, p, s) end

---Returns an iterator of gen, param, state after skipping the longest prefix of elements that satisfy predicate.
---@param predicate fun.predicate
---@return fun.iterator, any, any
function i:drop_while(predicate) end

---Alias for `fun.drop_while` and `fun.drop_n`
---@generic P, S
---@param n_or_predicate fun.predicate|number
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, P, S
function fun.drop(n_or_predicate, g, p, s) end

---Alias for `fun.iterator:drop_while` and `fun.iterator:drop_n`
---@param n_or_predicate fun.predicate|number
---@return fun.iterator, any, any
function i:drop(n_or_predicate) end

---Return an iterator pair where the first operates on the longest prefix (possibly empty) of gen, param, state iterator
---of elements that satisfy predicate and second operates the remainder of gen, param, state iterator.
---
---Equivalent to:
--- ```lua
---  return take(n_or_fun, g, p, s), drop(n_or_fun, g, p, s);
--- ```
---@generic P, S
---@param n_or_fun fun.predicate|number
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, fun.iterator, P, S
function fun.split(n_or_fun, g, p, s) end
fun.span = fun.split
fun.split_at = fun.split

---Return an iterator pair where the first operates on the longest prefix (possibly empty) of gen, param, state iterator
---of elements that satisfy predicate and second operates the remainder of gen, param, state iterator.
---@param n_or_fun fun.predicate|number
---@return fun.iterator, fun.iterator, any, any
function i:split(n_or_fun) end
i.span = i.split
i.split_at = i.split


--#endregion slicers

--#region indexers

---The function returns the position of the first element in the given iterator
---which is equal (using ==) to the query element, or nil if there is no such element.
---@param x any a value to find
---@param g fun.iterable
---@param p? any
---@param s? any
---@return number? position
function fun.index(x, g, p, s) end
fun.index_of = fun.index
fun.elem_index = fun.index

---The function returns the position of the first element in the given iterator
---which is equal (using ==) to the query element, or nil if there is no such element.
---@param x any a value to find
---@return number? position
function i:index(x) end


---The function returns an iterator to positions of elements which equals to the query element.
---@generic P, S
---@param x any a value to find
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, {[1]: any, [2]:fun.iterable, [3]: P}, { [1]:number, [2]: S}
function fun.indexes(x, g, p, s) end
fun.elem_indexes = fun.indexes
fun.indices = fun.indexes
fun.elem_indices = fun.indexes

---The function returns an iterator to positions of elements which equals to the query element.
---@param x any a value to find
---@return fun.iterator, any, any
function i:indexes(x) end
i.elem_indexes = i.indexes
i.indices = i.indexes
i.elem_indices = i.indexes

--#endregion indexers

--#region filters

---Return a new iterator of those elements that satisfy the predicate.
---@generic P, S
---@param predicate fun.predicate
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, {[1]: fun.predicate, [2]:fun.iterable, [3]: P}, S
function fun.filter(predicate, g, p, s) end
fun.remove_if = fun.filter

---@param predicate fun.predicate
---@return fun.iterator, any, any
function i:filter(predicate) end

---Return a new iterator of those elements that satisfy the predicate.
---@generic P, S
---@param regex_or_predicate fun.predicate|string
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, {[1]: fun.predicate, [2]:fun.iterable, [3]: P}, S
function fun.grep(regex_or_predicate, g, p, s) end

---Return a new iterator of those elements that satisfy the predicate.
---@param regex_or_predicate fun.predicate|string
---@return fun.iterator, any, any
function i:grep(regex_or_predicate) end

---The function returns two iterators where elements do and do not satisfy the predicate.
---
---The function make a clone of the source iterator.
---Iterators especially returned in tables to work with zip() and other functions.
---@generic P, S
---@param predicate fun.predicate
---@param g fun.iterable
---@param p? P
---@param s? S
---@return fun.iterator, fun.iterator, P, S
function fun.partition(predicate, g, p, s) end

---The function returns two iterators where elements do and do not satisfy the predicate.
---
---The function make a clone of the source iterator.
---Iterators especially returned in tables to work with zip() and other functions.
---@param predicate fun.predicate
---@return fun.iterator, fun.iterator, any, any
function i:partition(predicate) end

--#endregion filters

--#region reducers

---The function reduces the iterator from left to right using the binary operator accfun and the initial value initval
---@generic R, P, S
---@param acc fun(acc: R, ...):R an accumulating function
---@param initval R an initial value that passed to accfun on the first iteration
---@param g fun.iterable
---@param p? P
---@param s? S
---@return R
function fun.reduce(acc, initval, g, p, s) end
fun.foldl = fun.reduce

---The function reduces the iterator from left to right using the binary operator accfun and the initial value initval
---@generic R, P, S
---@param acc fun(acc: R, ...):R an accumulating function
---@param initval R an initial value that passed to accfun on the first iteration
---@return R
function i:reduce(acc, initval) end
i.foldl = i.reduce

---Returns a number of elements in gen, param, state iterator.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return number length
function fun.length(g, p, s) end

---Returns a number of elements in gen, param, state iterator.
---@return number length
function i:length() end

---Checks whether iterator has any elements inside
---@param g fun.iterable
---@param p? any
---@param s? any
---@return boolean is_empty
function fun.is_null(g, p, s) end

---Checks whether iterator has any elements inside
---@return boolean is_empty
function i:is_null() end


---The function takes two iterators and returns true if the first iterator is a prefix of the second.
---
---The implementation of this method is somewhat doubtful. It checks only first 10 items of both iterators.
---@deprecated
---@param iter_x fun.iterator
---@param iter_y fun.iterator
---@return boolean? is_prefix
function fun.is_prefix_of(iter_x, iter_y) end

---Returns true if all return values of iterator satisfy the predicate.
---@param predicate fun.predicate
---@param g fun.iterable
---@param p? any
---@param s? any
---@return boolean satisfied
function fun.all(predicate, g, p, s) end
fun.every = fun.all

---Returns true if all return values of iterator satisfy the predicate.
---@param predicate fun.predicate
---@return boolean satisfied
function i:all(predicate) end
i.every = i.all

---Returns true if at least one return values of iterator satisfy the predicate.
---@param predicate fun.predicate
---@param g fun.iterable
---@param p? any
---@param s? any
---@return boolean one_is_satisfied
function fun.any(predicate, g, p, s) end
fun.some = fun.any

---Returns true if at least one return values of iterator satisfy the predicate.
---@param predicate fun.predicate
---@return boolean one_is_satisfied
function i:any(predicate) end
i.some = i.any

---Sum up all iteration values.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return number sum
function fun.sum(g, p, s) end

---Sum up all iteration values.
---@return number sum
function i:sum() end

---Multiply all iteration values.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return number product
function fun.product(g, p, s) end

---Multiply all iteration values.
---@return number product
function i:product() end

---Return a minimum value from the iterator using operator.min() or < for numbers and other types respectively.
---The iterator must be non-null, otherwise an error is raised.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return any minimal
function fun.min(g, p, s) end
fun.minimum = fun.min

---Return a minimum value from the iterator using operator.min() or < for numbers and other types respectively.
---The iterator must be non-null, otherwise an error is raised.
---@return any minimal
function i:min() end
i.minimum = i.min

---Return a minimum value from the iterator using operator.min() or < for numbers and other types respectively.
---The iterator must be non-null, otherwise an error is raised.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return any maximal
function fun.max(g, p, s) end
fun.maximum = fun.max

---Return a minimum value from the iterator using operator.min() or < for numbers and other types respectively.
---The iterator must be non-null, otherwise an error is raised.
---@return any maximal
function i:max() end
i.maximum = i.max

---@generic T
---@alias fun.comparator fun(a: T, b: T): T

---Return a maximum value from the iterator using the cmp as a > operator.
---The iterator must be non-null, otherwise an error is raised.
---@generic T
---@param cmp fun.comparator<T>
---@param g fun.iterable
---@param p? any
---@param s? any
---@return any maximal
function fun.max_by(cmp, g, p, s) end
fun.maximum_by = fun.max_by

---Return a maximum value from the iterator using the cmp as a > operator.
---The iterator must be non-null, otherwise an error is raised.
---@generic T
---@param cmp fun.comparator<T>
---@return any maximal
function i:max_by(cmp) end
i.maximum_by = i.max_by

---Return a maximum value from the iterator using the cmp as a > operator.
---The iterator must be non-null, otherwise an error is raised.
---@generic T
---@param cmp fun.comparator<T>
---@param g fun.iterable
---@param p? any
---@param s? any
---@return any minimal
function fun.min_by(cmp, g, p, s) end
fun.minimum_by = fun.min_by

---Return a maximum value from the iterator using the cmp as a > operator.
---The iterator must be non-null, otherwise an error is raised.
---@generic T
---@param cmp fun.comparator<T>
---@return any minimal
function i:min_by(cmp) end
i.minimum_by = i.min_by


---Returns a new table (array) from iterated values.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return any[]
function fun.totable(g, p, s) end

---Returns a new table (array) from iterated values.
---@return any[]
function i:totable() end

---Returns a new table (map) from iterated values.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return table
function fun.tomap(g, p, s) end

---Returns a new table (map) from iterated values.
---@return table
function i:tomap() end

--#endregion reducers

--#region transformators

---Return a new iterator by applying the fun to each element of gen, param, state iterator.
---The mapping is performed on the fly and no values are buffered.
---@param f fun(...: any): ...
---@param g fun.iterable
---@param p? any
---@param s? any
---@return fun.iterator, any, any
function fun.map(f, g, p, s) end

---Return a new iterator by applying the fun to each element of gen, param, state iterator.
---The mapping is performed on the fly and no values are buffered.
---@param f fun(...: any): ...
---@return fun.iterator, any, any
function i:map(f) end

---Return a new iterator by enumerating all elements of the gen, param, state iterator starting from 1.
---The mapping is performed on the fly and no values are buffered.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return fun.iterator, any, any
function fun.enumerate(g, p, s) end

---Return a new iterator by enumerating all elements of the gen, param, state iterator starting from 1.
---The mapping is performed on the fly and no values are buffered.
---@return fun.iterator, any, any
function i:enumerate() end

---Return a new iterator where the x value is interspersed between the elements of the source iterator.
---The x value can also be added as a last element of returning iterator
---if the source iterator contains the odd number of elements.
---@param x any
---@param g fun.iterable
---@param p? any
---@param s? any
---@return fun.iterator, any, any
function fun.intersperse(x, g, p, s) end

---Return a new iterator where the x value is interspersed between the elements of the source iterator.
---The x value can also be added as a last element of returning iterator
---if the source iterator contains the odd number of elements.
---@param x any
---@return fun.iterator, any, any
function i:intersperse(x) end

--#endregion transformators

--#region compositors

---Return a new iterator where i-th return value contains the i-th element from each of the iterators.
---The returned iterator is truncated in length to the length of the shortest iterator.
---For multi-return iterators only the first variable is used.
---@param ... fun.iterable
---@return fun.iterator, any param, any state
function fun.zip(...) end

---Return a new iterator where i-th return value contains the i-th element from each of the iterators.
---The returned iterator is truncated in length to the length of the shortest iterator.
---For multi-return iterators only the first variable is used.
---@param ... fun.iterable
---@return fun.iterator, any param, any state
function i:zip(...) end

---Make a new iterator that returns elements from {gen, param, state} iterator until the end
---and then “restart” iteration using a saved clone of {gen, param, state}.
---The returned iterator is constant space and no return values are buffered.
---Instead of that the function make a clone of the source {gen, param, state} iterator.
---Therefore, the source iterator must be pure functional to make an identical clone.
---Infinity iterators are supported, but are not recommended.
---@param g fun.iterable
---@param p? any
---@param s? any
---@return fun.iterator, any param, any state
function fun.cycle(g, p, s) end

---Make a new iterator that returns elements from {gen, param, state} iterator until the end
---and then “restart” iteration using a saved clone of {gen, param, state}.
---The returned iterator is constant space and no return values are buffered.
---Instead of that the function make a clone of the source {gen, param, state} iterator.
---Therefore, the source iterator must be pure functional to make an identical clone.
---Infinity iterators are supported, but are not recommended.
---@return fun.iterator, any param, any state
function i:cycle() end

---Make an iterator that returns elements from the first iterator until it is exhausted,
---then proceeds to the next iterator, until all of the iterators are exhausted.
---Used for treating consecutive iterators as a single iterator.
---Infinity iterators are supported, but are not recommended.
---@param ... fun.iterable
---@return fun.iterator, any param, any state
function fun.chain(...) end

---Make an iterator that returns elements from the first iterator until it is exhausted,
---then proceeds to the next iterator, until all of the iterators are exhausted.
---Used for treating consecutive iterators as a single iterator.
---Infinity iterators are supported, but are not recommended.
---@param ... fun.iterable
---@return fun.iterator, any param, any state
function i:chain(...) end

--#endregion compositors

fun.op = {}


---return a < b
---@param a any
---@param b any
---@return boolean
function fun.op.lt(a, b) end

---return a <= b
---@param a any
---@param b any
---@return boolean
function fun.op.le(a, b) end

---return a == b
---@param a any
---@param b any
---@return boolean
function fun.op.eq(a, b) end

---return a ~= b
---@param a any
---@param b any
---@return boolean
function fun.op.ne(a, b) end

---return a >= b
---@param a any
---@param b any
---@return boolean
function fun.op.ge(a, b) end

---return a > b
---@param a any
---@param b any
---@return boolean
function fun.op.gt(a, b) end

---return a + b
---@param a any
---@param b any
---@return any
function fun.op.add(a, b) end

---return a / b
---@param a any
---@param b any
---@return any
function fun.op.div(a, b) end

---return a % b
---@param a any
---@param b any
---@return any
function fun.op.mod(a, b) end

---return a * b
---@param a any
---@param b any
---@return any
function fun.op.mul(a, b) end

---return a ^ b
---@param a any
---@param b any
---@return any
function fun.op.pow(a, b) end

---return a - b
---@param a any
---@param b any
---@return any
function fun.op.sub(a, b) end

---return a / b
---@param a any
---@param b any
---@return any
function fun.op.truediv(a, b) end

---return a..b
---@param a any
---@param b any
---@return string
function fun.op.concat(a, b) end

---return #a
---@param a any
---@return integer
function fun.op.len(a) end
fun.op.length = fun.op.length


---return a and b
---@param a any
---@param b any
---@return any
function fun.op.land(a, b) end

---return a or b
---@param a any
---@param b any
---@return any
function fun.op.lor(a, b) end


---return not a
---@param a any
---@return boolean
function fun.op.lnot(a) end

---return not not a
---@param a any
---@return boolean
function fun.op.truth(a) end

---return -a
---@param a any
---@return any
function fun.op.neq(a) end
fun.op.unm = fun.op.neq

return fun
