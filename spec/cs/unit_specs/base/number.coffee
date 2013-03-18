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
