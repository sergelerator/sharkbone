describe 'Number', ->
  subject = null

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
