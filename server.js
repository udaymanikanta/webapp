const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send("Hello from your Node.js app running inside Docker & Ansible!");
});

app.listen(80, () => {
  console.log("Server running on port 80");
});
