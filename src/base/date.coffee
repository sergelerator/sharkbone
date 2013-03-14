Date.seconds = (n) -> return n * 1000
Date.minutes = (n) -> return Date.seconds(n) * 60
Date.hours = (n) -> return Date.minutes(n) * 60
Date.days = (n) -> return Date.hours(n) * 24

Date::addTime = (n) -> @setTime(this.valueOf() + n)
Date::addSeconds = (n) -> @addTime(Date.seconds(n))
Date::addMinutes = (n) -> @addTime(Date.minutes(n))
Date::addHours = (n) -> @addTime(Date.hours(n))
Date::addDays = (n) -> @addTime(Date.days(n))
