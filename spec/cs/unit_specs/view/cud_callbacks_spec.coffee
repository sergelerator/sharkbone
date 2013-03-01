describe 'Sharkbone.Modules.CUDCallbacks', ->
  subject = Sharkbone.Modules.CUDCallbacks

  beforeEach ->
    subject::_afterSuccessfulCreate =   []
    subject::_afterSuccessfulUpdate =   []
    subject::_afterSuccessfulDestroy =  []
    subject::_afterFailingCreate =      []
    subject::_afterFailingUpdate =      []
    subject::_afterFailingDestroy =     []

    subject::remove = jasmine.createSpy('remove').andReturn 1
    subject::goToIndex = jasmine.createSpy('goToIndex').andReturn 1
    subject::goToShow = jasmine.createSpy('goToShow').andReturn 1

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'Callback containers', ->
    it '_afterSuccessfulCreate', ->
      expect(subject::_afterSuccessfulCreate).toEqual []
    it '_afterSuccessfulUpdate', ->
      expect(subject::_afterSuccessfulUpdate).toEqual []
    it '_afterSuccessfulDestroy', ->
      expect(subject::_afterSuccessfulDestroy).toEqual []

    it '_afterFailingCreate', ->
      expect(subject::_afterFailingCreate).toEqual []
    it '_afterFailingUpdate', ->
      expect(subject::_afterFailingUpdate).toEqual []
    it '_afterFailingDestroy', ->
      expect(subject::_afterFailingDestroy).toEqual []

  describe 'callbacks', ->
    beforeEach ->
      spyOn(subject::, 'registerCallback').andCallThrough()
      spyOn(subject::, 'registerCallbacks').andCallThrough()
      subject::mockCallback = jasmine.createSpy('mockCallback').andReturn 1

    describe 'afterCreate', ->
      beforeEach ->
        spyOn(subject::, 'afterCreate').andCallThrough()
        subject::afterCreate subject::mockCallback

      it 'should be called with a mockCallback', ->
        expect(subject::afterCreate).toHaveBeenCalled()
        expect(subject::afterCreate).toHaveBeenCalledWith subject::mockCallback

      it 'registerCallbacks properly called', ->
        expect(subject::registerCallbacks).toHaveBeenCalled()
        expect(subject::registerCallbacks).toHaveBeenCalledWith(
          subject::_afterSuccessfulCreate, {0: subject::mockCallback}
        )

      it 'registerCallback properly called', ->
        expect(subject::registerCallback).toHaveBeenCalledWith(
          subject::_afterSuccessfulCreate, subject::mockCallback
        )

      it 'should add mockCallback to _afterSuccessfulCreate', ->
        expect(subject::_afterSuccessfulCreate.length).toEqual 1
        expect(subject::_afterSuccessfulCreate[0]).toEqual subject::mockCallback

    describe 'afterUpdate', ->
      beforeEach ->
        spyOn(subject::, 'afterUpdate').andCallThrough()
        subject::afterUpdate subject::mockCallback

      it 'should be called with a mockCallback', ->
        expect(subject::afterUpdate).toHaveBeenCalled()
        expect(subject::afterUpdate).toHaveBeenCalledWith subject::mockCallback

      it 'registerCallbacks properly called', ->
        expect(subject::registerCallbacks).toHaveBeenCalled()
        expect(subject::registerCallbacks).toHaveBeenCalledWith(
          subject::_afterSuccessfulUpdate, {0: subject::mockCallback}
        )

      it 'registerCallback properly called', ->
        expect(subject::registerCallback).toHaveBeenCalledWith(
          subject::_afterSuccessfulUpdate, subject::mockCallback
        )

      it 'should add mockCallback to _afterSuccessfulUpdate', ->
        expect(subject::_afterSuccessfulUpdate.length).toEqual 1
        expect(subject::_afterSuccessfulUpdate[0]).toEqual subject::mockCallback

    describe 'afterDestroy', ->
      beforeEach ->
        spyOn(subject::, 'afterDestroy').andCallThrough()
        subject::afterDestroy subject::mockCallback

      it 'should be called with a mockCallback', ->
        expect(subject::afterDestroy).toHaveBeenCalled()
        expect(subject::afterDestroy).toHaveBeenCalledWith subject::mockCallback

      it 'registerCallbacks properly called', ->
        expect(subject::registerCallbacks).toHaveBeenCalled()
        expect(subject::registerCallbacks).toHaveBeenCalledWith(
          subject::_afterSuccessfulDestroy, {0: subject::mockCallback}
        )

      it 'registerCallback properly called', ->
        expect(subject::registerCallback).toHaveBeenCalledWith(
          subject::_afterSuccessfulDestroy, subject::mockCallback
        )

      it 'should add mockCallback to _afterSuccessfulDestroy', ->
        expect(subject::_afterSuccessfulDestroy.length).toEqual 1
        expect(subject::_afterSuccessfulDestroy[0]).toEqual subject::mockCallback

  describe 'initializeDefaultCallbacks', ->
    beforeEach ->
      spyOn(subject::, 'afterCreate').andCallThrough()
      spyOn(subject::, 'afterUpdate').andCallThrough()
      spyOn(subject::, 'afterDestroy').andCallThrough()

      subject::initializeDefaultCallbacks()

    it 'should have called afterCreate', ->
      expect(subject::afterCreate).toHaveBeenCalled()

    it 'should have called afterUpdate', ->
      expect(subject::afterUpdate).toHaveBeenCalled()

    it 'should have called afterDestroy', ->
      expect(subject::afterDestroy).toHaveBeenCalled()

    it 'should add 2 callbacks to _afterSuccessfulCreate', ->
      expect(subject::_afterSuccessfulCreate.length).toEqual 2

    it 'should add 2 callbacks to _afterSuccessfulUpdate', ->
      expect(subject::_afterSuccessfulUpdate.length).toEqual 2

    it 'should add 1 callback to _afterSuccessfulDestroy', ->
      expect(subject::_afterSuccessfulDestroy.length).toEqual 1
