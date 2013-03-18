describe 'Sharkbone.Modules.Render', ->
  subject = null

  beforeEach ->
    subject = Sharkbone.Modules.Render
    template = jasmine.createSpy('template').andCallFake -> '<div>data</div>'

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'render', ->
    it 'should be defined', ->
      expect(subject.render).toBeDefined()

  describe 'renderData', ->
    it 'should be defined', ->
      expect(subject.renderData).toBeDefined()

  describe 'renderResource', ->
    it 'should be defined', ->
      expect(subject.renderResource).toBeDefined()

  describe 'renderCollection', ->
    it 'should be defined', ->
      expect(subject.renderCollection).toBeDefined()

  describe 'renderPagination', ->
    it 'should be defined', ->
      expect(subject.renderPagination).toBeDefined()
