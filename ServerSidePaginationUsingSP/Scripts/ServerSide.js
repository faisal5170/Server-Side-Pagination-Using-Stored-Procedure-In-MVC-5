GetDataTableData();
function GetDataTableData() {
    $("#data").DataTable({
        "processing": true,
        "serverSide": true,
        "filter": true,
        "orderMulti": false,
        "destroy": true,
        "ordering": true,
        "ajax": {
            "url": '/Home/GetDetails',
            "type": "POST",
            "datatype": "json"
        },

        "columns": [
            { "data": "First_Name", "name": "First_Name", "autoWidth": true }
            , { "data": "Last_Name", "name": "Last_Name", "autoWidth": true }
            , { "data": "Email_Address", "name": "Email_Address", "autoWidth": true }
            , { "data": "TotalRecords", "name": "TotalRecords", "autoWidth": true }
        ]
    });
}