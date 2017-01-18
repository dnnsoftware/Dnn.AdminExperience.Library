using System;
using System.Linq;
using System.Web.Helpers;
using System.Web.UI;
using Dnn.PersonaBar.Library.Containers;
using Dnn.PersonaBar.Library.Controllers;
using DotNetNuke.Entities.Portals;
using DotNetNuke.Entities.Users;
using DotNetNuke.Framework;
using DotNetNuke.Framework.JavaScriptLibraries;
using DotNetNuke.UI.Utilities;
using DotNetNuke.Web.Client.ClientResourceManagement;
using Newtonsoft.Json;
using static System.Web.HttpUtility;

namespace Dnn.PersonaBar.UI.admin.personaBar
{
    public class StandaloneContainer : Page
    {
        private readonly IPersonaBarContainer _personaBarContainer = PersonaBarContainer.Instance;

        public string PersonaBarSettings => JsonConvert.SerializeObject(_personaBarContainer.GetConfiguration());

        public void RegisterAjaxAntiForgery()
        {
            var ctl = FindControl("ClientResourcesFormBottom");
            if (ctl != null)
            {
                ctl.Controls.Add(new LiteralControl(AntiForgery.GetHtml().ToHtmlString()));
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            var user = UserController.Instance.GetCurrentUserInfo();
            if (user.UserID <= 0)
            {                
                Response.Redirect($"~/Login?returnurl={UrlEncode("/admin2")}");
                return;
            }

            RegisterAjaxAntiForgery();

            InjectPersonaBar();            
        }

        private bool InjectPersonaBar()
        {
            if (!_personaBarContainer.Visible)
            {
                return false;
            }

            //copied this logic from DotNetNuke.UI.Skins.Skin.InjectControlPanel
            if (Request.QueryString["dnnprintmode"] == "true" || Request.QueryString["popUp"] == "true")
                return false;

            var menuStructure = PersonaBarController.Instance.GetMenu(PortalSettings.Current, UserController.Instance.GetCurrentUserInfo());
            if (menuStructure.MenuItems == null || !menuStructure.MenuItems.Any())
            {
                return false;
            }

            RegisterPersonaBarStyleSheet();

            JavaScript.RegisterClientReference(Page, ClientAPI.ClientNamespaceReferences.dnn);
            JavaScript.RequestRegistration(CommonJs.DnnPlugins); //We need to add the Dnn JQuery plugins because the Edit Bar removes the Control Panel from the page
            JavaScript.RequestRegistration(CommonJs.KnockoutMapping);

            ServicesFramework.Instance.RequestAjaxAntiForgerySupport();

            ClientResourceManager.RegisterScript(Page, "~/Resources/Shared/Components/Tokeninput/jquery.tokeninput.js");
            ClientResourceManager.RegisterStyleSheet(Page, "~/Resources/Shared/Components/Tokeninput/Themes/token-input-facebook.css");

            return true;
        }

        private void RegisterPersonaBarStyleSheet()
        {
            ClientResourceManager.RegisterStyleSheet(Page, "~/DesktopModules/admin/Dnn.PersonaBar/css/personaBarContainer.css");
        }
    }
}
