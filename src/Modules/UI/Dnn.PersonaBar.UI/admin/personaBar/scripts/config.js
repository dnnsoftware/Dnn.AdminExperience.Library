'use strict';
define(['jquery'], function ($) {
    return {
        init: function () {
            var inIframe = window !== window.top && typeof window.top.dnn !== "undefined";

            var tabId = inIframe ? window.top.dnn.getVar('sf_tabId') : '';
            var siteRoot = inIframe ? window.top.dnn.getVar('sf_siteRoot') : '';
            var antiForgeryToken = '';

			if (inIframe){
				var rvt = window.top.document.getElementsByName('__RequestVerificationToken');
				if (rvt && rvt.length)
					antiForgeryToken = rvt[0].value;
			}
            var config = $.extend({}, {
                tabId: tabId,
                siteRoot: siteRoot,
                antiForgeryToken: antiForgeryToken
            }, inIframe ? window.parent['personaBarSettings'] : {});

            return config;   
       } 
    };
});