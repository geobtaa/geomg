// Fields - JS Behaviors

// Disable Field if Persisted
GEOMG.DisableIfPersisted = function() {
  elms = $('[data-js="disable_if_persisted"]');

  elms.each(function(i) {
    $(this).prop( "disabled", true );
  });
}