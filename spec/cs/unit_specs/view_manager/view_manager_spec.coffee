describe 'Sharkbone.ViewManager', ->
  subject = Sharkbone.ViewManager

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'Navigation helpers', ->
    it 'should include its methods', ->
      expect(subject::goToIndex).toBeDefined()
      expect(subject::goToShow).toBeDefined()

  describe 'Route helpers', ->
    it 'should include its methods', ->
      expect(subject::getRootPath).toBeDefined()
      expect(subject::getResourceId).toBeDefined()
      expect(subject::indexPath).toBeDefined()
      expect(subject::showPath).toBeDefined()
      expect(subject::editPath).toBeDefined()
