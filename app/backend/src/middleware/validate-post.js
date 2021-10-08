function validatePost(req, res, next) {
	const { name, message } = req.body;

	if (name && message) {
		next();
	} else {
		res.status(400).send({ error: "Missing parameter(s) in request body." });
	}
}

module.exports = { validatePost };
