// Generated by CoffeeScript 1.5.0
(function() {

  describe('Sharkbone.Modules.Relational', function() {
    var subject;
    subject = Sharkbone.Modules.Relational;
    beforeEach(function() {
      var children_collection, sons_collection;
      subject.prototype.urlRoot = 'parents';
      subject.prototype.relations = [
        {
          key: 'children'
        }, {
          key: 'sons'
        }
      ];
      children_collection = {
        url: 'children'
      };
      sons_collection = {
        url: 'sons'
      };
      return subject.prototype.get = jasmine.createSpy('get').andCallFake(function(key) {
        var attrs;
        return (attrs = attrs || {
          'id': 1,
          'children': children_collection,
          'sons': sons_collection
        })[key];
      });
    });
    it('should create spies for each requested method', function() {
      return expect(subject.prototype.get).toBeDefined();
    });
    it('returns "parents" when te urlRoot attribute is accessed', function() {
      return expect(subject.prototype.urlRoot).toEqual("parents");
    });
    it('returns two objects when relations attribute is accessed', function() {
      return expect(subject.prototype.relations.length).toEqual(2);
    });
    it('returns 1 when the fake "get" method is called with argument "id"', function() {
      return expect(subject.prototype.get('id')).toEqual(1);
    });
    it('returns the "children" key when the first relations member is accessed', function() {
      return expect(subject.prototype.relations[0].key).toEqual('children');
    });
    describe('setupRelations', function() {
      beforeEach(function() {
        return subject.prototype.setupRelations();
      });
      it('should be defined', function() {
        return expect(subject.prototype.setupRelations).toEqual(jasmine.any(Function));
      });
      it('should properly set the children url', function() {
        return expect(subject.prototype.get('children').url).toEqual('parents/1/children');
      });
      return it('should properly set the sons url', function() {
        return expect(subject.prototype.get('sons').url).toEqual('parents/1/sons');
      });
    });
    describe('fetchCollections', function() {});
    return describe('createDotSyntaxCollectionGetters', function() {
      it('should be defined', function() {
        return expect(subject.prototype.createDotSyntaxCollectionGetters).toBeDefined();
      });
      return it('should create dot syntax getters', function() {
        subject.prototype.createDotSyntaxCollectionGetters();
        expect(subject.prototype.children()).toEqual(jasmine.any(Object));
        return expect(subject.prototype.sons()).toEqual(jasmine.any(Object));
      });
    });
  });

}).call(this);
