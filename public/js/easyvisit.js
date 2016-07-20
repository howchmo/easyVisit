function write( visitee, visitor, organization, citizenship, purpose, badge )
{
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.onreadystatechange = function()
        {
                if( xmlhttp.readyState == 4 && xmlhttp.status != 200 )
                {
                        // What you want to do on failure
                        console.log(xmlhttp.status + " : " + xmlhttp.responseText);
                }
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                        // What you want to do on success
                        console.log("Badge is valid!");
			var xhttp = new XMLHttpRequest();
			xhttp.onreadystatechange = function()
			{
				if (xhttp.readyState == 4 && xmlhttp.status != 200)
				{
					// What you want to do on failure
					console.log(xmlhttp.status + " : " + xmlhttp.responseText);
				}
				if (xhttp.readyState == 4 && xmlhttp.status == 200)
				{
					// What you want to do on success
					console.log("GOOD!");
				}
			}
			xhttp.open("POST", "http://localhost:3000/visits", true);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.setRequestHeader("Cache-Control", "no-cache");
			var data = "visitee="+visitee;
			data = data + "&visitor="+visitor;
			data = data + "&organization="+organization;
			data = data + "&citizenship="+citizenship;
			data = data + "&purpose="+purpose;
			data = data + "&badge="+badge;
			xhttp.send(data);
                }
        }
        xmlhttp.open("POST", "http://localhost:3000/badges", true);
	xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Cache-Control", "no-cache");
	var badgedata = "badge="+badge;
        xmlhttp.send(badgedata);

}

