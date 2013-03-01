describe 'Sharkbone.ClassModules.Relational', ->
  subject = Sharkbone.ClassModules.Relational

  beforeEach ->
    subject.appNamespace = jasmine.createSpy('appNamespace').andReturn 'Sharkbone.App.'
    subject:: = {}

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'hasMany', ->
    it 'should be defined', ->
      expect(subject.hasMany).toBeDefined()

    it 'should raise an exception when called without a key', ->
      expect(subject.hasMany).toThrow()

    describe 'sons collection', ->
      beforeEach ->
        subject::relations = null
        subject.hasMany.call(subject, 'sons')

      it 'should add a key to prototype.relation', ->
        expect(subject::relations.length).toEqual 1

      it 'should match the expected relation object', ->
        expect(subject::relations[0]).toEqual {
          type: Backbone.HasMany
          key: 'sons'
          relatedModel: 'Sharkbone.App.Models.Son'
          collectionType: 'Sharkbone.App.Collections.Sons'
        }

    describe 'children collection', ->
      beforeEach ->
        subject::relations = null
        subject.hasMany.call(subject, 'children', collectionType: 'Sharkbone.App.Collections.Children')

      it 'should add a key to prototype.relation', ->
        expect(subject::relations.length).toEqual 1

      it 'should match the expected relation object', ->
        expect(subject::relations[0]).toEqual {
          type: Backbone.HasMany
          key: 'children'
          relatedModel: 'Sharkbone.App.Models.Child'
          collectionType: 'Sharkbone.App.Collections.Children'
        }

  describe 'hasOne', ->
    it 'should be defined', ->
      expect(subject.hasOne).toBeDefined()

    it 'should raise an exception when called without a key', ->
      expect(subject.hasOne).toThrow()

    describe 'related possession', ->
      beforeEach ->
        subject::relations = null
        subject.hasOne.call(subject, 'possession')

      it 'should add a key to prototype.relation', ->
        expect(subject::relations.length).toEqual 1

      it 'should match the expected relation object', ->
        expect(subject::relations[0]).toEqual {
          type: Backbone.HasOne
          key: 'possession'
          relatedModel: 'Sharkbone.App.Models.Possession'
        }

    describe 'related task', ->
      beforeEach ->
        subject::relations = null
        subject.hasOne.call(subject, 'task', relatedModel: 'Sharkbone.App.Models.Chore')

      it 'should add a key to prototype.relation', ->
        expect(subject::relations.length).toEqual 1

      it 'should match the expected relation object', ->
        expect(subject::relations[0]).toEqual {
          type: Backbone.HasOne
          key: 'task'
          relatedModel: 'Sharkbone.App.Models.Chore'
        }
