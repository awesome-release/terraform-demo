require("dotenv").config();

const express = require("express");
const cors = require("cors");
const morgan = require("morgan");

const routes = require("./routes");

const server = express();

server.use(cors());

morgan.token("query", (req, res) => JSON.stringify(req.query));
server.use(morgan(":method :url :status :response-time ms - :query"));

server.use("/", routes);

const port = process.env.PORT || 5000;

server.listen(port, () => {
	console.log(`Server listening on port ${port}.`);
});
