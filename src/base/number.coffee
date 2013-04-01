Number::errVal = NaN
Number.define 'toInt', -> parseInt(@)
Number.define 'toF', -> parseFloat(@)
Number.define 'plus', (x) -> if (f = @toF() + x.toF()) then f else @errVal
Number.define 'minus', (x) -> if (f = @toF() - x.toF()) then f else @errVal
Number.define 'by', (x) -> if (f = @toF() * x.toF()) then f else @errVal
Number.define 'divideBy', (x) -> if (f = @toF() / x.toF()) then f else @errVal
Number.define 'isOdd', -> @ % 2
Number.define 'isEven', -> !@isOdd()
Number.define 'absolute', -> if @ < 0 then @.by(-1) else @
Number.define 'absoluteIncrement', (x = 1) -> if @ < 0 then @.minus(x) else @.plus(x)
Number.define 'ceil', -> if @ > @toInt() then @toInt().absoluteIncrement() else @
Number.define 'floor', -> @toInt()
Number.define 'next', -> @ + 1
