describe 'Sharkbone.Modules.Relational', ->
  subject = Sharkbone.Modules.Relational

  beforeEach ->
    subject::urlRoot = 'parents'
    subject::relations =
      [
        {key: 'children'}
        {key: 'sons'}
      ]

    children_collection = {url: 'children'}
    sons_collection = {url: 'sons'}
    subject::get = jasmine.createSpy('get').andCallFake (key) ->
      (attrs = attrs || {
        'id': 1
        'children': children_collection
        'sons': sons_collection
      })[key]

  it 'should create spies for each requested method', ->
    expect(subject::get).toBeDefined()

  it 'returns "parents" when te urlRoot attribute is accessed', ->
    expect(subject::urlRoot).toEqual "parents"

  it 'returns two objects when relations attribute is accessed', ->
    expect(subject::relations.length).toEqual 2

  it 'returns 1 when the fake "get" method is called with argument "id"', ->
    expect(subject::get 'id').toEqual 1

  it 'returns the "children" key when the first relations member is accessed', ->
    expect(subject::relations[0].key).toEqual 'children'

  describe 'setupRelations', ->
    beforeEach ->
      subject::setupRelations()

    it 'should be defined', ->
      expect(subject::setupRelations).toEqual jasmine.any Function

    it 'should properly set the children url', ->
      expect(subject::get('children').url).toEqual 'parents/1/children'

    it 'should properly set the sons url', ->
      expect(subject::get('sons').url).toEqual 'parents/1/sons'

  describe 'fetchCollections', ->
    #TODO Use some server mocking framework to test this.

  describe 'createDotSyntaxCollectionGetters', ->
    it 'should be defined', ->
      expect(subject::createDotSyntaxCollectionGetters).toBeDefined()

    it 'should create dot syntax getters', ->
      subject::createDotSyntaxCollectionGetters()
      expect(subject::children()).toEqual jasmine.any Object
      expect(subject::sons()).toEqual jasmine.any Object
