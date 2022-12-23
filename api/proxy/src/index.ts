import express, { Express, Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import { errorHandler } from 'middleware/errorHandler';
import path from 'node:path';

//
dotenv.config({ path: path.resolve(__dirname, '../.env') });
import homeRouter from 'routes/home';

const app: Express = express();
const port = process.env.PORT || 4500;

app.use(express.json());
app.use(cors());

app.get('/', (req: Request, res: Response) => {
  res.send('Welcome to the Hollybrary API');
});

app.use('/home', homeRouter);

app.use(errorHandler);

app.listen(port, () => {
  console.log(`[proxy]: Server is running at http://localhost:${port}`);
});
