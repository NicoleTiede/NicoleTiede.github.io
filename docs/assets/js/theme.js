// Hell ist Standard. Wer auf dunkel umschaltet, bekommt die Wahl
// im eigenen Browser gemerkt (localStorage); übertragen wird nichts.
(function () {
  var KEY = 'zumba-theme';
  var root = document.documentElement;
  var theme = 'light';

  try {
    if (localStorage.getItem(KEY) === 'dark') theme = 'dark';
  } catch (e) {}

  function apply() {
    if (theme === 'dark') root.setAttribute('data-theme', 'dark');
    else root.removeAttribute('data-theme');

    var meta = document.querySelector('meta[name="theme-color"]');
    if (meta) meta.setAttribute('content', theme === 'dark' ? '#000000' : '#f7f7fa');

    var btn = document.querySelector('.theme-toggle');
    if (btn) {
      var label = theme === 'dark' ? 'Helle Darstellung einschalten' : 'Dunkle Darstellung einschalten';
      btn.setAttribute('aria-label', label);
      btn.title = label;
    }
  }

  root.classList.add('js');
  apply();

  document.addEventListener('DOMContentLoaded', function () {
    apply(); // Schalter beschriften, sobald er im Dokument steht
    var btn = document.querySelector('.theme-toggle');
    if (!btn) return;
    btn.addEventListener('click', function () {
      theme = theme === 'dark' ? 'light' : 'dark';
      apply();
      try {
        localStorage.setItem(KEY, theme);
      } catch (e) {}
    });
  });
})();
