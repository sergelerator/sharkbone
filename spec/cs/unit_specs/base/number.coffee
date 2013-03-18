describe 'Number', ->
  subject = Number

  it 'should be able to define methods', ->
    expect(subject.define).toBeDefined()

  it 'should have an errVal property', ->
    expect(subject::errVal).toBeDefined()
