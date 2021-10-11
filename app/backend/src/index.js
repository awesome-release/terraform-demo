require("dotenv").config();

const port = process.env.PORT || 5000;

const express = require("express");
const cors = require("cors");
const morgan = require("morgan");
const { validatePost } = require("./middleware/validate-post");

const server = express();

server.use(cors());

morgan.token("query", (req, res) => JSON.stringify(req.query));
server.use(morgan(":method :url :status :response-time ms - :query"));

server.post("/new-post", validatePost, (req, res) => {
	res.sendStatus(201);
});

server.get("/", (req, res) => {
	res.sendStatus(200);
});

server.use((err, req, res, next) => {
	console.error(err.stack);
	res.status(500).send(err);
});

server.listen(port, () => {
	console.log(`Server listening on port ${port}.`);
});
