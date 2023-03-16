// JS Behavior: Disable Fields
GEOMG.DisableIfPersisted = function() {
  elms = $('[data-js="disable_if_persisted"]');

  elms.each(function(i) {
    $(this).prop( "disabled", true );
  });
}