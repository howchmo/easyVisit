var express = require('express');
var app = express();
//var router = express.Router();
var pgp = require("pg-promise")(/* options */);
var db = pgp("postgres://postgres:postgres@localhost:5432/easyvisit");
var bodyParser = require('body-parser');

app.set('view engine', 'jade');

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

/* GET home page. */
/*
app.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
*/

function getVisitees( req, res, next )
{
        db.any('select * from visitees').then(
                function( data )
                {
                        res.status(200).json(
                        {
                        	status: 'success',
                                data: data,
                                message: 'Retrieved the visitees'
                        });
                }
        ).catch( function(err)
        {
        	return next(err);
        });
}

function checkBadge( req, res, next )
{
	var badge = req.body.badge;
	db.one("select visit from visits where badge='"+badge+"' and departure is null order by arrival desc limit 1;")
	.then( function( data )
	{
		// The badge is checked out
		// return badge
		db.none("update visits set departure=NOW() where visit="+data.visit+";")
		.then( function( data )
		{
			res.status(201).json(
			{
				status: 'success',
				message: 'badge returned'
			});
		})
		.catch( function( err )
		{
			res.status(500).json(
			{
				status: 'problem',
				message: 'badge was not returned',
				error: err
			});
		});
	}).catch( function( err )
	{
		// The badge is not checked out
		// check that it is valid
		db.one("select badge from badges where badge='"+badge+"';")
		.then( function( data )
		{
			res.status(200).json(
			{
				status: 'success',
				message: 'badge is available for use'
			});
		})
		.catch( function( err )
		{
			res.status(404).json(
			{
				status: 'invalid',
				message: 'badge number is not valid',
				error: err
			});
		});
	});
}

function createVisit( req, res, next )
{
	console.log(req.body);
	if( true ) // test for bad data from the client
	{
		// see if the name and organization of the user have been added before
		var visitor = -1;
		var str = "select visitor, name, organization from visitors where name='"+req.body.visitor+"' and organization='"+req.body.organization+"'";
		db.one(str).then(
			function( data )
			{
				console.log(data);
				console.log("//  get the returning vistor's id");
				visitor = parseInt(data.visitor);
				console.log("visitor = "+visitor);
				str = "insert into visits (visitee, visitor, purpose, badge) values ("+parseInt(req.body.visitee)+", "+visitor+", '"+req.body.purpose+"', '"+req.body.badge+"')";
				db.none(str).then
				(
					function()
					{
						res.status(200).json(
						{
							status: 'success',
							message: 'inserted one visit'
						});
					}
				).catch(
					function()
					{
						return next(err);
					}
				);
			}
		).catch(
			function( err )
			{
				console.log("// insert new visitor and get his id");
				db.one("insert into visitors (name, organization, citizenship ) values ('"+req.body.visitor+"', '"+req.body.organization+"', '"+req.body.citizenship+"') returning visitor;")
				.then(
					function( data )
					{
						visitor = parseInt(data.visitor);
						console.log("visitor = "+visitor);
						str = "insert into visits (visitee, visitor, purpose, badge) values ("+parseInt(req.body.visitee)+", "+visitor+", '"+req.body.purpose+"', '"+req.body.badge+"')";
						console.log(str);
						db.none(str).then
						(
							function()
							{
								res.status(200).json(
								{
									status: 'success',
									message: 'inserted one visit'
								});
							}
						).catch(
							function()
							{
								return next(err);
							}
						);
					}
				).catch(
					function(err)
					{
						return next(err);
					}
				);
			}
		);
	}
}

app.get('/visitees', getVisitees);
app.post('/visits', createVisit);
app.post('/badges', checkBadge);

app.use(express.static('public'));

app.listen(3000, function() {
	console.log('Listening on port 3000');
});

//module.exports = router;

