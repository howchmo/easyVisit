function write()
{
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function()
        {
                if (xmlhttp.readyState == 4 && xmlhttp.status != 200)
                {
                        // What you want to do on failure
                        console.log(xmlhttp.status + " : " + xmlhttp.responseText);
                }
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                        // What you want to do on success
                        console.log("GOOD!");
                }
        }
        xmlhttp.open("POST", "http://localhost/easyVisit/postVisitData.jsp", true);
        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencdoed");
        xmlhttp.setRequestHeader("Cache-Control", "no-cache");
        xmlhttp.send("name=Howard&who=Joe&where=ECS&why=meeting&badge=ecs-visitor-957935676");
}

