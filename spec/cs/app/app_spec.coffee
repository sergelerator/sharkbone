describe 'App', ->
  subject = Sharkbone.App

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'activeRouters', ->
    it 'should be an empty array', ->
      expect(subject.activeRouters).toEqual []

  describe 'options', ->
    it 'should be an object', ->
      expect(subject.options).toEqual jasmine.any(Object)

    it 'should have a pushState attribute with a falsy value', ->
      expect(subject.options.pushState).toBeFalsy()

  describe 'initialize method', ->
    it 'should be a defined', ->
      expect(subject.initialize).toBeDefined()

    it 'should be a function', ->
      expect(subject.initialize).toEqual jasmine.any(Function)
