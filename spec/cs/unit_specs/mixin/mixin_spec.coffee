describe 'Mixin', ->
  subject = Sharkbone.Mixin

  it 'should be defined', ->
    expect(subject).toBeDefined()

  describe 'Class methods', ->
    beforeEach ->
      class root.TestBase
        _(@).extend subject

        varOne: 1
        varTwo: 2

        methOne: -> @varOne
        methTwo: -> @varTwo

      class root.TestExtendable
        varThree: 3
        varFour: 4

        methThree: -> @varThree
        methFour: -> @varFour
        beforeExtend: -> true
        extended: -> true
        beforeInclude: -> true
        included: -> true

      root.ExtendableObject =
        varFive: 5
        methFive: -> @varFive
        beforeExtend: -> true
        extended: -> true
        beforeInclude: -> true
        included: -> true

      spyOn TestExtendable::, 'beforeExtend'
      spyOn TestExtendable::, 'extended'
      spyOn TestExtendable::, 'beforeInclude'
      spyOn TestExtendable::, 'included'

      spyOn ExtendableObject, 'beforeExtend'
      spyOn ExtendableObject, 'extended'
      spyOn ExtendableObject, 'beforeInclude'
      spyOn ExtendableObject, 'included'

    describe '@extend', ->
      beforeEach -> TestBase.extend TestExtendable

      it 'should be a function', ->
        expect(subject.extend).toBeDefined()
        expect(subject.extend).toEqual jasmine.any Function

      it 'should extend an object\'s attributes', ->
        expect(TestBase.varThree).toBeDefined()
        expect(TestBase.varFour).toBeDefined()

      it 'should extend an object\'s methods', ->
        expect(TestBase.methThree).toEqual jasmine.any Function
        expect(TestBase.methFour).toEqual jasmine.any Function

      it 'should have called the beforeExtend method', ->
        expect(TestExtendable::beforeExtend).toHaveBeenCalled()

      it 'should have called the extended method', ->
        expect(TestExtendable::extended).toHaveBeenCalled()

      describe 'bare objects', ->
        beforeEach -> TestBase.extend ExtendableObject

        it 'should extend from a bare object', ->
          expect(TestBase.varFive).toBeDefined()
          expect(TestBase.methFive).toEqual jasmine.any Function

        it 'should have the extended object\'s methods implementation', ->
          expect(TestBase.methFive()).toEqual 5

        it 'should have called the beforeExtend method', ->
          expect(ExtendableObject.beforeExtend).toHaveBeenCalled()

        it 'should have called the extended method', ->
          expect(ExtendableObject.extended).toHaveBeenCalled()

    describe '@include', ->
      beforeEach -> TestBase.include TestExtendable

      it 'should be a function', ->
        expect(subject.include).toBeDefined()
        expect(subject.include).toEqual jasmine.any Function

      it 'should include an object\'s attributes in it\'s prototype', ->
        expect(TestBase::varThree).toBeDefined()
        expect(TestBase::varFour).toBeDefined()

      it 'should include an object\'s methods in it\'s prototype', ->
        expect(TestBase::methThree).toEqual jasmine.any Function
        expect(TestBase::methFour).toEqual jasmine.any Function

      it 'should have called the beforeInclude method', ->
        expect(TestExtendable::beforeInclude).toHaveBeenCalled()

      it 'should have called the included method', ->
        expect(TestExtendable::included).toHaveBeenCalled()

      describe 'bare objects', ->
        beforeEach -> TestBase.include ExtendableObject

        it 'should include from a bare object', ->
          expect(TestBase::varFive).toBeDefined()
          expect(TestBase::methFive).toEqual jasmine.any Function

        it 'should have the extended object\'s methods implementation', ->
          expect(TestBase::methFive()).toEqual 5

        it 'should have called the beforeExtend method', ->
          expect(ExtendableObject.beforeInclude).toHaveBeenCalled()

        it 'should have called the extended method', ->
          expect(ExtendableObject.included).toHaveBeenCalled()
