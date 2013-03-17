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

    # Set up server responses
    server.respondWith('POST', 'users',
      [201, {'Content-Tpye': 'application/json'},
      '{"id": 1, "name": "John", "last_name": "Doe"}']
    )

    server.respondWith('PUT', 'users/1',
      [204, {'Content-Tpye': 'application/json'}, '']
    )

    server.respondWith('DELETE', 'users/1',
      [204, {'Content-Tpye': 'application/json'}, '']
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
