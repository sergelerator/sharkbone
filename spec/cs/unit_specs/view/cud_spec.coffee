describe 'Sharkbone.Modules.CUD', ->
  subject = Sharkbone.Modules.CUD
  server = null
  options = {}

  beforeEach ->
    # Set defaults, boot up the fake server
    server = sinon.fakeServer.create()
    options = {}

    # Define the dummy collection and model
    class Sharkbone.App.Models.User extends Sharkbone.Model
      urlRoot: 'users'

    class Sharkbone.App.Collections.Users extends Sharkbone.Collection
      model: Sharkbone.App.Models.User
      url: '/users'

    Sharkbone.App.Models.User.setup()

    # Instantiate collection and model
    subject.collection = new Sharkbone.App.Collections.Users()
    subject.model = new Sharkbone.App.Models.User()

    # Register spies
    spyOn(subject.collection, 'create').andCallThrough()
    spyOn(subject.collection, 'get').andCallThrough()
    spyOn(subject.collection, 'remove').andCallThrough()
    spyOn(subject.model, 'save').andCallThrough()
    spyOn(subject.model, 'destroy').andCallThrough()

    # Set up server responses
    server.respondWith('POST', 'users',
      [201, {'Content-Type': 'application/json'},
      '{"id": 1, "name": "John", "last_name": "Doe"}']
    )

    server.respondWith('PUT', 'users/1',
      [204, {'Content-Type': 'application/json'}, '']
    )

    server.respondWith('DELETE', 'users/1',
      [204, {'Content-Type': 'application/json'}, '']
    )

  afterEach ->
    server.restore()

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'create', ->
    beforeEach ->
      # Register spies
      spyOn(subject, 'create').andCallThrough()

    it 'should be defined', ->
      expect(subject.create).toBeDefined()

    describe 'called without options', ->
      beforeEach ->
        subject.create()
        server.respond()

      it 'should call create on collection', ->
        expect(subject.collection.create).toHaveBeenCalled()

      it 'should call create on collection with model', ->
        expect(subject.collection.create.calls[0].args[0]).toEqual subject.model


    describe 'called as event callback', ->
      beforeEach ->
        options.preventDefault = jasmine.createSpy('preventDefault').andCallFake -> null
        options.stopPropagation = jasmine.createSpy('stopPropagation').andCallFake -> null
        subject.create options
        server.respond()

      it 'should prevent default event', ->
        expect(options.preventDefault).toHaveBeenCalled()

      it 'should stop propagation', ->
        expect(options.stopPropagation).toHaveBeenCalled()

  describe 'update', ->
    beforeEach ->
      # Register spies
      spyOn(subject, 'update').andCallThrough()

    it 'should be defined', ->
      expect(subject.update).toBeDefined()

    describe 'called without options', ->
      beforeEach ->
        subject.update()
        server.respond()

      it 'should call save on model', ->
        expect(subject.model.save).toHaveBeenCalled()

      it 'should call create on collection with model', ->
        expect(subject.model.save.calls[0].args[0]).toEqual undefined


    describe 'called as event callback', ->
      beforeEach ->
        options.preventDefault = jasmine.createSpy('preventDefault').andCallFake -> null
        options.stopPropagation = jasmine.createSpy('stopPropagation').andCallFake -> null
        subject.update options
        server.respond()

      it 'should prevent default event', ->
        expect(options.preventDefault).toHaveBeenCalled()

      it 'should stop propagation', ->
        expect(options.stopPropagation).toHaveBeenCalled()

  describe 'destroy', ->
    beforeEach ->
      # Register spies
      spyOn(subject, 'destroy').andCallThrough()

      subject.destroyConfirmation true

    it 'should be defined', ->
      expect(subject.destroy).toBeDefined()

    describe 'called without options', ->
      beforeEach ->
        subject.destroy()
        server.respond()

      it 'should call destroy on model', ->
        expect(subject.model.destroy).toHaveBeenCalled()

      it 'should call destroy on model only once', ->
        expect(subject.model.destroy.calls.length).toEqual 1

    describe 'called with id', ->
      beforeEach ->
        subject.create()
        subject.collection.add subject.model
        subject.destroy(1)
        server.respond()

      it 'should call destroy on model', ->
        expect(subject.model.destroy).toHaveBeenCalled()

      it 'should call destroy on model only once', ->
        expect(subject.model.destroy.calls.length).toEqual 1

      it 'should call remove on the collection', ->
        expect(subject.collection.remove).toHaveBeenCalled()

      it 'should call remove on the collection only once', ->
        expect(subject.collection.remove.calls.length).toEqual 1

      it 'should call get on the collection', ->
        expect(subject.collection.get).toHaveBeenCalled()

      it 'should call get on the collection with id 1', ->
        expect(subject.collection.get).toHaveBeenCalledWith 1

    describe 'called as event callback', ->
      beforeEach ->
        options.preventDefault = jasmine.createSpy('preventDefault').andCallFake -> null
        options.stopPropagation = jasmine.createSpy('stopPropagation').andCallFake -> null
        subject.destroy options
        server.respond()

      it 'should prevent default event', ->
        expect(options.preventDefault).toHaveBeenCalled()

      it 'should stop propagation', ->
        expect(options.stopPropagation).toHaveBeenCalled()

      it 'should call destroy on subject.model', ->
        expect(subject.model.destroy).toHaveBeenCalled()

      it 'should call destroy on model only once', ->
        expect(subject.model.destroy.calls.length).toEqual 1

  describe 'runCallbacksFor', ->
    it 'should be defined', ->
      expect(subject.runCallbacksFor).toBeDefined()

  describe 'destroyConfirmation', ->
    it 'should be defined', ->
      expect(subject.destroyConfirmation).toBeDefined()

    it 'should register a destroyConfirmation', ->
      dcf = jasmine.createSpy('dcf').andCallFake -> null
      subject.destroyConfirmation dcf
      expect(subject.__destroyConfirmation).toEqual dcf
