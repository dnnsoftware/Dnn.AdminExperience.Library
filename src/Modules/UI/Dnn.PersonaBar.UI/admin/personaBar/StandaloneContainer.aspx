﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StandaloneContainer.aspx.cs" Inherits="Dnn.PersonaBar.UI.admin.personaBar.StandaloneContainer" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
	<title>PersonaBar</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0" />
    <style>
        #topLevelMenu .hovermenu > ul, ul.personabarnav {list-style-type: none;}
    </style>
</head>
<body>
<input id="__dnnVariable" runat="server" name="__dnnVariable" type="hidden" autocomplete="off" />
<asp:placeholder runat="server" ID="ClientResourcesFormBottom" />
<%--<asp:placeholder runat="server" id="ClientResourceIncludes" />--%>
<script type="text/javascript">
    window.dnn = window.dnn || {}
    window.dnn.getVar = function(key, def) {
        var value = document.getElementById("__dnnVariable").value;
        var obj = JSON.parse(value.substr(1).replace(/`/g, '"'));
        return obj[key] || def;
    }
</script>
<div class="personabar" id="personabar">
        <div class="personabarLogo"></div>
        <div id="topLevelMenu">
            <ul class="personabarnav">
                <!-- ko foreach: { data: menu.menuItems, as: 'menuItem' } -->
                <li data-bind="
                    attr: {
                        'id': menuItem.id,
                        'data-path': menuItem.path, 
                        'data-query': menuItem.query,
                        'data-module-name': menuItem.moduleName,
                        'data-folder-name': menuItem.folderName,
                        'data-hovermenu-id': menuItem.id + 'hovermenu',
                        'data-name': menuItem.displayName,
                        'class': 'btn_panel ' + (menuItem.css || ''),
                        'href': menuItem.link
                    }">
                        <span data-bind="html: menuItem.displayName"></span>
                        <!-- ko if: menuItem.menuItems.length > 0 -->
                    <div class="hovermenu" data-bind="
                         attr: { 'id': menuItem.id + 'hovermenu' }, 
                         css: menuItem.id + 'hovermenu'">
                        <label data-bind="html: menuItem.displayName"></label>
                        <!-- ko foreach: { data: menuItem.menuItems, as: 'columnItem' } -->
                        <ul data-bind="foreach: { data: columnItem, as: 'subMenuItem' }">
                            <li data-bind="
                                        html: subMenuItem.displayName,
                                        attr: {
                                            'id': subMenuItem.id,
                                            'data-path': subMenuItem.path,
                                            'data-query': subMenuItem.query,
                                            'data-module-name': subMenuItem.moduleName,
                                            'data-folder-name': subMenuItem.folderName,
                                            'data-name': subMenuItem.displayName,
                                            'class': (subMenuItem.css || ''),
                                            'href': subMenuItem.link,
                                            'target': subMenuItem.link ? '_blank' : ''
                                        }"></li>
                        </ul>
                        <!-- /ko -->
                    </div>
                        <!-- /ko -->
                </li>
                <!-- /ko -->                
            </ul>
        </div>
    </div>
    <div class="socialmask"></div>
    <div class="socialpanel-placeholder"></div>
    <div id="personabar-panels"></div>
    <!-- extra -->
    <div id="mask"></div>
    <div id="confirmation-dialog" style="display: none;">
        <img class="notify-check" src="/DesktopModules/Admin/Dnn.PersonaBar/images/icon_exclamation.svg" alt="Warning"/>
        <p></p>
        <div class="buttonpanel">
            <a id="cancelbtn" aria-label="Cancel"></a>
            <a id="confirmbtn" aria-label="Confirm"></a>
        </div>
    </div>
    <div id="notification-dialog" style="display: none;">
        <img class="notify-check" src="/DesktopModules/Admin/Dnn.PersonaBar/images/notify_check.svg" alt="Success"/>
        <img class="notify-error" src="/DesktopModules/Admin/Dnn.PersonaBar/images/notify_error.svg" alt="Error"/>
        <div id="notification-message-container">
            <p id="notification-message"></p>
        </div>

        <div class="buttonpanel">
            <button id="close-notification" class="dnn-ui-common-button" role="primary" aria-label="Close"></button>
        </div>
    </div>
    <div id="personaBar-loadingbar" style="display: none;">
        <div></div>
        <span></span>
        <img id="close-load-error" class="thin-close-x" src="/DesktopModules/Admin/Dnn.PersonaBar/images/x_thin.svg" alt="Close">
    </div>
    <!-- end extra -->
<asp:placeholder runat="server">
    <script type="text/javascript">
        (function injectboostrap() {
            window['personaBarSettings'] = <%=PersonaBarSettings%>;
            var debugMode = window['personaBarSettings']['debugMode'] === true;
            var cdv = window['personaBarSettings']['buildNumber'];
            var version = (cdv ? '?cdv=' + cdv : '') + (debugMode ? '&t=' + Math.random() : '');
            var body = document.getElementsByTagName('body')[0];
            var boostrapScript = document.createElement('script');
            boostrapScript.setAttribute('src', 'DesktopModules/Admin/Dnn.PersonaBar/scripts/bootstrap.js' + version);
            body.appendChild(boostrapScript);
        })();
    </script>
</asp:placeholder>
</body>
</html>