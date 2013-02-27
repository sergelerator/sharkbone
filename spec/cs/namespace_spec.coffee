describe 'Sharkbone namespace', ->
  it 'should be defined', ->
    expect(Sharkbone).toEqual jasmine.any(Object)

  describe 'Version', ->
    it 'should be defined', ->
      expect(Sharkbone.Version).toBeTruthy()

  describe 'Config namespace', ->
    it 'should be defined', ->
      expect(Sharkbone.Config).toEqual jasmine.any(Object)

  describe 'App namespace', ->
    it 'should be defined', ->
      expect(Sharkbone.App).toEqual jasmine.any(Object)

    describe 'Models namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Models).toEqual jasmine.any(Object)

    describe 'Collections namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Collections).toEqual jasmine.any(Object)

    describe 'Views namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Views).toEqual jasmine.any(Object)

    describe 'Routers namespace', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Routers).toEqual jasmine.any(Object)

    describe 'Initializers', ->
      it 'should be defined', ->
        expect(Sharkbone.App.Initializers).toEqual jasmine.any(Object)

      it 'should have a initializeRouters method', ->
        expect(Sharkbone.App.Initializers.initializeRouters).toEqual jasmine.any(Function)

      it 'should have a setupBackboneRelational method', ->
        expect(Sharkbone.App.Initializers.setupBackboneRelational).toEqual jasmine.any(Function)
