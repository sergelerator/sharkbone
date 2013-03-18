// Generated by CoffeeScript 1.5.0
(function() {

  describe('Number', function() {
    var subject;
    subject = null;
    beforeEach(function() {
      return subject = Number;
    });
    it('should be able to define methods', function() {
      return expect(subject.define).toBeDefined();
    });
    it('should have an errVal property', function() {
      return expect(subject.prototype.errVal).toBeDefined();
    });
    describe('toInt', function() {
      beforeEach(function() {
        return subject = subject.prototype.toInt;
      });
      it('should be defined', function() {
        return expect(subject).toBeDefined();
      });
      it('should return itself when called from an Int', function() {
        var a;
        a = 4;
        return expect(a.toInt()).toEqual(4);
      });
      return it('should strip the decimal part when called from a Float', function() {
        var a;
        a = 4.44;
        return expect(a.toInt()).toEqual(4);
      });
    });
    describe('toF', function() {
      beforeEach(function() {
        return subject = subject.prototype.toF;
      });
      it('should be defined', function() {
        return expect(subject).toBeDefined();
      });
      it('should return itself when called from an Int', function() {
        var a;
        a = 4;
        return expect(a.toF()).toEqual(4);
      });
      return it('should return itself  when called from a Float', function() {
        var a;
        a = 4.44;
        return expect(a.toF()).toEqual(4.44);
      });
    });
    return describe('plus', function() {
      beforeEach(function() {
        return subject = subject.prototype.plus;
      });
      it('should be defined', function() {
        return expect(subject).toBeDefined();
      });
      it('should properly sum the provided value to self', function() {
        var a;
        a = 4;
        return expect(a.plus(8)).toEqual(12);
      });
      it('should properly sum a Float and an Int value', function() {
        var a;
        a = 4.44;
        return expect(a.plus(4)).toBeCloseTo(8.44, 4);
      });
      it('should properly sum an Int and a Float value', function() {
        var a;
        a = 4;
        return expect(a.plus(4.35)).toBeCloseTo(8.35, 4);
      });
      return it('should properly sum two Float values', function() {
        var a;
        a = 4.23;
        return expect(a.plus(4.35)).toBeCloseTo(8.58, 4);
      });
    });
  });

}).call(this);
