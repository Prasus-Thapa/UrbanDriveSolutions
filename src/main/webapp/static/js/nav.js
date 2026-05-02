(function () {
    var toggle = document.getElementById('navToggle');
    var nav = toggle ? toggle.closest('.top-nav') : null;
    if (!toggle || !nav) return;

    toggle.addEventListener('click', function () {
        var isOpen = nav.classList.toggle('nav-open');
        toggle.setAttribute('aria-label', isOpen ? 'Close menu' : 'Open menu');
    });

    // Close when a nav link is clicked
    nav.querySelectorAll('.nav-links a').forEach(function (a) {
        a.addEventListener('click', function () {
            nav.classList.remove('nav-open');
            toggle.setAttribute('aria-label', 'Open menu');
        });
    });

    // Close when clicking outside the nav
    document.addEventListener('click', function (e) {
        if (!nav.contains(e.target)) {
            nav.classList.remove('nav-open');
            toggle.setAttribute('aria-label', 'Open menu');
        }
    });
})();
