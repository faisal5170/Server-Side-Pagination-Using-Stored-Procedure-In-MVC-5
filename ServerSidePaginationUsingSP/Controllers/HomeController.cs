using ServerSidePaginationUsingSP.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ServerSidePaginationUsingSP.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public JsonResult GetDetails()
        {
            DBFirstDemoEntities _context = new DBFirstDemoEntities();
            List<GetUserDetails_Result> data = new List<GetUserDetails_Result>();
            var start = (Convert.ToInt32(Request["start"]));
            var Length = (Convert.ToInt32(Request["length"])) == 0 ? 10 : (Convert.ToInt32(Request["length"]));
            var searchvalue = Request["search[value]"] ?? "";
            var sortcoloumnIndex = Convert.ToInt32(Request["order[0][column]"]);
            var SortColumn = "";
            var SortOrder = "";
            var sortDirection = Request["order[0][dir]"] ?? "asc";
            var recordsTotal = 0;
            try
            {
                switch (sortcoloumnIndex)
                {
                    case 0:
                        SortColumn = "First_Name";
                        break;
                    case 1:
                        SortColumn = "Last_Name";
                        break;
                    case 2:
                        SortColumn = "Email_Address";
                        break;
                    case 3:
                        SortColumn = "Created_Date";
                        break;
                    case 4:
                        SortColumn = "Role_Name";
                        break;
                    default:
                        SortColumn = "UserId";
                        break;
                }
                if (sortDirection == "asc")
                    SortOrder = "asc";
                else
                    SortOrder = "desc";
                data = _context.GetUserDetails(start, searchvalue, Length, SortColumn, sortDirection).ToList();
                recordsTotal = data.Count > 0 ? data[0].TotalRecords : 0;
            }
            catch (Exception ex)
            {

            }
            return Json(new { data = data, recordsTotal = recordsTotal, recordsFiltered = recordsTotal }, JsonRequestBehavior.AllowGet);
        }

    }
}