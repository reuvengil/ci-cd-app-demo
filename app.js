import { } from 'dotenv/config'
import express from 'express';
const app = express();

app.get('/', (req, res) => {
    res.status(200).json({
        message: 'Hello Worl'
    });
});


app.get('/health', function (req, res) {
    res.sendStatus(200);
});

const port = process.env.PORT || 3000
app.listen(port, () => {
    console.log(`app is running on port ${port}`);
});
export default app;