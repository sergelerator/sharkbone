describe 'Sharkbone.Modules.CUDCallbacks', ->
  subject = Sharkbone.Modules.CUDCallbacks

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

  describe 'initializeDefaultCallbacks', ->
    beforeEach ->
      subject::_afterSuccessfulCreate =   []
      subject::_afterSuccessfulUpdate =   []
      subject::_afterSuccessfulDestroy =  []
      subject::_afterFailingCreate =      []
      subject::_afterFailingUpdate =      []
      subject::_afterFailingDestroy =     []

      subject::initializeDefaultCallbacks()

    it 'should add 2 callbacks to _afterSuccessfulCreate', ->
      expect(subject::_afterSuccessfulCreate.length).toEqual 2

    it 'should add 2 callbacks to _afterSuccessfulUpdate', ->
      expect(subject::_afterSuccessfulUpdate.length).toEqual 2

    it 'should add 1 callback to _afterSuccessfulDestroy', ->
      expect(subject::_afterSuccessfulCreate.length).toEqual 1
