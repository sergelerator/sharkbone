// Generated by CoffeeScript 1.5.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  describe('Sharkbone.Modules.CUDCallbacks', function() {
    var server, subject;
    subject = Sharkbone.Modules.CUDCallbacks;
    server = null;
    beforeEach(function() {
      subject._afterSuccessfulCreate = [];
      subject._afterSuccessfulUpdate = [];
      subject._afterSuccessfulDestroy = [];
      subject._afterFailingCreate = [];
      subject._afterFailingUpdate = [];
      subject._afterFailingDestroy = [];
      subject.remove = jasmine.createSpy('remove').andReturn(1);
      subject.goToIndex = jasmine.createSpy('goToIndex').andReturn(1);
      subject.goToShow = jasmine.createSpy('goToShow').andReturn(1);
      return server = sinon.fakeServer.create();
    });
    afterEach(function() {
      return server.restore();
    });
    it('should be defined', function() {
      return expect(subject).toBeDefined();
    });
    describe('Callback containers', function() {
      it('_afterSuccessfulCreate', function() {
        return expect(subject._afterSuccessfulCreate).toEqual([]);
      });
      it('_afterSuccessfulUpdate', function() {
        return expect(subject._afterSuccessfulUpdate).toEqual([]);
      });
      it('_afterSuccessfulDestroy', function() {
        return expect(subject._afterSuccessfulDestroy).toEqual([]);
      });
      it('_afterFailingCreate', function() {
        return expect(subject._afterFailingCreate).toEqual([]);
      });
      it('_afterFailingUpdate', function() {
        return expect(subject._afterFailingUpdate).toEqual([]);
      });
      return it('_afterFailingDestroy', function() {
        return expect(subject._afterFailingDestroy).toEqual([]);
      });
    });
    describe('callbacks', function() {
      beforeEach(function() {
        Sharkbone.App.Models.User = (function(_super) {

          __extends(User, _super);

          function User() {
            User.__super__.constructor.apply(this, arguments);
          }

          User.prototype.urlRoot = 'users';

          return User;

        })(Sharkbone.Model);
        Sharkbone.App.Models.User.setup();
        spyOn(subject, 'registerCallback').andCallThrough();
        spyOn(subject, 'registerCallbacks').andCallThrough();
        return subject.mockCallback = jasmine.createSpy('mockCallback').andReturn(1);
      });
      describe('afterCreate', function() {
        beforeEach(function() {
          spyOn(subject, 'afterCreate').andCallThrough();
          subject.afterCreate(subject.mockCallback);
          subject.model = new Sharkbone.App.Models.User();
          return server.respondWith('POST', '/users.json', [
            200, {
              'Content-Tpye': 'application/json'
            }, '{name: John, last_name: Doe}'
          ]);
        });
        it('should be called with a mockCallback', function() {
          expect(subject.afterCreate).toHaveBeenCalled();
          return expect(subject.afterCreate).toHaveBeenCalledWith(subject.mockCallback);
        });
        it('registerCallbacks properly called', function() {
          expect(subject.registerCallbacks).toHaveBeenCalled();
          return expect(subject.registerCallbacks).toHaveBeenCalledWith(subject._afterSuccessfulCreate, {
            0: subject.mockCallback
          });
        });
        it('registerCallback properly called', function() {
          return expect(subject.registerCallback).toHaveBeenCalledWith(subject._afterSuccessfulCreate, subject.mockCallback);
        });
        it('should add mockCallback to _afterSuccessfulCreate', function() {
          expect(subject._afterSuccessfulCreate.length).toEqual(1);
          return expect(subject._afterSuccessfulCreate[0]).toEqual(subject.mockCallback);
        });
        return it('should call mockCallback afterCreate', function() {
          subject.model.set({
            name: 'John',
            last_name: 'Doe'
          });
          subject.model.save();
          server.respond();
          return expect(subject.mockCallback).toHaveBeenCalled();
        });
      });
      describe('afterUpdate', function() {
        beforeEach(function() {
          spyOn(subject, 'afterUpdate').andCallThrough();
          return subject.afterUpdate(subject.mockCallback);
        });
        it('should be called with a mockCallback', function() {
          expect(subject.afterUpdate).toHaveBeenCalled();
          return expect(subject.afterUpdate).toHaveBeenCalledWith(subject.mockCallback);
        });
        it('registerCallbacks properly called', function() {
          expect(subject.registerCallbacks).toHaveBeenCalled();
          return expect(subject.registerCallbacks).toHaveBeenCalledWith(subject._afterSuccessfulUpdate, {
            0: subject.mockCallback
          });
        });
        it('registerCallback properly called', function() {
          return expect(subject.registerCallback).toHaveBeenCalledWith(subject._afterSuccessfulUpdate, subject.mockCallback);
        });
        return it('should add mockCallback to _afterSuccessfulUpdate', function() {
          expect(subject._afterSuccessfulUpdate.length).toEqual(1);
          return expect(subject._afterSuccessfulUpdate[0]).toEqual(subject.mockCallback);
        });
      });
      return describe('afterDestroy', function() {
        beforeEach(function() {
          spyOn(subject, 'afterDestroy').andCallThrough();
          return subject.afterDestroy(subject.mockCallback);
        });
        it('should be called with a mockCallback', function() {
          expect(subject.afterDestroy).toHaveBeenCalled();
          return expect(subject.afterDestroy).toHaveBeenCalledWith(subject.mockCallback);
        });
        it('registerCallbacks properly called', function() {
          expect(subject.registerCallbacks).toHaveBeenCalled();
          return expect(subject.registerCallbacks).toHaveBeenCalledWith(subject._afterSuccessfulDestroy, {
            0: subject.mockCallback
          });
        });
        it('registerCallback properly called', function() {
          return expect(subject.registerCallback).toHaveBeenCalledWith(subject._afterSuccessfulDestroy, subject.mockCallback);
        });
        return it('should add mockCallback to _afterSuccessfulDestroy', function() {
          expect(subject._afterSuccessfulDestroy.length).toEqual(1);
          return expect(subject._afterSuccessfulDestroy[0]).toEqual(subject.mockCallback);
        });
      });
    });
    return describe('initializeDefaultCallbacks', function() {
      beforeEach(function() {
        spyOn(subject, 'afterCreate').andCallThrough();
        spyOn(subject, 'afterUpdate').andCallThrough();
        spyOn(subject, 'afterDestroy').andCallThrough();
        return subject.initializeDefaultCallbacks();
      });
      it('should have called afterCreate', function() {
        return expect(subject.afterCreate).toHaveBeenCalled();
      });
      it('should have called afterUpdate', function() {
        return expect(subject.afterUpdate).toHaveBeenCalled();
      });
      it('should have called afterDestroy', function() {
        return expect(subject.afterDestroy).toHaveBeenCalled();
      });
      it('should add 2 callbacks to _afterSuccessfulCreate', function() {
        return expect(subject._afterSuccessfulCreate.length).toEqual(2);
      });
      it('should add 2 callbacks to _afterSuccessfulUpdate', function() {
        return expect(subject._afterSuccessfulUpdate.length).toEqual(2);
      });
      return it('should add 1 callback to _afterSuccessfulDestroy', function() {
        return expect(subject._afterSuccessfulDestroy.length).toEqual(1);
      });
    });
  });

}).call(this);
