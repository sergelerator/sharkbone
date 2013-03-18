describe 'Object extensions', ->
  subject = Object

  it 'should be able to define methods', ->
    expect(subject.define).toBeDefined()
