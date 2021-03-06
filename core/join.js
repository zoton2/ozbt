
var util = require("../util.js");
var db = require("../mysqlHelpers.js");
var consts = require("../consts.js");
var user = JSON.parse(process.env.user);

// Get arguments.
var args = process.env.message.split(" ");

var static = {
	"help": "!join"
};
module.exports = static;

if("#" + user.username === process.env.channel){
	process.send({
		"action": "join_channel",
		"channel": "#" + user.username
	});

	db.insert(db.db(), "channel", {
		"Channel": "#" + user.username,
		"JoinOnAppOpen": consts.true
	});
}
