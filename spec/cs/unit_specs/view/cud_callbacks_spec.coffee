describe 'Sharkbone.Modules.CUDCallbacks', ->
  subject = Sharkbone.Modules.CUDCallbacks
  server = null

  beforeEach ->
    subject._afterSuccessfulCreate =   []
    subject._afterSuccessfulUpdate =   []
    subject._afterSuccessfulDestroy =  []
    subject._afterFailingCreate =      []
    subject._afterFailingUpdate =      []
    subject._afterFailingDestroy =     []

    subject.remove = jasmine.createSpy('remove').andReturn 1
    subject.goToIndex = jasmine.createSpy('goToIndex').andReturn 1
    subject.goToShow = jasmine.createSpy('goToShow').andReturn 1

    server = sinon.fakeServer.create()
    server.autoRespond = true

  afterEach ->
    server.restore()

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'Callback containers', ->
    it '_afterSuccessfulCreate', ->
      expect(subject._afterSuccessfulCreate).toEqual []
    it '_afterSuccessfulUpdate', ->
      expect(subject._afterSuccessfulUpdate).toEqual []
    it '_afterSuccessfulDestroy', ->
      expect(subject._afterSuccessfulDestroy).toEqual []

    it '_afterFailingCreate', ->
      expect(subject._afterFailingCreate).toEqual []
    it '_afterFailingUpdate', ->
      expect(subject._afterFailingUpdate).toEqual []
    it '_afterFailingDestroy', ->
      expect(subject._afterFailingDestroy).toEqual []

  describe 'callbacks', ->
    beforeEach ->
      class Sharkbone.App.Models.User extends Sharkbone.Model
        urlRoot: 'users'

      class Sharkbone.App.Collections.Users extends Sharkbone.Collection
        model: Sharkbone.App.Models.User
        url: '/users'

      Sharkbone.App.Models.User.setup()

      spyOn(subject, 'registerCallback').andCallThrough()
      spyOn(subject, 'registerCallbacks').andCallThrough()
      subject.successCallback = jasmine.createSpy('successCallback').andCallFake () -> console.log('success')
      subject.errorCallback = jasmine.createSpy('errorCallback').andCallFake (model, xhr, options) -> console.log(arguments)
      subject.collection = new Sharkbone.App.Collections.Users()
      subject.model = new Sharkbone.App.Models.User()
      _(subject).extend Sharkbone.Modules.CUD

    describe 'afterCreate', ->
      beforeEach ->
        spyOn(subject, 'afterCreate').andCallThrough()
        subject.afterCreate subject.successCallback
        subject.afterFailingCreate subject.errorCallback

        server.respondWith('POST', 'users',
          [201, {'Content-Tpye': 'application/json'},
          '{name: John, last_name: Doe}']
        )

      it 'should be called with a successCallback', ->
        expect(subject.afterCreate).toHaveBeenCalled()
        expect(subject.afterCreate).toHaveBeenCalledWith subject.successCallback

      it 'registerCallbacks properly called', ->
        expect(subject.registerCallbacks).toHaveBeenCalledWith(
          subject._afterSuccessfulCreate, {0: subject.successCallback}
        )

      it 'registerCallback properly called', ->
        expect(subject.registerCallback).toHaveBeenCalledWith(
          subject._afterSuccessfulCreate, subject.successCallback
        )

      it 'should add successCallback to _afterSuccessfulCreate', ->
        expect(subject._afterSuccessfulCreate.length).toEqual 1
        expect(subject._afterSuccessfulCreate[0]).toEqual subject.successCallback

      it 'should call successCallback afterCreate', ->
        subject.model.set name: 'John', last_name: 'Doe'
        subject.create()
        console.log server
        expect(subject.successCallback).toHaveBeenCalled()

    describe 'afterUpdate', ->
      beforeEach ->
        spyOn(subject, 'afterUpdate').andCallThrough()
        subject.afterUpdate subject.successCallback

      it 'should be called with a successCallback', ->
        expect(subject.afterUpdate).toHaveBeenCalled()
        expect(subject.afterUpdate).toHaveBeenCalledWith subject.successCallback

      it 'registerCallbacks properly called', ->
        expect(subject.registerCallbacks).toHaveBeenCalled()
        expect(subject.registerCallbacks).toHaveBeenCalledWith(
          subject._afterSuccessfulUpdate, {0: subject.successCallback}
        )

      it 'registerCallback properly called', ->
        expect(subject.registerCallback).toHaveBeenCalledWith(
          subject._afterSuccessfulUpdate, subject.successCallback
        )

      it 'should add successCallback to _afterSuccessfulUpdate', ->
        expect(subject._afterSuccessfulUpdate.length).toEqual 1
        expect(subject._afterSuccessfulUpdate[0]).toEqual subject.successCallback

    describe 'afterDestroy', ->
      beforeEach ->
        spyOn(subject, 'afterDestroy').andCallThrough()
        subject.afterDestroy subject.successCallback

      it 'should be called with a successCallback', ->
        expect(subject.afterDestroy).toHaveBeenCalled()
        expect(subject.afterDestroy).toHaveBeenCalledWith subject.successCallback

      it 'registerCallbacks properly called', ->
        expect(subject.registerCallbacks).toHaveBeenCalled()
        expect(subject.registerCallbacks).toHaveBeenCalledWith(
          subject._afterSuccessfulDestroy, {0: subject.successCallback}
        )

      it 'registerCallback properly called', ->
        expect(subject.registerCallback).toHaveBeenCalledWith(
          subject._afterSuccessfulDestroy, subject.successCallback
        )

      it 'should add successCallback to _afterSuccessfulDestroy', ->
        expect(subject._afterSuccessfulDestroy.length).toEqual 1
        expect(subject._afterSuccessfulDestroy[0]).toEqual subject.successCallback

  describe 'initializeDefaultCallbacks', ->
    beforeEach ->
      spyOn(subject, 'afterCreate').andCallThrough()
      spyOn(subject, 'afterUpdate').andCallThrough()
      spyOn(subject, 'afterDestroy').andCallThrough()

      subject.initializeDefaultCallbacks()

    it 'should have called afterCreate', ->
      expect(subject.afterCreate).toHaveBeenCalled()

    it 'should have called afterUpdate', ->
      expect(subject.afterUpdate).toHaveBeenCalled()

    it 'should have called afterDestroy', ->
      expect(subject.afterDestroy).toHaveBeenCalled()

    it 'should add 2 callbacks to _afterSuccessfulCreate', ->
      expect(subject._afterSuccessfulCreate.length).toEqual 2

    it 'should add 2 callbacks to _afterSuccessfulUpdate', ->
      expect(subject._afterSuccessfulUpdate.length).toEqual 2

    it 'should add 1 callback to _afterSuccessfulDestroy', ->
      expect(subject._afterSuccessfulDestroy.length).toEqual 1
