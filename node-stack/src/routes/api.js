import { Router } from "express";
const router = Router();

router.get('/healthz', (_, res)=>{
  res.json({status: "UP"});
});

export default router;