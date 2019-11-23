(function() {
  var chai, getUniqId, sinon, sinonChai;

  before(function(next) {
    return require('jsdom').env({
      html: "<!doctype html><html><head><meta charset='utf-8'></head><body></body></html>",
      done: function(errors, window) {
        global.window = window;
        global.document = window.document;
        if (errors) {
          errors.forEach(console.error);
          throw new Error(errors[0].data.error + " (" + errors[0].data.filename + ")");
        }
        return next();
      }
    });
  });

  before(function() {
    global.$ = require('jquery');
    global.jQuery = require('jquery');
    return require('../src/jquery.turbolinks.coffee');
  });

  chai = require('chai');

  sinon = require('sinon');

  sinonChai = require('sinon-chai');

  chai.should();

  chai.use(sinonChai);

  getUniqId = (function() {
    var counter;
    counter = 0;
    return function() {
      return 'id_' + (counter += 1);
    };
  })();

  describe('$ Turbolinks', function() {
    var callback1, callback2;
    callback1 = callback2 = null;
    beforeEach(function() {
      $.turbo.isReady = false;
      $.turbo.use('page:load', 'page:fetch');
      return $(document).off('turbo:ready');
    });
    describe("DOM isn't ready", function() {
      beforeEach(function() {
        $(callback1 = sinon.spy());
        return $(callback2 = sinon.spy());
      });
      it('should trigger callbacks passed to\n`$()` and `$.ready()` when page:load\nevent fired', function() {
        $(document).trigger('page:load');
        callback1.should.have.been.calledOnce;
        return callback2.should.have.been.calledOnce;
      });
      it('should pass $ as the first argument to callbacks', function(done) {
        $(function($$) {
          $$.fn.should.be.an.object;
          return done();
        });
        return $(document).trigger('page:load');
      });
      describe('$.turbo.use', function() {
        beforeEach(function() {
          return $.turbo.use('page:load', 'page:fetch');
        });
        it('should unbind default (page:load) event', function() {
          $.turbo.use('other1', 'other2');
          $(document).trigger('page:load');
          callback1.should.have.not.been.called;
          return callback2.should.have.not.been.called;
        });
        return it('should bind ready to passed function', function() {
          $(document).trigger('page:load').trigger('page:change');
          callback1.should.have.been.calledOnce;
          return callback2.should.have.been.calledOnce;
        });
      });
      return describe('$.setFetchEvent', function() {
        beforeEach(function() {
          $.turbo.use('page:load', 'page:fetch');
          return $.turbo.isReady = true;
        });
        it('should unbind default (page:fetch) event', function() {
          $.turbo.use('page:load', 'random_event_name');
          $(document).trigger('page:fetch');
          return $.turbo.isReady.should.to.be["true"];
        });
        return it('should bind passed fetch event', function() {
          $.turbo.use('page:load', 'page:loading');
          $(document).trigger('page:loading');
          return $.turbo.isReady.should.to.be["false"];
        });
      });
    });
    return describe('DOM is ready', function() {
      beforeEach(function() {
        $.turbo.use('page:load', 'page:fetch');
        return $.turbo.isReady = true;
      });
      it('should call trigger right after add to waiting list', function() {
        var callback;
        $(callback = sinon.spy());
        return callback.should.have.been.calledOnce;
      });
      it('should not call trigger after page:fetch and before page:load', function() {
        $(document).trigger('page:fetch');
        $(callback1 = sinon.spy());
        callback1.should.have.not.been.called;
        $(document).trigger('page:load');
        $(callback2 = sinon.spy());
        return callback2.should.have.been.calledOnce;
      });
      it('should call trigger after a subsequent page:fetch and before page:load', function() {
        $(document).trigger('page:fetch');
        $(document).trigger('page:load');
        $(callback1 = sinon.spy());
        callback1.should.have.been.calledOnce;
        $(document).trigger('page:fetch');
        $(document).trigger('page:load');
        return callback1.should.have.been.calledTwice;
      });
      return it('should pass $ as the first argument to callbacks', function(done) {
        return $(function($$) {
          $$.fn.should.be.an.object;
          return done();
        });
      });
    });
  });

}).call(this);
