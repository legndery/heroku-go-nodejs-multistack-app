import express from 'express';
import router from './routes';

const app = express();
const PORT = process.env.PORT || 8080;

app.use(router);

app.listen(PORT, () => {
  console.log(`Application running at ${PORT}`);
});