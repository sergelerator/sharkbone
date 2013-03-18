describe 'Object extensions', ->
  subject = Object

  it 'should be able to addMethod', ->
    expect(subject.addMethod).toBeDefined()
