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
Number.define 'absoluteIncrement', (x) -> if @ < 0 then @ - x else @ + x
Number.define 'ceil', -> if @ is @toInt() then @ else @absoluteIncrement(1)
Number.define 'floor', -> @toInt()
