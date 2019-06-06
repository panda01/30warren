function RemoteForm($element) {
  this.$element = $element;
  this.callbacks = {};

  this.$element.on('ajax:success', 'form', function(e, data, status, xhr) {
    let callback = this.callbacks[data.status];

    callback && callback.call(this, data);
  }.bind(this));
}

RemoteForm.prototype.on = function(event, fn) {
  this.callbacks[event] = fn;
}

module.exports = RemoteForm;
