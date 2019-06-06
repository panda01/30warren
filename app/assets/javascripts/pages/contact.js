const RemoteForm = require('modules/remote_form');

let contact = {
  setup: function () {
    const contact = new RemoteForm($('.registrant-form'));

    contact.on('success', function (data) {
      this.$element.replaceWith(data.template);

      ga('send', 'event', 'Contact', 'Form', 'Submit');
      fbq('track', 'Lead');

      $('html, body').animate({
        scrollTop: 0
      });
    });

    contact.on('failure', function (data) {
      this.$element.html(data.template);
      this.$element.find('.error').hide().slideDown();

      $('html, body').animate({
        scrollTop: this.$element.find('.error').offset().top - 160
      });
    });
  }
};

module.exports = contact;
