require("dotenv").config();
const app = require("./src/app");
const { PORT } = require("./src/config/constants");

// Listen on all network interfaces (0.0.0.0) to allow external connections
const HOST = "0.0.0.0";

app.listen(PORT, HOST, () => {
  console.log(`CarLi_ET backend running on http://${HOST}:${PORT}`);
  console.log(`Health check: http://localhost:${PORT}/health`);
});
