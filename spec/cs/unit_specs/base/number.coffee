describe 'Number extensions', ->
  subject = Number

  it 'should be able to addMethod', ->
    expect(subject.addMethod).toBeDefined()

  it 'should have an errVal property', ->
    expect(subject::errVal).toBeDefined()
