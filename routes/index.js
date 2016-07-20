var express = require('express');
var router = express.Router();
var pgp = require("pg-promise");
var db = pgp("postgres:://postgres:postgres@localhost:5432/easyvisit");

/* GET home page. */
/*
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
*/

router.get('/easyVisit/visitees', db.getVisitees);
router.get('/easyVisit/visits', db.getVisits);
router.post('/easyVisit/visits', db.createVisit);


function db.getVistees( req, res, next )
{
	db.any('select * from visitees').then(
		function( data )
		{	
			res.status(200).json(
				{
					status: 'success',
					data: data,
					message: 'Retrieved the visitees'
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

function db.getVisits( req, res, next )
{
	
}

function db.createVisit( req, res, next )
{

}

module.exports = router;
