import express from 'express';
import ApiRouter from './api';

const router = express.Router();

//api
router.use('/api/v1', ApiRouter);

export default router;