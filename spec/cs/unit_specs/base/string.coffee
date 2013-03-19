describe 'String', ->
  subject = null

  beforeEach ->
    subject = String

  it 'should be able to define methods', ->
    expect(subject.define).toBeDefined()

  describe 'isBlank', ->
    beforeEach ->
      subject = subject::isBlank

    it 'should be defined', ->
      expect(subject).toBeDefined()

    it 'should return true for empty string', ->
      expect(''.isBlank()).toBeTruthy()

    it 'should return true for a string with whitespaces', ->
      expect('     '.isBlank()).toBeTruthy()

    it 'should return false for "dummy" string', ->
      expect('dummy'.isBlank()).toBeFalsy()

    it 'should return false for "  d u m m y  " string', ->
      expect('  d u m m y  '.isBlank()).toBeFalsy()
