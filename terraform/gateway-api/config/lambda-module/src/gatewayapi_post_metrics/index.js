"use strict";

async function handler(event, context, callback) {
  sendDistributionMetric(
    "releaseapp.lambdaEdge.customerClick",
    1,
    `hostname:${"none"}`,
    `clicked_from:${"none"}`,
    `account_name:${"none"}`,
    `domainname:${"none"}`
  );

  const response = {
    statusCode: 200,
    headers: {
      "Content-Type": "text/html; charset=utf-8",
    },
    body: "<p>Hello world!</p>",
  };
  callback(null, response);
}

exports.handler = handler;
