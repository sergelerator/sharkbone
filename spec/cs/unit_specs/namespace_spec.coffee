describe 'Sharkbone namespace', ->
  it 'should be defined', ->
    expect(Sharkbone).toBeDefined()

  describe 'Version', ->
    it 'should be defined', ->
      expect(Sharkbone.Version).toBeDefined()

  describe 'Config namespace', ->
    it 'should be defined', ->
      expect(Sharkbone.Config).toBeDefined()

  describe 'Modules namespace', ->
    it 'should be defined', ->
      expect(Sharkbone.Modules).toBeDefined()

  describe 'ClassModules namespace', ->
    it 'should be defined', ->
      expect(Sharkbone.ClassModules).toBeDefined()

  describe 'App namespace', ->
    it 'should be defined', ->
      expect(Sharkbone.App).toBeDefined()

    describe 'Models namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Models).toBeDefined()

    describe 'Collections namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Collections).toBeDefined()

    describe 'Views namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Views).toBeDefined()

    describe 'Routers namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Routers).toBeDefined()

    describe 'Modules namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Modules).toBeDefined()

    describe 'Initializers', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Initializers).toBeDefined()

      it 'should have an initializeRouters method', ->
        expect(Sharkbone.App.Initializers.initializeRouters).toEqual jasmine.any Function

      it 'should have a setupBackboneRelational method', ->
        expect(Sharkbone.App.Initializers.setupBackboneRelational).toEqual jasmine.any Function
