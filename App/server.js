const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const app = express();
app.use(bodyParser.urlencoded({ extended: false }));
const port = 3000;

app.use(express.json());

const db = mysql.createConnection({
   host: "localhost",
   user: "Jay_Jay",
   password: "secretpassword",
   database: "alphaQ",
});

db.connect((err) => {
   if (err) {
      throw err;
   }
   console.log("Connected");
});
var data;
app.get("/", (req, res) => {
   res.sendFile(__dirname + "/public/index.html");
});

app.get("/getJSONMoM", (req, res) => {
   db.query("SELECT * FROM MoMs", (err, rows, fields) => {
      if (err) {
         throw err;
      }
      res.send(JSON.stringify(rows));
   });
});

app.post("/login", (req, res) => {
   let username = req.body.username;
   let password = req.body.password;
   if (username === "Anu Rag" && password === "secretpassword") {
      res.sendFile(__dirname + "/public/table.html");
   } else {
      res.send("Wrong Credentials");
   }
});

app.post("/savedata", (req, res) => {
   const content = req.body.content;
   const date = req.body.mom_date;
   console.log(date, content);
   db.query(
      "UPDATE MoMs SET content=? WHERE mom_date=?",
      [content, date],
      (err, rows, fields) => {
         if (err) {
            throw err;
         } else {
            console.log(rows);
            res.sendFile(__dirname + "/public/table.html");
         }
      }
   );
});

app.listen(port, () => console.log(`http://localhost:${port}`));
