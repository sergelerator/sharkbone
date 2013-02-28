describe 'Sharkbone.Model', ->
  subject = Sharkbone.Model

  it 'should be defined', ->
    expect(subject).toBeDefined()

  it 'should have the extend method', ->
    expect(subject.extend).toEqual jasmine.any Function

  it 'should have the include method', ->
    expect(subject.include).toEqual jasmine.any Function

  it 'should have the appNamespace method', ->
    expect(subject.appNamespace).toEqual jasmine.any Function
