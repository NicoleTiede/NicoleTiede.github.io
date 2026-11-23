// Video auf der Startseite: YouTube wird erst geladen, wenn jemand das Video abspielt.
// Ohne Skript (oder beim Öffnen als lokale Datei) führt der Link direkt zu YouTube.
(function () {
  var link = document.querySelector('.video__start');
  if (!link) return;

  link.addEventListener('click', function (event) {
    // neuer Tab, neues Fenster: normaler Link
    if (event.metaKey || event.ctrlKey || event.shiftKey || event.button !== 0) return;
    // YouTube spielt eingebettete Videos nicht ab, wenn die Seite als Datei geöffnet ist
    if (location.protocol === 'file:') return;

    event.preventDefault();
    var frame = document.createElement('iframe');
    frame.src = 'https://www.youtube-nocookie.com/embed/' + link.dataset.video +
      '?start=' + link.dataset.start + '&autoplay=1&playsinline=1&rel=0';
    frame.title = link.dataset.title;
    frame.allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen';
    frame.allowFullscreen = true;
    frame.referrerPolicy = 'strict-origin-when-cross-origin';
    link.replaceWith(frame);
    frame.focus();
  });
})();
