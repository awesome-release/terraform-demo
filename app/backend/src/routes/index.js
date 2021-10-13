const router = require("express").Router();

const { validatePost } = require("../middleware/validate-post");

router.get("/", (req, res) => {
	res.sendStatus(200);
});

router.post("/new-post", validatePost, async (req, res) => {
	res.sendStatus(201);
});

router.use((err, req, res, next) => {
	console.error(err.stack);
	res.status(500).send(err);
});

module.exports = router;
