const router = require("express").Router();
const slackBot = require("../client");

const { validatePost } = require("../middleware/validate-post");

router.get("/", (req, res) => {
	res.sendStatus(200);
});

router.post("/new-post", validatePost, async (req, res) => {
	if (Number(process.env.SLACK_ACTIVE)) {
		const { message } = req.query;

		try {
			await slackBot.chat.postMessage({
				token: process.env.SLACK_TOKEN,
				channel: process.env.SLACK_CHANNEL_ID,
				text: `${message}`
			});

			res.sendStatus(201);
		} catch (err) {
			console.error(err.stack);
			res.status(500).send(err);
		}
	} else {
		res.sendStatus(201);
	}
});

router.use((err, req, res, next) => {
	console.error(err.stack);
	res.status(500).send(err);
});

module.exports = router;
