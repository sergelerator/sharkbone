describe 'Number', ->
  subject = null
  [odd, even, dec] = [null, null, null]

  beforeEach ->
    subject = Number

  it 'should be able to define methods', ->
    expect(subject.define).toBeDefined()

  it 'should have an errVal property', ->
    expect(subject::errVal).toBeDefined()

  describe 'toInt', ->
    beforeEach ->
      subject = subject::toInt

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it 'should return itself when called from an Int', ->
      a = 4
      expect(a.toInt()).toEqual 4

    it 'should strip the decimal part when called from a Float', ->
      a = 4.44
      expect(a.toInt()).toEqual 4

  describe 'toF', ->
    beforeEach ->
      subject = subject::toF

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it 'should return itself when called from an Int', ->
      a = 4
      expect(a.toF()).toEqual 4

    it 'should return itself  when called from a Float', ->
      a = 4.44
      expect(a.toF()).toEqual 4.44

  describe 'plus', ->
    beforeEach ->
      subject = subject::plus

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it 'should properly sum the provided value to self', ->
      a = 4
      expect(a.plus 8).toEqual 12

    it 'should properly sum a Float and an Int value', ->
      a = 4.44
      expect(a.plus 4).toBeCloseTo 8.44, 4

    it 'should properly sum an Int and a Float value', ->
      a = 4
      expect(a.plus 4.35).toBeCloseTo 8.35, 4

    it 'should properly sum two Float values', ->
      a = 4.23
      expect(a.plus 4.35).toBeCloseTo 8.58, 4

  describe 'minus', ->
    beforeEach ->
      subject = subject::minus

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it 'should properly substract the provided value to self', ->
      a = 4
      expect(a.minus 2).toEqual 2

    it 'should properly substract an Int from a Float value', ->
      a = 4.44
      expect(a.minus 1).toBeCloseTo 3.44, 4

    it 'should properly substract a Float from an Int value', ->
      a = 4
      expect(a.minus 1.35).toBeCloseTo 2.65, 4

    it 'should properly substract a Float from a Float value', ->
      a = 4.23
      expect(a.minus 2.35).toBeCloseTo 1.88, 4

  describe 'by', ->
    beforeEach ->
      subject = subject::by

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it 'should properly multiply by the provided value', ->
      a = 4
      expect(a.by 8).toEqual 32

    it 'should properly multiply a Float by an Int', ->
      a = 4.50
      expect(a.by 4).toBeCloseTo 18, 4

    it 'should properly multiply an Int by a Float', ->
      a = 4
      expect(a.by 3.2).toBeCloseTo 12.8, 4

    it 'should properly multiply two Float values', ->
      a = 2.5
      expect(a.by 2.5).toBeCloseTo 6.25, 4

  describe 'divideBy', ->
    beforeEach ->
      subject = subject::divideBy

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it 'should properly divide by the provided value', ->
      a = 8
      expect(a.divideBy 4).toEqual 2

    it 'should properly divide a Float by an Int', ->
      a = 4.50
      expect(a.divideBy 2).toBeCloseTo 2.25, 4

    it 'should properly divide an Int by a Float', ->
      [a, b] = [3, 9]
      expect(a.divideBy 1.5).toBeCloseTo 2, 4
      expect(b.divideBy 3.5).toBeCloseTo 2.5714, 4

    it 'should properly divide two Float values', ->
      a = 14.5
      expect(a.divideBy 3.4).toBeCloseTo 4.2647, 4

  describe 'isOdd', ->
    beforeEach ->
      subject = subject::isOdd
      [odd, even, dec] = [3, 4, 5.6]

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it '3 should be odd', ->
      expect(odd.isOdd()).toBeTruthy()

    it '4 should not be odd', ->
      expect(even.isOdd()).toBeFalsy()

    it '5.6 should be odd', ->
      expect(dec.isOdd()).toBeTruthy()

  describe 'isEven', ->
    beforeEach ->
      subject = subject::isEven
      [odd, even, dec] = [3, 4, 5.6]

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it '3 should not be even', ->
      expect(odd.isEven()).toBeFalsy()

    it '4 should be even', ->
      expect(even.isEven()).toBeTruthy()

    it '5.6 should not be even', ->
      expect(dec.isEven()).toBeFalsy()

  describe 'absolute', ->
    beforeEach ->
      subject = subject::absolute

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it 'of 3 should be 3', ->
      expect((3).absolute()).toEqual 3

    it 'of -54 should be 54', ->
      expect((-54).absolute()).toEqual 54

    it 'of 0 to be 0', ->
      expect((0).absolute()).toEqual 0
