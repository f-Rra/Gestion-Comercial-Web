using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gestion_Comercial_Web.Pages.Stock
{
    public partial class GestionStock : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ((SiteMaster)this.Master).PageTitle = "Gestión de Stock";
                ((SiteMaster)this.Master).PageSubtitle = "Gestione el inventario y movimientos de stock";
            }
        }
    }
}