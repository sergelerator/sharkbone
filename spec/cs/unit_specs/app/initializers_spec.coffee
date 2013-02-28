describe 'Initializers', ->
  subject = Sharkbone.App.Initializers

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'initializeRouters', ->

    it 'should be a function', ->
      expect(subject.initializeRouters).toEqual jasmine.any Function

    describe 'called from Sharkbone.App context', ->
      beforeEach ->
        class Sharkbone.App.Routers.First extends Sharkbone.Router
        class Sharkbone.App.Routers.Second extends Sharkbone.Router

        spyOn Sharkbone.App.Routers, 'First'
        spyOn Sharkbone.App.Routers, 'Second'

      afterEach ->
        Sharkbone.App.activeRouters = []
        Sharkbone.App.Routers = {}

      it 'should create an instance of the First Router', ->
        subject.initializeRouters.apply(Sharkbone.App)
        expect(Sharkbone.App.Routers.First).toHaveBeenCalled()

      it 'should create an instance of the Second Router', ->
        subject.initializeRouters.apply(Sharkbone.App)
        expect(Sharkbone.App.Routers.Second).toHaveBeenCalled()

      it 'should create an activeRouters attribute with 2 routers', ->
        subject.initializeRouters.apply(Sharkbone.App)
        expect(Sharkbone.App.activeRouters.length).toEqual 2

  describe 'setupBackboneRelational', ->
    it 'should be a function', ->
      expect(subject.setupBackboneRelational).toEqual jasmine.any Function

    it 'should have access to Sharkbone.Model', ->
      expect(Sharkbone.Model).toBeDefined()

    describe 'called from Sharkbone.App context', ->
      beforeEach ->
        class Sharkbone.App.Models.First extends Sharkbone.Model
        class Sharkbone.App.Models.Second extends Sharkbone.Model

        spyOn Sharkbone.App.Models.First, 'setup'
        spyOn Sharkbone.App.Models.Second, 'setup'

      afterEach ->
        Sharkbone.App.Models = {}

      it 'should setup the First Model', ->
        subject.setupBackboneRelational.apply(Sharkbone.App)
        expect(Sharkbone.App.Models.First.setup).toHaveBeenCalled()

      it 'should setup the Second Model', ->
        subject.setupBackboneRelational.apply(Sharkbone.App)
        expect(Sharkbone.App.Models.Second.setup).toHaveBeenCalled()
