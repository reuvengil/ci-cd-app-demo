import request from "supertest";
import assert from "assert";
import app from "../app.js";

console.log("start testing...");

describe("Test 1", () => {
  it("GET /", async () => {
    const res1 = await request(app)
      .get("/")
      .expect("Content-Type", /json/)
      .expect(200);
    assert.deepEqual(
      res1.body,
      { message: "Hello World" },
      "not expected body"
    );
  });
  it("GET /health", async () => {
    await request(app).get("/health").expect(200);
  });
});
