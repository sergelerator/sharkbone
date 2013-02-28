describe 'Sharkbone.Router', ->
  subject = Sharkbone.Router

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'defaultCollectionName', ->
    it 'should be a function', ->
      expect(subject.defaultCollectionName).toEqual jasmine.any Function

    it 'should return empty string if no Router extends the subject', ->
      expect(subject.defaultCollectionName()).toEqual ''

  describe 'being extended by FirstAwesomesRouter', ->
    local_subject = {}
    beforeEach ->
      class Sharkbone.App.Routers.FirstAwesomesRouter extends subject

      local_subject = Sharkbone.App.Routers.FirstAwesomesRouter

      spyOn(local_subject, 'defaultCollectionName').andCallThrough()
      spyOn(local_subject, 'collectionClass').andCallThrough()
      spyOn(local_subject, 'collectionName').andCallThrough()
      spyOn(local_subject, 'resources').andCallThrough()

      local_subject.resources()

    it 'should be defined', ->
      expect(Sharkbone.App.Routers.FirstAwesomesRouter).toEqual jasmine.any Function

    describe 'defaultCollectionName', ->
      it 'should have been called', ->
        expect(local_subject.defaultCollectionName).toHaveBeenCalled()

      it 'should return FirstAwesomesRouter', ->
        expect(local_subject.defaultCollectionName()).toEqual 'FirstAwesomes'

    describe 'collectionClass', ->
      it 'should have been called', ->
        expect(local_subject.collectionClass).toHaveBeenCalled()

      it 'should return FirstAwesomes', ->
        expect(local_subject.collectionClass()).toEqual 'FirstAwesomes'

    describe 'collectionName', ->
      it 'should have been called', ->
        expect(local_subject.collectionName).toHaveBeenCalled()

      it 'should return FirstAwesomes', ->
        expect(local_subject.collectionName()).toEqual 'first_awesomes'

    describe 'resources', ->
      it 'should have been called', ->
        expect(local_subject.resources).toHaveBeenCalled()

      it 'routes attribute should equal expected object', ->
        expect(local_subject::routes).toEqual {
          'first_awesomes/index': 'index'
          'first_awesomes': 'index'
          'first_awesomes/new': 'newModel'
          'first_awesomes/:id/edit': 'edit'
          'first_awesomes/:id': 'show'
        }

    describe 'initialize', ->
      beforeEach ->
        Sharkbone.App.Collections.FirstAwesomes =  jasmine.createSpy('FirstAwesomes').andReturn {model: 'FirstAwesome'}
        class Sharkbone.App.Routers.FirstAwesomes extends Sharkbone.Router
        spyOn(Sharkbone.App.Routers.FirstAwesomes::, 'initialize').andCallThrough()
        local_subject = new Sharkbone.App.Routers.FirstAwesomes()

      it 'should have been called', ->
        expect(local_subject.initialize).toHaveBeenCalled()

      it 'should create a collection of FirstAwesomes', ->
        expect(local_subject.collection).toEqual {model: 'FirstAwesome'}

    #TODO Add loadDefaultData spec, need fake server
    #TODO Add getResource spec, need fake server
