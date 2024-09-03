import express from "express";
import bodyParser from "body-parser";
import pg from "pg";

const app = express();
const port = 3000;

// Database connection setup
const db = new pg.Client({
  user: "postgres",
  host: "localhost",
  database: "Project",  // Ensure the database name is correct and without spaces
  password: "Sim'sData",
  port: 5432,
});
db.connect();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));

let currentUserId = 1;
let users = [
  { id: 1, name: "Anwaar", color: "teal" },
  { id: 2, name: "Altaf", color: "powderblue" },
];

// Function to check visited countries
async function checkVisited() {
  try {
    const result = await db.query(
      "SELECT country_code FROM visited_countries JOIN users ON users.id = user_id WHERE user_id = $1;",
      [currentUserId]
    );
    let countries = [];
    result.rows.forEach((country) => {
      countries.push(country.country_code);
    });
    return countries;
  } catch (err) {
    console.error("Error checking visited countries:", err);
  }
}

// Function to get the current user
async function getCurrentUser() {
  try {
    const result = await db.query("SELECT * FROM users");
    users = result.rows;
    return users.find((user) => user.id == currentUserId);
  } catch (err) {
    console.error("Error getting current user:", err);
  }
}

// Route to render the homepage
app.get("/", async (req, res) => {
  try {
    const countries = await checkVisited();
    const currentUser = await getCurrentUser();
    res.render("index.ejs", {
      countries: countries,
      total: countries.length,
      users: users,
      color: currentUser ? currentUser.color : "defaultColor",
    });
  } catch (err) {
    console.error("Error rendering homepage:", err);
  }
});

// Route to add a country
app.post("/add", async (req, res) => {
  const input = req.body["country"];
  const currentUser = await getCurrentUser();

  try {
    const result = await db.query(
      "SELECT country_code FROM countries WHERE LOWER(country_name) LIKE '%' || $1 || '%';",
      [input.toLowerCase()]
    );

    const data = result.rows[0];
    if (data) {
      const countryCode = data.country_code;
      await db.query(
        "INSERT INTO visited_countries (country_code, user_id) VALUES ($1, $2)",
        [countryCode, currentUserId]
      );
      res.redirect("/");
    } else {
      console.error("Country not found");
      res.redirect("/");
    }
  } catch (err) {
    console.error("Error adding country:", err);
  }
});

// Route to change or add a user
app.post("/user", async (req, res) => {
  if (req.body.add === "new") {
    res.render("new.ejs");
  } else {
    currentUserId = req.body.user;
    res.redirect("/");
  }
});

// Route to add a new user
app.post("/new", async (req, res) => {
  const name = req.body.name;
  const color = req.body.color;

  try {
    const result = await db.query(
      "INSERT INTO users (name, color) VALUES($1, $2) RETURNING *;",
      [name, color]
    );

    const id = result.rows[0].id;
    currentUserId = id;

    res.redirect("/");
  } catch (err) {
    console.error("Error adding new user:", err);
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on http://localhost:${3000}`);
});
