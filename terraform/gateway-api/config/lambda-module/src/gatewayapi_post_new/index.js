"use strict";

const axios = require("axios");

const BACKEND_INGRESS_URL = process.env.BACKEND_INGRESS_URL;

exports.handler = async (event) => {
	let message = "";

	// Obtain payload from query params or body.
	if (event.queryStringParameters) {
		message = event.queryStringParameters.message;
	} else if (event.body) {
		const reqBody = JSON.parse(event.body);

		message = reqBody.message;
	} else {
		return {
			statusCode: 400,
			headers: {
				"Content-Type": "application/json; charset=utf-8"
			},
			body: JSON.stringify({ error: "Invalid request format." })
		};
	}

	try {
		await axios.post(`${BACKEND_INGRESS_URL}/new-post/?message=${message}`);

		return {
			statusCode: 200,
			headers: {
				"Content-Type": "application/json; charset=utf-8"
			},
			body: JSON.stringify({ message: "Request received." })
		};
	} catch (err) {
		return {
			statusCode: 500,
			headers: {
				"Content-Type": "application/json; charset=utf-8"
			},
			body: JSON.stringify(err.stack)
		};
	}
};
