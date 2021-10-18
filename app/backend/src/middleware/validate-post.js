function validatePost(req, res, next) {
	const { message } = req.query;

	if (message && message.length > 0) {
		next();
	} else {
		res.status(400).send({ error: "Message missing in request." });
	}
}

module.exports = { validatePost };
