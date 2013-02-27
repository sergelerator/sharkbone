// Generated by CoffeeScript 1.5.0
(function() {

  describe('Mixin', function() {
    var subject;
    subject = Sharkbone.Mixin;
    it('should be defined', function() {
      return expect(subject).toBeDefined();
    });
    return describe('Class methods', function() {
      beforeEach(function() {
        root.TestBase = (function() {

          function TestBase() {}

          _(TestBase).extend(subject);

          TestBase.prototype.varOne = 1;

          TestBase.prototype.varTwo = 2;

          TestBase.prototype.methOne = function() {
            return this.varOne;
          };

          TestBase.prototype.methTwo = function() {
            return this.varTwo;
          };

          return TestBase;

        })();
        root.TestExtendable = (function() {

          function TestExtendable() {}

          TestExtendable.prototype.varThree = 3;

          TestExtendable.prototype.varFour = 4;

          TestExtendable.prototype.methThree = function() {
            return this.varThree;
          };

          TestExtendable.prototype.methFour = function() {
            return this.varFour;
          };

          TestExtendable.prototype.beforeExtend = function() {
            return true;
          };

          TestExtendable.prototype.extended = function() {
            return true;
          };

          TestExtendable.prototype.beforeInclude = function() {
            return true;
          };

          TestExtendable.prototype.included = function() {
            return true;
          };

          return TestExtendable;

        })();
        root.ExtendableObject = {
          varFive: 5,
          methFive: function() {
            return this.varFive;
          },
          beforeExtend: function() {
            return true;
          },
          extended: function() {
            return true;
          },
          beforeInclude: function() {
            return true;
          },
          included: function() {
            return true;
          }
        };
        spyOn(TestExtendable.prototype, 'beforeExtend');
        spyOn(TestExtendable.prototype, 'extended');
        spyOn(TestExtendable.prototype, 'beforeInclude');
        spyOn(TestExtendable.prototype, 'included');
        spyOn(ExtendableObject, 'beforeExtend');
        spyOn(ExtendableObject, 'extended');
        spyOn(ExtendableObject, 'beforeInclude');
        return spyOn(ExtendableObject, 'included');
      });
      describe('@extend', function() {
        beforeEach(function() {
          return TestBase.extend(TestExtendable);
        });
        it('should be a function', function() {
          expect(subject.extend).toBeDefined();
          return expect(subject.extend).toEqual(jasmine.any(Function));
        });
        it('should extend an object\'s attributes', function() {
          expect(TestBase.varThree).toBeDefined();
          return expect(TestBase.varFour).toBeDefined();
        });
        it('should extend an object\'s methods', function() {
          expect(TestBase.methThree).toEqual(jasmine.any(Function));
          return expect(TestBase.methFour).toEqual(jasmine.any(Function));
        });
        it('should have called the beforeExtend method', function() {
          return expect(TestExtendable.prototype.beforeExtend).toHaveBeenCalled();
        });
        it('should have called the extended method', function() {
          return expect(TestExtendable.prototype.extended).toHaveBeenCalled();
        });
        return describe('bare objects', function() {
          beforeEach(function() {
            return TestBase.extend(ExtendableObject);
          });
          it('should extend from a bare object', function() {
            expect(TestBase.varFive).toBeDefined();
            return expect(TestBase.methFive).toEqual(jasmine.any(Function));
          });
          it('should have the extended object\'s methods implementation', function() {
            return expect(TestBase.methFive()).toEqual(5);
          });
          it('should have called the beforeExtend method', function() {
            return expect(ExtendableObject.beforeExtend).toHaveBeenCalled();
          });
          return it('should have called the extended method', function() {
            return expect(ExtendableObject.extended).toHaveBeenCalled();
          });
        });
      });
      return describe('@include', function() {
        beforeEach(function() {
          return TestBase.include(TestExtendable);
        });
        it('should be a function', function() {
          expect(subject.include).toBeDefined();
          return expect(subject.include).toEqual(jasmine.any(Function));
        });
        it('should include an object\'s attributes in it\'s prototype', function() {
          expect(TestBase.prototype.varThree).toBeDefined();
          return expect(TestBase.prototype.varFour).toBeDefined();
        });
        it('should include an object\'s methods in it\'s prototype', function() {
          expect(TestBase.prototype.methThree).toEqual(jasmine.any(Function));
          return expect(TestBase.prototype.methFour).toEqual(jasmine.any(Function));
        });
        it('should have called the beforeInclude method', function() {
          return expect(TestExtendable.prototype.beforeInclude).toHaveBeenCalled();
        });
        it('should have called the included method', function() {
          return expect(TestExtendable.prototype.included).toHaveBeenCalled();
        });
        return describe('bare objects', function() {
          beforeEach(function() {
            return TestBase.include(ExtendableObject);
          });
          it('should include from a bare object', function() {
            expect(TestBase.prototype.varFive).toBeDefined();
            return expect(TestBase.prototype.methFive).toEqual(jasmine.any(Function));
          });
          it('should have the extended object\'s methods implementation', function() {
            return expect(TestBase.prototype.methFive()).toEqual(5);
          });
          it('should have called the beforeExtend method', function() {
            return expect(ExtendableObject.beforeInclude).toHaveBeenCalled();
          });
          return it('should have called the extended method', function() {
            return expect(ExtendableObject.included).toHaveBeenCalled();
          });
        });
      });
    });
  });

}).call(this);
