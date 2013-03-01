describe 'Sharkbone.Model', ->
  subject = Sharkbone.Model

  it 'should be defined', ->
    expect(subject).toBeDefined()

  it 'should have the extend method', ->
    expect(subject.extend).toEqual jasmine.any Function

  it 'should have the include method', ->
    expect(subject.include).toEqual jasmine.any Function

  it 'should have the appNamespace method', ->
    expect(subject.appNamespace).toEqual jasmine.any Function

  describe 'included modules', ->
    describe 'Sharkbone.Modules.Relational', ->
      it 'should have a setupRelations method', ->
        expect(subject::setupRelations).toEqual jasmine.any Function

      it 'should have a fetchCollections method', ->
        expect(subject::fetchCollections).toEqual jasmine.any Function

      it 'should have a createDotSyntaxCollectionGetters method', ->
        expect(subject::createDotSyntaxCollectionGetters).toEqual jasmine.any Function

      it 'should have a toJSON method', ->
        expect(subject::toJSON).toEqual jasmine.any Function

  describe 'extended modules', ->
    describe 'Sharkbone.ClassModules.Relational', ->
      it 'should have a hasMany method', ->
        expect(subject.hasMany).toEqual jasmine.any Function

      it 'should have a hasOne method', ->
        expect(subject.hasOne).toEqual jasmine.any Function
