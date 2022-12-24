import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import morgan from 'morgan';
import { errorHandler } from './middleware/errorHandler';
import fetch from 'node-fetch';
(globalThis as any).fetch = fetch;

dotenv.config();

import homeRouter from './routes/home';
import favRouter from './routes/fav';
import movieRouter from './routes/movie';
import serieRouter from './routes/serie';
import searchRouter from './routes/search';
import genreRouter from './routes/genre';
import seasonRouter from './routes/season';
import castRouter from './routes/cast';

const app: Express = express();
const port = process.env.PORT || 4500;

app.use(express.json());
app.use(cors());
app.use(morgan('dev'));

app.get('/', (req: Request, res: Response) => {
  res.send('Welcome to the Hollybrary API');
});

app.use('/fav', favRouter);
app.use('/api/home', homeRouter);
app.use('/api/movie', movieRouter);
app.use('/api/tv', serieRouter);
app.use('/api/search', searchRouter);
app.use('/api/genre', genreRouter);
app.use('/api/tv', seasonRouter);
app.use('/api/cast', castRouter);

app.use(errorHandler);

app.listen(port, () => {
  console.log(`[proxy]: Server is running at http://localhost:${port}`);
});
