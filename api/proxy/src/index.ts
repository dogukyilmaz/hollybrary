import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { errorHandler } from './middleware/errorHandler';
import fetch from 'node-fetch';
(globalThis as any).fetch = fetch;

//
dotenv.config();
import homeRouter from './routes/home';
import favRouter from './routes/fav';

const app: Express = express();
const port = process.env.PORT || 4500;

console.log(process.env.TMDB_BASE_URL, 'process.env.TMDB_BASE_URL');

app.use(express.json());
app.use(cors());

app.get('/', (req: Request, res: Response) => {
  res.send('Welcome to the Hollybrary API');
});

app.use('/home', homeRouter);
app.use('/fav', favRouter);

app.use(errorHandler);

app.listen(port, () => {
  console.log(`[proxy]: Server is running at http://localhost:${port}`);
});
