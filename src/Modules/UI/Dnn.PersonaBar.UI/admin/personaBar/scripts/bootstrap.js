(function () {
    function addCssToHead(css, version) {
        var head = document.getElementsByTagName('head')[0];
        for (var i = 0; i < css.length; i++) {
            var link = document.createElement('link');
            link.setAttribute('rel', 'stylesheet');
            link.setAttribute('type', 'text/css');
            link.setAttribute('href', css[i] + version);
            head.appendChild(link);
        }
    };
    function getDirection(element) {
        var result = null;
        if (element) {
            if (window.getComputedStyle) {
                result = window.getComputedStyle(element, null).direction;
            } else if (element.currentStyle) {
                result = element.currentStyle.direction;
            }
        }

        return result;
    }
    function addJsToBody(js, version) {
        var body = document.getElementsByTagName('body')[0];
        var script = document.createElement('script');
        script.setAttribute('src', 'scripts/contrib/require.js' + version);
        script.setAttribute('data-main', js + version);
        body.appendChild(script);
    };

    var personaBarSettings = window.parent['personaBarSettings'];
    var debugMode = personaBarSettings['debugMode'] === true;
    var cdv = personaBarSettings['buildNumber'];
    var skin = personaBarSettings['skin'];
    var version = (cdv ? '?cdv=' + cdv : '') + (debugMode ? '&t=' + Math.random() : '');
    var styles = [];
    var cssExt = getDirection(window.parent.document.body) == "rtl" ? '.rtl.css' : '.css';
    var mainJs = 'scripts/main.js';
    var mainCss = 'css/main' + cssExt;
    if (skin) {
        mainCss = 'css/' + skin + cssExt;
    }

    styles.push(mainCss);
    styles.push('css/graph' + cssExt);

    addCssToHead(styles, version);
    addJsToBody(mainJs, version);
})();