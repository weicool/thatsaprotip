//= require Protip

(function($) {
  $.fn.Protips = function() {
    $('.protip').each(function(i, protip) {
      $(protip).Protip();
    });
  }
})(jQuery);

$($('.protips').Protips);
